//
//  MovieDetailsScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 18/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

extension MovieDetailsScreen {
	struct Content: View {
		let title: String
		let state: MovieDetailsFetcher.State

		var body: some View {
			content
				.navigationBarTitle(title)
		}

		var content: AnyView {
			switch state {
			case .notStarted, .loading:
				return ActivityIndicator()
					.eraseToAnyView()

			case .error(let message):
				return	Text(message)
					.foregroundColor(.secondary)
					.eraseToAnyView()

			case .fetched(let movieDetails):
				return MovieDetailsView(movieDetails: movieDetails)
					.eraseToAnyView()
			}
		}
	}
}

struct MovieDetailsScreenContent_Previews: PreviewProvider {
	static let movieSummary = [MovieSummary].preview("MovieSummaries", decoder: MoviesNetwork.decoder)[0]

	static var previews: some View {
		Group {
			NavigationView {
				MovieDetailsScreen.Content(
					title: movieSummary.title,
					state: .fetched(movieDetails: MovieDetails.preview("MovieDetails", decoder: MoviesNetwork.decoder)))
			}.previewDisplayName("Fetched")

			NavigationView {
				MovieDetailsScreen.Content(
					title: movieSummary.title,
					state: .loading)
			}.previewDisplayName("Loading")

			NavigationView {
				MovieDetailsScreen.Content(
					title: movieSummary.title,
					state: .error(message: "Failed to load movie details."))
			}.previewDisplayName("Error")
		}
		.previewLayout(.sizeThatFits)
	}
}
