//
//  MoviesListScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct MoviesListScreen: View {

	@State var movieSummaries: [MovieSummary] = []
	@State var isLoading: Bool = false

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	public var data: MoviesListData? = .init()

	var body: some View {
		List(movieSummaries) { movieSummary in
			NavigationLink(destination: MovieDetailsScreen(movieSummary: movieSummary)) {
				MovieSummaryRow(movieSummary: movieSummary)
			}
		}
		.onAppear { self.data?.fetchMovies(from: self.moviesNetwork, into: self) }
		.navigationBarItems(trailing: ActivityIndicator(isLoading: isLoading))
		.navigationBarTitle("Popular Movies")
	}
}

struct PopularMoviesScreen_Previews: PreviewProvider {

	static var previews: some View {
		NavigationView {
			MoviesListScreen(
				movieSummaries: try! MoviesNetwork().preview(FetchPopularMovies()).results,
				isLoading: false,
				data: nil)
		}
		.environmentObject(MoviesNetwork())
		.previewLayout(.sizeThatFits)
	}
}
