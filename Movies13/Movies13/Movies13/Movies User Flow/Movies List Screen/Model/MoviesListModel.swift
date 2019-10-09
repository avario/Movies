//
//  MoviesListModel.swift
//  Movies13 Dev
//
//  Created by Avario Babushka on 9/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

final class MoviesListModel: ObservableObject {

	@Published var isLoading: Bool
	@Published var movieSummaries: [MovieSummary]

	init(isLoading: Bool = false, movieSummaries: [MovieSummary] = []) {
		self.isLoading = isLoading
		self.movieSummaries = movieSummaries
	}
}
