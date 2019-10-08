//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine

open class Network: ObservableObject {
	
	public enum Source {
		case preview
		case network
	}
	
	private let source: Source
	
	public let baseURL: URL
	open var persistentParameters: Parameters = [:]
	
	public init(baseURL: URL, source: Source) {
		self.baseURL = baseURL
		self.source = source
	}
	
	open func request<R: NetworkRequest>(_ request: R) -> AnyPublisher<R.Response, NetworkError> {
		
		switch source {
		case .preview:
			do {
				return Result.success(try self.preview.request(request))
					.publisher.eraseToAnyPublisher()
				
			} catch {
				return Result.failure(NetworkError.unknown)
					.publisher.eraseToAnyPublisher()
			}
			
		case .network:
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
	}
	
	public typealias Parameters = [String: Any]
	
}
