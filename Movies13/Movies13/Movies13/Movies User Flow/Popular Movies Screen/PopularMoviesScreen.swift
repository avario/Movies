//
//  PopularMoviesScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct PopularMoviesScreen: View {

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	@ObservedObject private var popularMoviesFetcher: PopularMoviesFetcher = .init()

	var body: some View {
		List { () -> AnyView in // Must wrap with AnyView until SwiftUI supports switch statements
			switch popularMoviesFetcher.state {
			case .loading:
				return AnyView(
					ActivityIndicator()
				)

			case .error(let errorMessage):
				return AnyView(
					Text(errorMessage)
						.foregroundColor(.secondary)
				)

			case .fetched(let movieSummaries):
				return AnyView(
					ForEach(movieSummaries) { movieSummary in
						NavigationLink(destination: MovieDetailsScreen(movieSummary: movieSummary)) {
							MovieSummaryRow(movieSummary: movieSummary)
						}
					}
				)
			}
		}
		.onAppear { self.popularMoviesFetcher.fetch(from: self.moviesNetwork) }
		.navigationBarTitle("Popular Movies")
	}
}

struct PopularMoviesScreen_Previews: PreviewProvider {

	static var previews: some View {
		Group {
			NavigationView {
				PopularMoviesScreen()
			}
			.onAppear { UIView.setAnimationsEnabled(false) }
			.environmentObject(MoviesNetwork().preview(mode: .success))
			.previewDisplayName("Success")

			NavigationView {
				PopularMoviesScreen()
			}
			.environmentObject(MoviesNetwork().preview(mode: .loading))
			.previewDisplayName("Loading")

			NavigationView {
				PopularMoviesScreen()
			}
			.environmentObject(MoviesNetwork().preview(mode: .failure(error: .unknown)))
			.previewDisplayName("Failure")
		}
		.previewLayout(.sizeThatFits)
	}
}
