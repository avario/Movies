//
//  File.swift
//  
//
//  Created by Avario Babushka on 18/10/19.
//

import Foundation

public protocol NetworkDataRequest {

    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters { get }

    func previewAssetName(for network: Network) -> String

    associatedtype Parameters: Encodable = EmptyParameters
}

public struct EmptyParameters: Encodable { }

public extension NetworkDataRequest {

    var parameters: EmptyParameters {
        return EmptyParameters()
    }

    var encoding: ParameterEncoding {
        return .url
    }

    func previewAssetName(for network: Network) -> String {
        let localURL = network.baseURL.appendingPathComponent(path)
        var localName = localURL.absoluteString
        if let scheme = localURL.scheme {
            localName = localName.replacingOccurrences(of: scheme, with: "").replacingOccurrences(of: "://", with: "")
        }

        return localName
    }
}

public struct AnyNetworkDataRequest: NetworkDataRequest {
    public let method: HTTPMethod
    public let path: String
    public let encoding: ParameterEncoding
    public let parameters: Encodable
    public let previewAssetName: (Network) -> String

    public init<R: NetworkDataRequest>(_ request: R) {
        method = request.method
        path = request.path
        encoding = request.encoding
        parameters = request.parameters
        previewAssetName = request.previewAssetName
    }

}
