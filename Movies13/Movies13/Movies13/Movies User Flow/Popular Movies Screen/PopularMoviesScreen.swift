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
		PopularMoviesView(rows: popularMoviesFetcher.movieSummaries
			.map({ .init(
				id: $0.id,
				summaryRow: MovieSummaryRow(imageURL: $0.backdropImageURL, title: $0.title, starRating: $0.starRating),
				destination: MovieDetailsScreen(movieSummary: $0)) }))
			.onAppear { self.popularMoviesFetcher.fetch(from: self.moviesNetwork) }
	}
}

struct PopularMoviesView: View {

	struct Row: Identifiable {
		let id: Int
		let summaryRow: MovieSummaryRow
		let destination: MovieDetailsScreen
	}

	let rows: [Row]

	var body: some View {
		List {
			ForEach(rows) { row in
				NavigationLink(destination: row.destination) {
					row.summaryRow
				}
			}
		}
		.navigationBarTitle("Popular Movies")
	}
}

//struct PopularMoviesView_Previews: PreviewProvider {
//
//	static var previews: some View {
//		NavigationView {
//			PopularMoviesView(movieSummaries: try! FetchPopularMovies().preview(on: MoviesNetwork()).results)
//		}
//		.previewLayout(.sizeThatFits)
//	}
//}
