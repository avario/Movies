//
//  PopularMoviesScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 19/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import NetworkKit
import SwiftUI

struct PopularMoviesScreen: View {
	let state: FetchPopularMovies.Requester.State

	var body: some View {
		content
			.navigationBarTitle("Popular Movies")
	}

	var content: AnyView {
		switch state {
		case .loading:
			return ActivityIndicator()
				.eraseToAnyView()

		case .failure(let error):
			return ErrorView(error: error, defaultMessage: "Failed to load movies.")
				.eraseToAnyView()

		case .success(let response):
			return PopularMoviesList(movieSummaries: response.results)
				.eraseToAnyView()
		}
	}
}

struct PopularMoviesScreen_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			NavigationView {
				PopularMoviesScreen(
					state: .success(FetchPopularMovies.Response.preview("FetchPopularMoviesResponse_Preview", decoder: MoviesNetwork.decoder)))
			}.previewDisplayName("Loaded")

			NavigationView {
				PopularMoviesScreen(
					state: .loading)
			}.previewDisplayName("Loading")

			NavigationView {
				PopularMoviesScreen(
					state: .failure(.local(.timeout)))
			}.previewDisplayName("Error")
		}
		.previewLayout(.sizeThatFits)
	}
}
