//
//  MovieSummaryRow.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import NetworkImage

struct MovieSummaryRow: View {

	let imageURL: URL
	let title: String
	let starRating: Int

	var body: some View {
		ZStack(alignment: .bottom) {
			NetworkImage(url: imageURL)
				.scaledToFill()
				.frame(height: 185)

			VStack(alignment: .leading, spacing: 5) {
				Text(verbatim: title)
					.font(.largeTitle)
					.fontWeight(.heavy)
					.foregroundColor(.primary)
					.lineLimit(2)

				HStack {
					StarRating(rating: starRating)
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
		MovieSummaryRow(
			imageURL: URL(string: "image.tmdb.org/t/p/w1280/m67smI1IIMmYzCl9axvKNULVKLr")!,
			title: "Toy Story",
			starRating: 4)
			.previewLayout(.sizeThatFits)
			.padding()
	}
}
