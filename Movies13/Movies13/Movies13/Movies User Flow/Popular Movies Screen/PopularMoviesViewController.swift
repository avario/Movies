//
//  PopularMoviesViewController.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import NetworkKit

struct PopularMoviesViewController: View {

	@EnvironmentObject var moviesNetwork: MoviesNetwork
	@ObservedObject var popularMoviesFetcher: PopularMoviesFetcher = .init()

	var body: some View {
		PopularMoviesView(movieSummaries: popularMoviesFetcher.movieSummaries)
			.onAppear { self.popularMoviesFetcher.fetch(from: self.moviesNetwork) }
	}
}

struct PopularMoviesView: View {

	let movieSummaries: [MovieSummary]

	var body: some View {
		List {
			ForEach(movieSummaries) { movieSummary in
				NavigationLink(destination: MovieDetailsScreenController(movieSummary: movieSummary)) {
					MovieSummaryRow(movieSummary: movieSummary)
				}
			}
		}
		.navigationBarTitle("Popular Movies")
	}
}

struct PopularMoviesView_Previews: PreviewProvider {

	static var previews: some View {
		NavigationView {
			PopularMoviesView(movieSummaries: FetchPopularMovies().preview.results)
		}
		.onAppear { UIView.setAnimationsEnabled(false) }
		.previewLayout(.sizeThatFits)
	}
}
