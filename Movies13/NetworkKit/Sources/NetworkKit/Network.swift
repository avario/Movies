//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine
import UIKit

public protocol Network {

	var baseURL: URL { get }
	var persistentParameters: Parameters { get }

	var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy { get }
	var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }

	var previewMode: NetworkPreviewMode { get }

	typealias Parameters = [String: Any]
}

public extension Network {

	var persistentParameters: Parameters { [:] }

	var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy { .deferredToDate }
	var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { .deferredToDate  }

	var previewMode: NetworkPreviewMode { .noPreview }

}

public enum NetworkPreviewMode {

	case automatic
	case success
	case loading
	case fail(error: NetworkError)
	case noPreview
}

public extension Network {

	func request<R: NetworkRequest>(_ request: R) -> AnyPublisher<R.Response, NetworkError> {

		switch previewMode {
		case .automatic:
			if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
				fallthrough
			}
		case .success:
			return Result.success(try! preview(request))
				.publisher.eraseToAnyPublisher()

		case .loading:
			return PassthroughSubject<R.Response, NetworkError>()
				.eraseToAnyPublisher()

		case .fail(let error):
			return Result.failure(error)
				.publisher.eraseToAnyPublisher()

		case .noPreview:
			break
		}

		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = dateEncodingStrategy

		let parametersData = try! encoder.encode(request.parameters)
		var parameters = try! JSONSerialization.jsonObject(with: parametersData, options: .allowFragments) as! Parameters
		parameters = parameters.merging(persistentParameters) { (_, persistent) in persistent }

		let url = baseURL.appendingPathComponent(request.path)
		var urlRequest: URLRequest

		switch request.encoding {
		case .url:
			var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
			urlComponents.queryItems = parameters.map { parameter in
				URLQueryItem(name: parameter.key, value: "\(parameter.value)")
			}

			urlRequest = URLRequest(url: urlComponents.url!)

		case .json:
			urlRequest = URLRequest(url: url)
			urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
		}

		urlRequest.httpMethod = request.method.rawValue

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = dateDecodingStrategy

		return URLSession.shared.dataTaskPublisher(for: urlRequest)
			.map { $0.data }
			.decode(
				type: R.Response.self,
				decoder: decoder)
			.mapError(NetworkError.init)
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}

	func image(at path: String) -> AnyPublisher<UIImage, NetworkError> {

		switch previewMode {
		case .automatic:
			if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
				fallthrough
			}
		case .success:
			return Result.success(try! previewImage(at: path))
				.publisher.eraseToAnyPublisher()

		case .loading:
			return PassthroughSubject<UIImage, NetworkError>()
				.eraseToAnyPublisher()

		case .fail(let error):
			return Result.failure(error)
				.publisher.eraseToAnyPublisher()

		case .noPreview:
			break
		}

		let url = baseURL.appendingPathComponent(path)

		return URLSession.shared
			.dataTaskPublisher(for: url)
			.tryMap {
				guard let image = UIImage(data: $0.data) else {
					throw NetworkError.unknown
				}
				return image
			}
			.mapError(NetworkError.init)
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}

	func previewImage(at path: String) throws -> UIImage {

		let url = baseURL.appendingPathComponent(path)
		let localURL = url.deletingPathExtension()
		var localName = localURL.absoluteString
		if let scheme = localURL.scheme {
			localName = localName.replacingOccurrences(of: scheme, with: "").replacingOccurrences(of: "://", with: "")
		}

		guard let image = UIImage(named: localName) else {
			throw NetworkError.unknown
		}

		return image
	}

	func preview<R: NetworkRequest>(_ request: R) throws -> R.Response {

		let localURL = baseURL.appendingPathComponent(request.path)
		var localName = localURL.absoluteString
		if let scheme = localURL.scheme {
			localName = localName.replacingOccurrences(of: scheme, with: "").replacingOccurrences(of: "://", with: "")
		}

		guard let asset = NSDataAsset(name: localName) else {
			throw NetworkError.unknown
		}

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = dateDecodingStrategy

		let result = try decoder.decode(R.Response.self, from: asset.data)
		
		return result
	}
	
}
