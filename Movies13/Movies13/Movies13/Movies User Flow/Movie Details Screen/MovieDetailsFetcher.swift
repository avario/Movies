//
//  MovieDetailsFetcher.swift
//  Movies13
//
//  Created by Avario Babushka on 4/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
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
			.catch { error -> Just<State> in
				switch error {
				case .local:
					return Just(.error(message: "Failed to load movie details."))

				case .remote(_, let content):
					return Just(.error(message: content.message))
				}
			}
			.assign(to: \.state, on: self)
	}

	private var request: Cancellable?
}
