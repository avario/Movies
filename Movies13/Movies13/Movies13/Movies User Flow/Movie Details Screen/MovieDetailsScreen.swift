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
	let state: FetchMovieDetails.Fetcher.State

	var body: some View {
		NetworkFetcherView(
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
	static let movieSummary = FetchPopularMovies().preview.results[0]

	static var previews: some View {
		Group {
			NavigationView {
				MovieDetailsScreen(
					title: movieSummary.title,
					state: .fetched(FetchMovieDetails(movieID: movieSummary.id).preview))
			}

			NavigationView {
				MovieDetailsScreen(
					title: movieSummary.title,
					state: .loading)
			}

			NavigationView {
				MovieDetailsScreen(
					title: movieSummary.title,
					state: .error(.local(.timeout)))
			}
		}
		.previewLayout(.sizeThatFits)
	}
}
