//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine
import UIKit

open class Network: ObservableObject {

	public let baseURL: URL
	open var persistentParameters = Parameters()

	public init(baseURL: URL) {
		self.baseURL = baseURL
	}

	public typealias Parameters = [String: Any]

	internal enum Setting {
		case preview
		case network
	}

	internal var setting: Setting = .network

	public func alwaysPreview() -> Self {
		setting = .preview
		return self
	}
}

public extension Network {

	func request<R: NetworkRequest>(_ request: R) -> AnyPublisher<R.Response, NetworkError> {
		switch setting {
		case .preview:
			do {
				return Result.success(try preview(request))
					.publisher.eraseToAnyPublisher()

			} catch {
				return Result.failure(NetworkError.unknown)
					.publisher.eraseToAnyPublisher()
			}

		case .network:
			return network(request)
		}
	}

	private func network<R: NetworkRequest>(_ request: R) -> AnyPublisher<R.Response, NetworkError> {

		let parametersData = try! JSONEncoder().encode(request.parameters)
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

		return URLSession.shared.dataTaskPublisher(for: urlRequest)
			.map { $0.data }
			.decode(
				type: R.Response.self,
				decoder: JSONDecoder())
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

        return try JSONDecoder().decode(R.Response.self, from: asset.data)
	}
	
}
