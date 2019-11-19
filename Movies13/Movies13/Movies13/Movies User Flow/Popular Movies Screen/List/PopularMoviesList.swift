//
//  PopularMoviesList.swift
//  Movies13
//
//  Created by Avario Babushka on 19/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct PopularMoviesList: View {
	let movieSummaries: [MovieSummary]

	var body: some View {
		List {
			ForEach(movieSummaries) { movieSummary in
				NavigationLink(destination: MovieDetailsScreenController(movieSummary: movieSummary)) {
					MovieSummaryRow(movieSummary: movieSummary)
				}
			}
		}
	}
}
