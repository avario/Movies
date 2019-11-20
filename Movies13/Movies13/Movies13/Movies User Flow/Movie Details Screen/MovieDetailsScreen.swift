//
//  MovieDetailsScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 18/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import NetworkKit
import SwiftUI

struct MovieDetailsScreen: View {
	let title: String
	let state: FetchMovieDetails.Requester.State

	var body: some View {
		NetworkRequesterView(
			state: state,
			loading: {
				ActivityIndicator()
			},
			error: { error in
				ErrorView(error: error, defaultMessage: "Failed to load movie details.")
			},
			fetched: { movieDetails in
				MovieDetailsView(movieDetails: movieDetails)
		})
			.navigationBarTitle(title)
	}
}

struct MovieDetailsScreen_Previews: PreviewProvider {
	static let movieSummary = [MovieSummary].preview("MovieSummaries_Preview", decoder: MoviesNetwork.decoder)[0]

	static var previews: some View {
		Group {
			NavigationView {
				MovieDetailsScreen(
					title: movieSummary.title,
					state: .success(MovieDetails.preview("MovieDetails_Preview", decoder: MoviesNetwork.decoder)))
			}.previewDisplayName("Loaded")

			NavigationView {
				MovieDetailsScreen(
					title: movieSummary.title,
					state: .loading)
			}.previewDisplayName("Loading")

			NavigationView {
				MovieDetailsScreen(
					title: movieSummary.title,
					state: .failure(.local(.timeout)))
			}.previewDisplayName("Error")
		}
		.previewLayout(.sizeThatFits)
	}
}
