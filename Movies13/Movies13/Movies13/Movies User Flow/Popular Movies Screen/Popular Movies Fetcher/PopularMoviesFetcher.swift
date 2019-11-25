//
//  PopularMoviesFetcher.swift
//  Movies13
//
//  Created by Avario Babushka on 26/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

import Foundation
import Combine

class PopularMoviesFetcher: ObservableObject {

	enum State {
		case notStarted
		case loading
		case error(message: String)
		case fetched(movieSummaries: [MovieSummary])
	}

	@Published var state: State = .notStarted

	func fetch(on moviesNetwork: MoviesNetwork) {
		guard case .notStarted = state else {
			return
		}

		state = .loading

		request = FetchPopularMovies()
			.request(on: moviesNetwork)
			.map { .fetched(movieSummaries: $0.results) }
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
