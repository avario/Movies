//
//  MoviesListData.swift
//  Movies13
//
//  Created by Avario Babushka on 9/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine

class MoviesListData: ObservableObject {

	enum FetchMoviesState {
		case loading
		case error(message: String)
		case loaded(movieSummaries: [MovieSummary])
	}

	@Published var fetchMoviesState: FetchMoviesState = .loading

	private var request: Cancellable?

	func fetchMovies(from moviesNetwork: MoviesNetwork) {
		request = moviesNetwork
			.request(FetchPopularMovies())
			.map { .loaded(movieSummaries: $0.results) }
			.replaceError(with: .error(message: "Failed to load movies"))
			.assign(to: \.fetchMoviesState, on: self)
	}

	deinit {
		request?.cancel()
	}
}
