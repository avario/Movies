//
//  MoviesNetworkService.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import NetworkKit

class MoviesNetwork: Network, ObservableObject {

	let baseURL: URL = URL(string: "https://api.themoviedb.org/3/")!
	let persistentParameters: Parameters = ["api_key": "7141478ba63e445f5cc58583ed4bbb45"]
}
