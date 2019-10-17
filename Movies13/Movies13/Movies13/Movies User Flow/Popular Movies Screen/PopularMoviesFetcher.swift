//
//  PopularMoviesFetcher.swift
//  Movies13
//
//  Created by Avario Babushka on 9/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine

class PopularMoviesFetcher: ObservableObject {

	enum State {
		case loading
		case error(message: String)
		case fetched(movieSummaries: [MovieSummary])
	}

	@Published var state: State = .loading

	func fetch(from moviesNetwork: MoviesNetwork) {
		request = moviesNetwork
			.request(FetchPopularMovies())
			.map { .fetched(movieSummaries: $0.results) }
			.replaceError(with: .error(message: "Failed to load movies"))
			.assign(to: \.state, on: self)
	}

	private var request: Cancellable?
}
