//
//  NetworkPreview.swift
//  
//
//  Created by Avario Babushka on 8/10/19.
//

import Foundation
import UIKit

struct NetworkPreview<N: Network> {

    let networkService: Network

    public func request<R: NetworkRequest>(_ request: R) throws -> R.Response {
        let localURL = networkService.baseURL.appendingPathComponent(request.path)
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

extension Network {
    var preview: NetworkPreview<Self> {
        return NetworkPreview(networkService: self)
    }
}
