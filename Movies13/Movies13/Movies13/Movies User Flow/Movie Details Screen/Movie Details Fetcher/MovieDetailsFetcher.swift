//
//  MovieDetailsFetcher.swift
//  Movies13
//
//  Created by Avario Babushka on 26/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine

class MovieDetailsFetcher: ObservableObject {

	enum State {
		case notStarted
		case loading
		case error(message: String)
		case fetched(movieDetails: MovieDetails)
	}

	@Published var state: State = .notStarted

	func fetch(forMovieID movieID: Int, on moviesNetwork: MoviesNetwork) {
		guard case .notStarted = state else {
			return
		}

		state = .loading

		request = FetchMovieDetails(movieID: movieID)
			.request(on: moviesNetwork)
			.map { .fetched(movieDetails: $0) }
			.catch { error -> Just<State> in
				switch error {
				case .local:
					return Just(.error(message: "Failed to load movie details."))

				case .remote(let remoteError):
					return Just(.error(message: remoteError.message))
				}
			}
			.receive(on: RunLoop.main)
			.assign(to: \.state, on: self)
	}

	private var request: Cancellable?
}
