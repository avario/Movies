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

    typealias Parameters = [String: Any]
}

public extension Network {

	func request<R: NetworkRequest>(_ request: R) -> AnyPublisher<R.Response, NetworkError> {

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

		let result = try JSONDecoder().decode(R.Response.self, from: asset.data)
		
        return result
	}
	
}
