//
//  MoviesNetworkService.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import NetworkKit
import FormatKit

class MoviesNetwork: Network, ObservableObject {

	let baseURL: URL = Configuration.shared.baseURL
	let persistentParameters: APICredentials = .init(apiKey: Configuration.shared.apiKey)

	let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy =
		.formatted(
			DateFormatter()
				.dateFormat("yyyy-MM-dd"))

	struct APICredentials: Encodable {
		let apiKey: String

		enum CodingKeys: String, CodingKey {
			case apiKey = "api_key"
		}
	}

	struct ErrorContent: Decodable {
		let code: Int
		let message: String

		enum CodingKeys: String, CodingKey {
			case code = "status_code"
			case message = "status_message"
		}
	}
}
