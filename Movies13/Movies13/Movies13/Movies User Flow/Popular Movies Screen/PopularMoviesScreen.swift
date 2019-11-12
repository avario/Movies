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
		PopularMoviesView(model: .init(movieSummaries: popularMoviesFetcher.movieSummaries))
			.onAppear { self.popularMoviesFetcher.fetch(from: self.moviesNetwork) }
	}
}

extension PopularMoviesViewModel {
	init(movieSummaries: [MovieSummary]) {
		rows = movieSummaries
			.map({ .init(
				id: $0.id,
				summaryRowModel: .init(for: $0),
				destination: MovieDetailsScreen(movieSummary: $0)) })
	}
}

struct PopularMoviesViewModel {
	struct Row: Identifiable {
		let id: Int
		let summaryRowModel: MovieSummaryRowModel
		let destination: MovieDetailsScreen
	}

	let rows: [Row]
}

struct PopularMoviesView: View {

	let model: PopularMoviesViewModel

	var body: some View {
		List {
			ForEach(model.rows) { row in
				NavigationLink(destination: row.destination) {
					MovieSummaryRow(model: row.summaryRowModel)
				}
			}
		}
		.navigationBarTitle("Popular Movies")
	}
}

struct PopularMoviesView_Previews: PreviewProvider {

	static var previews: some View {
		NavigationView {
			PopularMoviesView(model: .init(movieSummaries: try! FetchPopularMovies().preview(on: MoviesNetwork()).results))
		}
		.previewLayout(.sizeThatFits)
	}
}
