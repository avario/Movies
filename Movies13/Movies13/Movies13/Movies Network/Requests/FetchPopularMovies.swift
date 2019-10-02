//
//  FetchPopularMovies.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import NetworkKit

struct FetchPopularMovies: NetworkRequest {
	let method: HTTPMethod = .get
	let path: String = "discover/movie"
	let parameters: Parameters

	init(sortBy: String =  "popularity.desc") {
		parameters = Parameters(sortBy: sortBy)
	}

	struct Response: Decodable {
		let page: Int
		let results: [MovieSummary]
	}

	struct Parameters: Encodable {
		let sortBy: String

		enum CodingKeys: String, CodingKey {
			case sortBy = "sort_by"
		}
	}
}
