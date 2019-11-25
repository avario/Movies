//
//  MovieDetailsScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import FormatKit
import NetworkKit
import SwiftUI

struct MovieDetailsScreen: View {
	let movieSummary: MovieSummary

	@EnvironmentObject var moviesNetwork: MoviesNetwork
	@ObservedObject var movieDetailsFetcher: MovieDetailsFetcher = .init()

	var body: some View {
		Content(
			title: movieSummary.title,
			state: movieDetailsFetcher.state)
			.onAppear { self.movieDetailsFetcher.fetch(forMovieID: self.movieSummary.id, on: self.moviesNetwork) }
	}
}
