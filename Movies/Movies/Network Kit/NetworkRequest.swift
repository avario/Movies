//
//  NetworkRequest.swift
//  NetworkKit
//
//  Created by Avario on 26/05/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation
import Alamofire

public protocol NetworkRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters { get }
    
    associatedtype Parameters: Encodable = EmptyParameters
    associatedtype Response: Decodable = EmptyResponse
}

public struct EmptyParameters: Encodable { }
public struct EmptyResponse: Encodable { }

public extension NetworkRequest {
    var parameters: EmptyParameters {
        return EmptyParameters()
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding()
    }
}
