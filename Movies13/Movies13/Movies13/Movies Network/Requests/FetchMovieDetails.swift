//
//  FetchMovieDetails.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import NetworkKit

struct FetchMovieDetails: NetworkRequest {
	typealias Network = MoviesNetwork

	let method: HTTPMethod = .get
	let path: String

	init(movieID: Int) {
		path = "movie/" + String(movieID)
	}

	typealias Response = MovieDetails
}
