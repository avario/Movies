//
//  Created by Avario Babushka on 18/10/19.
//

import Foundation
import UIKit

public extension Network {

    func previewData<R: NetworkDataRequest>(_ request: R) throws -> Data {

        let previewAssetName = request.previewAssetName(for: self)

        if let asset = NSDataAsset(name: previewAssetName) {
            return asset.data

        } else if let image = UIImage(named: previewAssetName) {
            return image.pngData()!

        } else {
            print("⚠️ No preview asset with name: \(previewAssetName)")
            throw NetworkError.unknown
        }
    }

    func preview<R: NetworkRequest>(_ request: R) throws -> R.Response {
        let previewData = try self.previewData(request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy

        return try decoder.decode(R.Response.self, from: previewData)
    }
}
