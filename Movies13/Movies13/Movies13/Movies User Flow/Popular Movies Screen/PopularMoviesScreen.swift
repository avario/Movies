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
	let state: FetchPopularMovies.Fetcher.State

	var body: some View {
		NetworkFetcherView(
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
					state: .fetched(FetchPopularMovies().preview))
			}

			NavigationView {
				PopularMoviesScreen(
					state: .loading)
			}

			NavigationView {
				PopularMoviesScreen(
					state: .error(.local(.timeout)))
			}
		}
		.previewLayout(.sizeThatFits)
	}
}
