//
//  PopularMoviesScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import NetworkKit

struct PopularMoviesScreen: View {

	@EnvironmentObject var moviesNetwork: MoviesNetwork
	@ObservedObject var popularMoviesFetcher: PopularMoviesFetcher = .init()

	var body: some View {
		PopularMoviesView(movieSummaries: popularMoviesFetcher.movieSummaries)
			.onAppear { self.popularMoviesFetcher.fetch(from: self.moviesNetwork) }
	}
}
