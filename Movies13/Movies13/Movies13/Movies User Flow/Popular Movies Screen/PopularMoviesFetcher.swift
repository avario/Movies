//
//  PopularMoviesFetcher.swift
//  Movies13
//
//  Created by Avario Babushka on 9/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import Combine

class PopularMoviesFetcher: ObservableObject {

	@Published var movieSummaries: [MovieSummary] = []

	func fetch(from moviesNetwork: MoviesNetwork) {
		request = FetchPopularMovies()
			.request(on: moviesNetwork)
			.map { $0.results }
			.replaceError(with: [])
			.receive(on: DispatchQueue.main)
			.assign(to: \.movieSummaries, on: self)
	}

	private var request: Cancellable?
}
