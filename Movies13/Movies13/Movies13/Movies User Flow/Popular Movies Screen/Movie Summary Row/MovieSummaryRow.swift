//
//  MovieSummaryRow.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import NetworkImage
import SwiftUI

struct MovieSummaryRow: View {
	let movieSummary: MovieSummary

	var body: some View {
		ZStack(alignment: .bottom) {
			NetworkImage(url: movieSummary.backdropImageURL)
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
			.padding()
			.background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
		}
		.colorScheme(.dark)
		.cornerRadius(5)
		.shadow(radius: 5)
	}
}

struct MovieSummaryRow_Previews: PreviewProvider {
	static var previews: some View {
		MovieSummaryRow(movieSummary: FetchPopularMovies().preview.results[0])
			.previewLayout(.sizeThatFits)
			.padding()
	}
}
