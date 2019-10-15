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
	let persistentParameters: Parameters = ["api_key": Configuration.shared.apiKey]

	let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy =
		.formatted(
			DateFormatter()
				.dateFormat("yyyy-MM-dd"))
}
