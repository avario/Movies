//
//  MovieSummaryList.Content.swift
//  Movies13
//
//  Created by Avario Babushka on 22/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

extension MovieSummariesList {
	struct Content: View {

		struct RowModel: Identifiable {
			let id: Int
			let rowModel: MovieSummaryRow.Model
			let destination: () -> AnyView
		}

		let rowModels: [RowModel]

		var body: some View {
			List(rowModels) { model in
				NavigationLink(destination: model.destination()) {
					MovieSummaryRow(model: model.rowModel)
				}
			}
		}
	}
}

struct MovieSummariesListContent_Previews: PreviewProvider {
	static let rowModels = [MovieSummary].preview("MovieSummaries_Preview", decoder: MoviesNetwork.decoder)
		.map({ movieSummary in
			MovieSummariesList.Content.RowModel(
				id: movieSummary.id,
				rowModel: MovieSummaryRow.Model.from(movieSummary: movieSummary),
				destination: { EmptyView().eraseToAnyView() })
		})

	static var previews: some View {
		MovieSummariesList.Content(rowModels: rowModels)
			.previewLayout(.sizeThatFits)
	}
}
