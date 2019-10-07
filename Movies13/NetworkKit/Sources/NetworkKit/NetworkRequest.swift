//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

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
		return .url
	}
	
}
