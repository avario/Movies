//
//  MoviesListData.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine
import NetworkKit

class MoviesListData: ObservableObject {

	@Published var isLoading: Bool = false
	@Published var movieSummaries: [MovieSummary] = []

	private var request: Cancellable?

	func fetchMovies(from moviesNetwork: MoviesNetwork) {
		request = moviesNetwork
			.request(FetchPopularMovies())
			.loading(into: \.isLoading, on: self)
			.map { $0.results }
			.replaceError(with: [])
			.assign(to: \.movieSummaries, on: self)
	}

	deinit {
		request?.cancel()
	}

}
