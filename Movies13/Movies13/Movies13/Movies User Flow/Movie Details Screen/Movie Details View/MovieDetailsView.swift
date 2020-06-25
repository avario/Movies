//
//  MovieDetailsView.swift
//  Movies13
//
//  Created by Avario Babushka on 18/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import FormatKit
import NetworkImage
import SwiftUI

struct MovieDetailsView: View {
	let movieDetails: MovieDetails

	var body: some View {
		ScrollView {
			VStack(spacing: 10) {
				NetworkImage(url: movieDetails.posterURL)
					.scaledToFit()
					.cornerRadius(5)
					.frame(height: 400)
					.shadow(radius: 10)

				HStack {
					Text("\(movieDetails.releaseDate, formatter: Self.yearDateFormatter)")
						.font(.title)
						.fontWeight(.heavy)

					Text(verbatim: ListFormatter().string(from: movieDetails.genres.map { $0.name })!)
						.font(.caption)
						.foregroundColor(.secondary)
				}

				Text(verbatim: movieDetails.overview)
					.lineLimit(nil)
					.foregroundColor(.secondary)

				StarRating(rating: movieDetails.starRating)
			}
			.padding()
		}
	}

	static let yearDateFormatter = DateFormatter()
		.localizedDateFormatTemplate("yyyy")
}

struct MovieDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		MovieDetailsView(movieDetails: MovieDetails.preview("MovieDetails", decoder: MoviesNetwork.decoder))
			.previewLayout(.sizeThatFits)
	}
}
