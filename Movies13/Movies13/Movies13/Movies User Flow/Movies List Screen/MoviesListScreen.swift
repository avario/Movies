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

	@ObservedObject var model: MoviesListModel
	var actions: MoviesListActions

	var body: some View {
		List(model.movieSummaries) { movieSummary in
			NavigationLink(destination: MovieDetailsScreen(movieSummary: movieSummary)) {
				MovieSummaryRow(movieSummary: movieSummary)
			}
		}
		.onAppear { self.actions.fetchMovies(into: self.model) }
		.navigationBarTitle("Popular Movies")
		.navigationBarItems(trailing: ActivityIndicator(isLoading: model.isLoading))
	}
}

struct PopularMoviesScreen_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MoviesListScreen(
				model: model,
				actions: EmptyMoviesListActions())
		}
		.colorScheme(.dark)
		.previewLayout(.sizeThatFits)
	}

	static var model: MoviesListModel = {
		let model = MoviesListModel()
		model.isLoading = false
		model.movieSummaries = try! MoviesNetwork().preview(FetchPopularMovies()).results
		return model
	}()
}
