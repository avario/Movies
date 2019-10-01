//
//  NetworkService.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine

open class NetworkService {

	public let baseURL: URL
	open var persistentParameters: Parameters = [:]

	public init(baseURL: URL) {
		self.baseURL = baseURL
	}

	open func request<R: NetworkRequest>(_ request: R) -> AnyPublisher<R.Response, NetworkError> {

		let parametersData = try! JSONEncoder().encode(request.parameters)
		var parameters = try! JSONSerialization.jsonObject(with: parametersData, options: .allowFragments) as! Parameters
		parameters = parameters.merging(persistentParameters, uniquingKeysWith: { (first, _) -> CustomStringConvertible in
			return first
		})

		let url = baseURL.appendingPathComponent(request.path)
		var urlRequest: URLRequest

		switch request.encoding {
		case .url:
			var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
			urlComponents.queryItems = parameters.map { parameter in
				URLQueryItem(name: parameter.key, value: parameter.value.description)
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
			.eraseToAnyPublisher()
	}

	public typealias Parameters = [String: CustomStringConvertible]

	public enum ParameterEncoding {
		case url
		case json
	}

	public enum HTTPMethod: String {
		case connect
		case delete
		case get
		case head
		case options
		case patch
		case post
		case put
		case trace
	}

}
