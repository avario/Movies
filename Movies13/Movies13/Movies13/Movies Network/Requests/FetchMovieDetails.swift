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
	
	let method: HTTPMethod = .get
	let path: String

	init(movieId: Int) {
		path = "movie/" + String(movieId)
	}

	typealias Response = MovieDetails
}
