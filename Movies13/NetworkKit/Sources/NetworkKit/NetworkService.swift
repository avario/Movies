//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine

open class NetworkService: ObservableObject {

    public enum Source {
        case local
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
        case .local:

            let localURL = baseURL.appendingPathComponent(request.path)
            var localName = localURL.absoluteString
            if let scheme = localURL.scheme {
                localName = localName.replacingOccurrences(of: scheme, with: "")
            }

            do {
                guard let file = Bundle.main.url(forResource: localName, withExtension: nil) else {
                        throw NetworkError.unknown
                }

                let data = try Data(contentsOf: file)
                let result = try JSONDecoder().decode(R.Response.self, from: data)

                return Result.success(result)
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

public extension Publisher {

    func loading<Root>(into keyPath: ReferenceWritableKeyPath<Root, Bool>, on object: Root) -> AnyPublisher<Self.Output, Self.Failure> {

        return self.handleEvents(
            receiveSubscription: { _ in object[keyPath: keyPath] = true},
            receiveCompletion: { _ in object[keyPath: keyPath] = false},
            receiveCancel: { object[keyPath: keyPath] = false})
            .eraseToAnyPublisher()
    }

}
