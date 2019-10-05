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
		ZStack(alignment: .bottom) {
			URLImage(url: movieSummary.backdropImageURL)
				.scaledToFill()
				.frame(height: 185)

			VStack(alignment: .leading, spacing: 5) {
				Text(verbatim: movieSummary.title)
					.font(.largeTitle)
					.fontWeight(.heavy)
					.foregroundColor(.primary)
					.lineLimit(2)

				HStack {
					StarRating(rating: movieSummary.starRating)
					Spacer()
				}
			}
			.padding(15)
			.background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
		}
		.cornerRadius(5)
		.colorScheme(.dark)
		.listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
	}
}

struct MovieSummaryRow_Previews: PreviewProvider {
	static var previews: some View {
		MovieSummaryRow(movieSummary: MovieSummary.preview)
	}
}
