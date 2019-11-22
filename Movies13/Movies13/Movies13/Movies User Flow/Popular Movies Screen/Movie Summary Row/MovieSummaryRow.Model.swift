//
//  MovieSummaryRow.Model.swift
//  Movies13
//
//  Created by Avario Babushka on 22/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

extension MovieSummaryRow {
	struct Model: Identifiable {
		let id: Int
		let title: String
		let starRating: Int
		let backgroundImageURL: URL

		static func from(movieSummary: MovieSummary) -> Self {
			.init(
				id: movieSummary.id,
				title: movieSummary.title,
				starRating: movieSummary.starRating,
				backgroundImageURL: movieSummary.backdropImageURL)
		}
	}
}
