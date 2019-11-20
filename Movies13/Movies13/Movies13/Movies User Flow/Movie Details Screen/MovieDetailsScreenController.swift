//
//  MovieDetailsScreenController.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import FormatKit
import NetworkKit
import SwiftUI

struct MovieDetailsScreenController: View {
	let movieSummary: MovieSummary

	@EnvironmentObject var moviesNetwork: MoviesNetwork
	@ObservedObject var movieDetailsFetcher: FetchMovieDetails.Requester = .init()

	var body: some View {
		MovieDetailsScreen(
			title: movieSummary.title,
			state: movieDetailsFetcher.state)
			.onAppear {
				self.movieDetailsFetcher.request(.init(movieID: self.movieSummary.id), on: self.moviesNetwork)
			}
	}
}
