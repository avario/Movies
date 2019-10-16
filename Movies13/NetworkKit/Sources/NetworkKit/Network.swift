//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine

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

    var previewMode: NetworkPreviewMode { .automatic }
}

public enum NetworkPreviewMode {

    case automatic
    case alwaysPreview
    case loadIndefinitely
    case fail(error: NetworkError)
    case neverPreview
}

public extension Network {

	func request<R: NetworkRequest>(_ request: R) -> AnyPublisher<R.Response, NetworkError> {

        switch previewMode {
        case .automatic:
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
                fallthrough
            }
        case .alwaysPreview:
            return Result.success(try! preview(request))
                .publisher.eraseToAnyPublisher()

        case .loadIndefinitely:
            return PassthroughSubject<R.Response, NetworkError>()
                .eraseToAnyPublisher()

        case .fail(let error):
            return Result.failure(error)
                .publisher.eraseToAnyPublisher()

        case .neverPreview:
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
