//
//  MoviesListScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct MoviesListScreen: View {

	enum FetchMoviesState {
		case loading
		case failed(errorMessage: String)
		case loaded(movieSummaries: [MovieSummary])
	}

	@State var fetchMoviesState: FetchMoviesState = .loading

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	public var data: MoviesListData? = .init()

	var body: some View {
		List {
			content(fetchMoviesState: fetchMoviesState)
		}
		.onAppear { self.data?.fetchMovies(from: self.moviesNetwork, into: self) }
		.navigationBarTitle("Popular Movies")
	}

	// This is a workaround while SwiftUI doesn't support switch statements.
	func content(fetchMoviesState: FetchMoviesState) -> some View {
		switch fetchMoviesState {
		case .loading:
			return AnyView(
				ActivityIndicator()
			)

		case .failed(let errorMessage):
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
}

struct PopularMoviesScreen_Previews: PreviewProvider {

	static var previews: some View {
		Group {
			NavigationView {
				MoviesListScreen(
					fetchMoviesState: .loaded(
						movieSummaries: try! MoviesNetwork().preview(FetchPopularMovies()).results),
					data: nil)
			}.previewDisplayName("Loaded Movies")

			NavigationView {
				MoviesListScreen(
					fetchMoviesState: .loading,
					data: nil)
			}.previewDisplayName("Loading")

			NavigationView {
				MoviesListScreen(
					fetchMoviesState: .failed(errorMessage: "Failed to load movies"),
					data: nil)
			}.previewDisplayName("Failed")
		}
		.environmentObject(MoviesNetwork())
		.previewLayout(.sizeThatFits)
	}
}
