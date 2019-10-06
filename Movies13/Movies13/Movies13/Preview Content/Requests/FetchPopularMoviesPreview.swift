//
//  FetchPopularMoviesPreview.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

extension FetchPopularMovies {

	static let preview: FetchPopularMovies.Response = PreviewLoader.shared.load("MoviesResponse.json")

}
