//
//  MoviesListScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct MoviesListScreen: View {

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	@ObservedObject var data: MoviesListData = .init()

	var body: some View {
		List { () -> AnyView in // Must wrap with AnyView until SwiftUI supports switch statements
			switch data.fetchMoviesState {
			case .loading:
				return AnyView(
					ActivityIndicator()
				)

			case .error(let errorMessage):
				return AnyView(
					Text(errorMessage)
						.foregroundColor(.secondary)
				)

			case .loaded(let movieSummaries):
				return AnyView(
					ForEach(movieSummaries) { movieSummary in
						NavigationLink(destination: MovieDetailsScreen(movieSummary: movieSummary)) {
							MovieSummaryRow(movieSummary: movieSummary)
						}
					}
				)
			}
		}
		.onAppear { self.data.fetchMovies(from: self.moviesNetwork) }
		.navigationBarTitle("Popular Movies")
	}
}

struct PopularMoviesScreen_Previews: PreviewProvider {

	static var previews: some View {
		Group {
			NavigationView {
				MoviesListScreen(
					data: MoviesListDataPreview(
						fetchMoviesState: .loaded(
							movieSummaries: try! MoviesNetwork().preview(FetchPopularMovies()).results)))
			}.previewDisplayName("Loaded Movies")

			NavigationView {
				MoviesListScreen(
					data: MoviesListDataPreview(
						fetchMoviesState: .loading))
			}.previewDisplayName("Loading")

			NavigationView {
				MoviesListScreen(
					data: MoviesListDataPreview(
						fetchMoviesState: .error(message: "Failed to load movies")))
			}.previewDisplayName("Failed")
		}
		.environmentObject(MoviesNetwork())
		.previewLayout(.sizeThatFits)
	}

	class MoviesListDataPreview: MoviesListData {

		init(fetchMoviesState: FetchMoviesState) {
			super.init()
			defer { // Must defer to avoid abort trap 6 build error
				self.fetchMoviesState = fetchMoviesState
			}
		}

		override func fetchMovies(from moviesNetwork: MoviesNetwork) { }
	}
}
