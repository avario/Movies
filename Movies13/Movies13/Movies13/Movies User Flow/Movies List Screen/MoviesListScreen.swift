//
//  MoviesListScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import URLImage

struct MoviesListScreen: View {

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	@ObservedObject var data: MoviesListData

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
		MoviesListScreen(data: MoviesListData())
			.environmentObject(MoviesNetwork().alwaysPreview())
			.environmentObject(URLImageLoader().alwaysPreview())
	}
}
