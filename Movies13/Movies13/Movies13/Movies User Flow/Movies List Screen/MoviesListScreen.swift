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

	@ObservedObject var data: MoviesListScreenData

	var body: some View {
		List {
			ForEach(data.movieSummaries) { movieSummary in
				MovieSummaryRow(movieSummary: movieSummary)
			}
		}
		.onAppear { self.data.fetchMovies(from: self.moviesNetwork) }
		.navigationBarTitle("Popular Movies")
		.navigationBarItems(trailing: ActivityIndicator(isLoading: data.isLoading))
	}

}

struct PopularMoviesScreen_Previews: PreviewProvider {
	static var previews: some View {
		MoviesListScreen(data: MoviesListScreenData())
			.environmentObject(MoviesNetwork())
	}
}
