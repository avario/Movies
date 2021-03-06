//
//  MoviesNetworkService.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import FormatKit
import Foundation
import NetworkKit

class MoviesNetwork: Network, ObservableObject {
	let baseURL: URL = Configuration.shared.baseURL
	let parameters: APICredentials = .init(apiKey: Configuration.shared.apiKey)

	static let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy =
		.formatted(
			DateFormatter()
				.dateFormat("yyyy-MM-dd"))

	struct APICredentials: Encodable {
		let apiKey: String

		enum CodingKeys: String, CodingKey {
			case apiKey = "api_key"
		}
	}

	struct RemoteError: Decodable {
		let code: Int
		let message: String

		enum CodingKeys: String, CodingKey {
			case code = "status_code"
			case message = "status_message"
		}
	}
}
