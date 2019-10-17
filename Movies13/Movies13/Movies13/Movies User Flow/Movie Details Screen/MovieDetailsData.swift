//
//  MovieDetailsData.swift
//  Movies13
//
//  Created by Avario Babushka on 4/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine

class MovieDetailsData: ObservableObject {

	private var request: Cancellable?

	func fetchMovieDetails(for movieSummary: MovieSummary, from moviesNetwork: MoviesNetwork, into movieDetailsScreen: MovieDetailsScreen) {
		request = moviesNetwork
			.request(FetchMovieDetails(movieId: movieSummary.id))
			.map { Optional($0) }
			.replaceError(with: nil)
			.assign(to: \.movieDetails, on: movieDetailsScreen)
	}

	deinit {
		request?.cancel()
	}
}
