//
//  MoviesListScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct MoviesListScreen: View {

	@State private var movieSummaries: [MovieSummary] = []

	var body: some View {
		List(movieSummaries) { movieSummary in
			MovieSummaryRow(movieSummary: movieSummary)
		}
	}
}

struct PopularMoviesScreen_Previews: PreviewProvider {
	static var previews: some View {
		MoviesListScreen()
	}
}
