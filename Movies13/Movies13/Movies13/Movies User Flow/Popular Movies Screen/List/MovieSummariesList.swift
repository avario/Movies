//
//  MovieSummariesList.swift
//  Movies13
//
//  Created by Avario Babushka on 19/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct MovieSummariesList: View {
	let movieSummaries: [MovieSummary]

	var body: some View {
		MovieSummariesListView(
			rowModels: movieSummaries.map(MovieSummaryRow.Model.from(movieSummary:)),
			destinations: { id in
				MovieDetailsScreenController(movieSummary: self.movieSummaries.first(with: id)!)
					.eraseToAnyView()
			})
	}
}

struct MovieSummariesListView: View {
	let rowModels: [MovieSummaryRow.Model]
	let destinations: (_ id: Int) -> AnyView

	var body: some View {
		List(rowModels) { model in
			NavigationLink(destination: self.destinations(model.id)) {
				MovieSummaryRow(model: model)
			}
		}
	}
}

struct PopularMoviesListView_Previews: PreviewProvider {
	static let rowModels = [MovieSummary].preview("MovieSummaries_Preview", decoder: MoviesNetwork.decoder)
		.map(MovieSummaryRow.Model.from(movieSummary:))

	static var previews: some View {
		MovieSummariesListView(
			rowModels: rowModels,
			destinations: { _ in EmptyView().eraseToAnyView() })
			.previewLayout(.sizeThatFits)
	}
}
