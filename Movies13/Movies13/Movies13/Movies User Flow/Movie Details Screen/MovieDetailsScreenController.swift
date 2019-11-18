//
//  MovieDetailsScreenController.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import NetworkImage
import FormatKit
import NetworkKit

struct MovieDetailsScreenController: View {

	let movieSummary: MovieSummary

	@EnvironmentObject var moviesNetwork: MoviesNetwork
	@ObservedObject var movieDetailsFetcher: FetchMovieDetails.Fetcher = .init()

	var body: some View {
		MovieDetailsScreen(
			title: movieSummary.title,
			state: movieDetailsFetcher.state)
			.onAppear {
				self.movieDetailsFetcher.fetch(.init(movieID: self.movieSummary.id), on: self.moviesNetwork)
			}
	}
}
