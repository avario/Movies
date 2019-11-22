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
		Content(
			rowModels: movieSummaries.map({ movieSummary in
				.init(
					id: movieSummary.id,
					rowModel: MovieSummaryRow.Model.from(movieSummary: movieSummary),
					destination: {
						MovieDetailsScreenController(movieSummary: movieSummary)
							.eraseToAnyView()
					})
			}))
	}
}
