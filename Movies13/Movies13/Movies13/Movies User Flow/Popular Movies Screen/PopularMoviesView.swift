//
//  PopularMoviesView.swift
//  Movies13
//
//  Created by Avario Babushka on 12/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct PopularMoviesView: View {

	let movieSummaries: [MovieSummary]

	var body: some View {
		List {
			ForEach(movieSummaries) { movieSummary in
				NavigationLink(destination: MovieDetailsScreen(movieSummary: movieSummary)) {
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
			PopularMoviesView(movieSummaries: try! FetchPopularMovies().preview(on: MoviesNetwork()).results)
		}
		.previewLayout(.sizeThatFits)
	}
}
