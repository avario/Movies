//
//  MoviesListModel.swift
//  Movies13 Dev
//
//  Created by Avario Babushka on 9/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation

class MoviesListModel: ObservableObject {

	@Published var isLoading: Bool = false
	@Published var movieSummaries: [MovieSummary] = []
}
