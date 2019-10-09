//
//  MoviesListActions.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Combine
import NetworkKit

class MoviesListActions {

	let moviesNetwork: Network

	init(moviesNetwork: Network) {
		self.moviesNetwork = moviesNetwork
	}

	private var request: Cancellable?

	func fetchMovies(into model: MoviesListModel) {
		request = moviesNetwork
			.request(FetchPopularMovies())
			.loading(into: \.isLoading, on: model)
			.map { $0.results }
			.replaceError(with: [])
			.assign(to: \.movieSummaries, on: model)
	}

	deinit {
		request?.cancel()
	}
}
