//
//  MovieDetailsFetcher.swift
//  Movies13
//
//  Created by Avario Babushka on 4/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine

class MovieDetailsFetcher: ObservableObject {
	
	enum State {
		case loading
		case error(message: String)
		case fetched(movieDetails: MovieDetails)
	}

	@Published var state: State = .loading

	func fetch(forMovieID movieID: Int, from moviesNetwork: MoviesNetwork) {
		request = moviesNetwork
			.request(FetchMovieDetails(movieID: movieID))
			.map { .fetched(movieDetails: $0) }
			.replaceError(with: .error(message: "Failed to load movie details."))
			.assign(to: \.state, on: self)
	}

	private var request: Cancellable?
}
