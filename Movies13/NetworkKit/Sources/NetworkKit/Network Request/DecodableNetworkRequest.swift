//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

public protocol NetworkRequest: NetworkDataRequest {

	associatedtype Response: Decodable = EmptyResponse
}

public struct EmptyResponse: Encodable { }
