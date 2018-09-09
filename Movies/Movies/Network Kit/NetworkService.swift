//
//  NetworkService.swift
//  NetworkKit
//
//  Created by Avario on 07/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift
import Result

open class NetworkService {
    
    open let baseURL: URL
    open let sessionManager: SessionManager
    open var persistentParameters: Parameters = [:]
    
    public init(baseURL: URLConvertible, sessionManager: SessionManager = SessionManager.default) {
        self.baseURL = try! baseURL.asURL()
        self.sessionManager = sessionManager
    }
    
    @discardableResult public func request<R: NetworkRequest>(_ request: R, completionHandler: @escaping (DataResponse<R.Response>) -> Void) -> Request {
        
        let parametersData = try! JSONEncoder().encode(request.parameters)
        var parameters = try! JSONSerialization.jsonObject(with: parametersData, options: .allowFragments) as! Parameters
        parameters = parameters.merging(persistentParameters, uniquingKeysWith: { (first, _) -> Any in
            return first
        })
        
        return sessionManager.request(
            baseURL.appendingPathComponent(request.path),
            method: request.method,
            parameters: parameters,
            encoding: request.encoding,
            headers: nil)
        .responseJSONDecodable(completionHandler: completionHandler)
    }
    
}

public enum NetworkError: Error {
    case unknown
}

extension NetworkService: ReactiveExtensionsProvider {}

public extension Reactive where Base: NetworkService {
    public func request<R: NetworkRequest>(_ request: R) -> SignalProducer<R.Response, NetworkError> {
        return SignalProducer { [weak base] observer, lifetime in
            let cancellableRequest = base?.request(request) { result in
                switch result.result {
                case .success(let response):
                    observer.send(value: response)
                    observer.sendCompleted()
                case .failure(let error):
                    print(error)
                    observer.send(error: .unknown)
                }
            }
            
            lifetime.observeEnded {
                cancellableRequest?.cancel()
            }
        }
    }
}
