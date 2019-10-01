//
//  MovieSummary.swift
//  Movies
//
//  Created by Avario on 08/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import Foundation

struct MovieSummary: Codable, Identifiable {

	let id: Int
	let title: String
	private let rating: Double
	private let backdropPath: String

	enum CodingKeys: String, CodingKey {
		case id
		case title
		case backdropPath = "backdrop_path"
		case rating = "vote_average"
	}

}

extension MovieSummary {

	var backdropImageURL: URL {
		let baseURL = URL(string: "https://image.tmdb.org/t/p/w1280")!
		return baseURL.appendingPathComponent(backdropPath)
	}

	var starRating: Int {
		return Int((rating / 2).rounded())
	}

}
