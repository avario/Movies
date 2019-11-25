//
//  PopularMoviesScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 19/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

extension PopularMoviesScreen {
	struct Content: View {
		let state: PopularMoviesFetcher.State

		var body: some View {
			content
				.navigationBarTitle("Popular Movies")
		}

		var content: AnyView {
			switch state {
			case .notStarted, .loading:
				return ActivityIndicator()
					.eraseToAnyView()

			case .error(let message):
				return Text(message)
					.foregroundColor(.secondary)
					.eraseToAnyView()

			case .fetched(let movieSummaries):
				return PopularMoviesList(movieSummaries: movieSummaries)
					.eraseToAnyView()
			}
		}
	}
}

struct PopularMoviesScreenContent_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			NavigationView {
				PopularMoviesScreen.Content(
					state: .fetched(movieSummaries: [MovieSummary].preview("MovieSummaries", decoder: MoviesNetwork.decoder)))
			}.previewDisplayName("Fetched")

			NavigationView {
				PopularMoviesScreen.Content(
					state: .loading)
			}.previewDisplayName("Loading")

			NavigationView {
				PopularMoviesScreen.Content(
					state: .error(message: "Failed to load movies."))
			}.previewDisplayName("Error")
		}
		.previewLayout(.sizeThatFits)
	}
}
