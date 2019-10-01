//
//  MovieSummaryRow.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import URLImage

struct MovieSummaryRow: View {

	var movieSummary: MovieSummary

	var body: some View {
		ZStack {
			URLImage(url: movieSummary.backdropImageURL)
			VStack {
				Text(verbatim: movieSummary.title)
					.font(.largeTitle)
					.foregroundColor(.white)
					.lineLimit(2)
				StarRating(rating: movieSummary.starRating)
			}
		}
		.padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
	}
}

struct MovieSummaryRow_Previews: PreviewProvider {
	static var previews: some View {
		MovieSummaryRow(movieSummary: MovieSummary.preview)
	}
}
