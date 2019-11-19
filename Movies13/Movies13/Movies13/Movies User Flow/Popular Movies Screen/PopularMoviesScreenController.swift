//
//  PopularMoviesViewController.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import NetworkKit
import SwiftUI

struct PopularMoviesScreenController: View {
	@EnvironmentObject var moviesNetwork: MoviesNetwork
	@ObservedObject var popularMoviesFetcher: FetchPopularMovies.Fetcher = .init()

	var body: some View {
		PopularMoviesScreen(state: popularMoviesFetcher.state)
			.onAppear { self.popularMoviesFetcher.fetch(.init(), on: self.moviesNetwork) }
	}
}
