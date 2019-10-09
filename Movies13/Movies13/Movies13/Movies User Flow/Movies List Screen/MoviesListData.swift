//
//  MoviesListData.swift
//  Movies13
//
//  Created by Avario Babushka on 9/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine

class MoviesListData {

	private var request: Cancellable?

	func fetchMovies(from moviesNetwork: MoviesNetwork, into moviesListScreen: MoviesListScreen) {
		request = moviesNetwork
			.request(FetchPopularMovies())
			.map { $0.results }
			.replaceError(with: [])
			.load(to: \.isLoading, on: moviesListScreen)
			.assign(to: \.movieSummaries, on: moviesListScreen)
	}

	deinit {
		request?.cancel()
	}
}
