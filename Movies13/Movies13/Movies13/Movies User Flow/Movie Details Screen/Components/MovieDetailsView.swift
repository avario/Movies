//
//  MovieDetails.swift
//  Movies13 Dev
//
//  Created by Avario on 08/10/2019.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import URLImage

struct MovieDetailsView: View {
	
	let movieDetails: MovieDetails
	
    var body: some View {
        VStack(spacing: 10) {
			URLImage(url: movieDetails.posterURL)
				.scaledToFit()
				.cornerRadius(5)
				.frame(height: 400)

			HStack {
				Text("\(movieDetails.releaseDate, formatter: Self.yearDateFormatter)")
					.font(.title)
					.fontWeight(.heavy)

				Text(verbatim: movieDetails.genres.map { $0.name }.joined(separator: ", "))
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
	
	static let yearDateFormatter = DateFormatter()
		.localizedDateFormatTemplate("yyyy")
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
		MovieDetailsView(movieDetails: try! MoviesNetwork().preview(FetchMovieDetails(movieId: 301528)))
			.previewLayout(.sizeThatFits)
    }
}
