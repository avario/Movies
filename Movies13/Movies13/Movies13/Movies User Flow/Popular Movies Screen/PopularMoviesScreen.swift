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

	@ObservedObject var popularMoviesFetcher: PopularMoviesFetcher = .init()

	var body: some View {
		List { () -> AnyView in // Must wrap with AnyView until SwiftUI supports switch statements
			switch popularMoviesFetcher.state {
			case .loading:
				return
					ActivityIndicator()
						.eraseToAnyView()

			case .error(let errorMessage):
				return
					Text(errorMessage)
						.foregroundColor(.secondary)
						.eraseToAnyView()

			case .fetched(let movieSummaries):
				return
					ForEach(movieSummaries) { movieSummary in
						NavigationLink(destination: MovieDetailsScreen(movieSummary: movieSummary)) {
							MovieSummaryRow(movieSummary: movieSummary)
						}
					}.eraseToAnyView()
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
		.onAppear { UIView.setAnimationsEnabled(false) }
		.previewLayout(.sizeThatFits)
	}
}
