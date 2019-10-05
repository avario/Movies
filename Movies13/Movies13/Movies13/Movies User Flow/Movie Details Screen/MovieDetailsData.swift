//
//  MovieDetailsData.swift
//  Movies13
//
//  Created by Avario Babushka on 4/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine
import NetworkKit

class MovieDetailsData: ObservableObject {

	@Published var isLoading: Bool = false
	@Published var movieDetails: MovieDetails?

	private var request: Cancellable?

	func fetchMovieDetails(for movieSummary: MovieSummary, from moviesNetwork: MoviesNetwork) {
		request = moviesNetwork
			.request(FetchMovieDetails(movieId: movieSummary.id))
			.loading(into: \.isLoading, on: self)
			.map { Optional($0) }
			.replaceError(with: nil)
			.assign(to: \.movieDetails, on: self)
	}

	deinit {
		request?.cancel()
	}

}
