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
	case failure(error: NetworkError)
	case noPreview
}

public extension Network {

    func request<R: NetworkRequest>(_ request: R, previewMode: NetworkPreviewMode? = nil) -> AnyPublisher<R.Response, NetworkError> {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy

        return dataRequest(request, previewMode: previewMode)
            .decode(
                type: R.Response.self,
                decoder: decoder)
            .mapError(NetworkError.init)
            .eraseToAnyPublisher()
    }

    func dataRequest<R: NetworkDataRequest>(_ request: R, previewMode: NetworkPreviewMode? = nil) -> AnyPublisher<Data, NetworkError> {

        switch previewMode ?? self.previewMode {
        case .automatic:
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
                fallthrough
            }
        case .success:
            return Result.success(try! previewData(request))
                .publisher.eraseToAnyPublisher()

        case .loading:
            return PassthroughSubject<Data, NetworkError>()
                .eraseToAnyPublisher()

        case .failure(let error):
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

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .mapError(NetworkError.init)
            .eraseToAnyPublisher()
    }
}
