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
		NetworkRequesterView(
			state: state,
			loading: {
				ActivityIndicator()
			},
			error: { error in
				ErrorView(error: error, defaultMessage: "Failed to load movies.")
			},
			fetched: { response in
				PopularMoviesList(movieSummaries: response.results)
		})
			.navigationBarTitle("Popular Movies")
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
