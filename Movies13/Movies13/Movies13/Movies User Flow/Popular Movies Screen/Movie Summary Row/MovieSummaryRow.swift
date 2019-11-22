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

	let model: Model

	var body: some View {
		ZStack(alignment: .bottom) {
			NetworkImage(url: model.backgroundImageURL)
				.scaledToFill()
				.frame(height: 185)

			VStack(alignment: .leading, spacing: 5) {
				Text(verbatim: model.title)
					.font(.largeTitle)
					.fontWeight(.heavy)
					.foregroundColor(.primary)
					.lineLimit(2)

				HStack {
					StarRating(rating: model.starRating)
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
			model: .init(
				id: 0,
				title: "Toy Story 4",
				starRating: 4,
				backgroundImageURL: URL(string: "https://image.tmdb.org/t/p/w1280/m67smI1IIMmYzCl9axvKNULVKLr")!))
			.previewLayout(.sizeThatFits)
			.padding()
	}
}
