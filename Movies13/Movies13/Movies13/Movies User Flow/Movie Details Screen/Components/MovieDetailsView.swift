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
				.padding([.leading, .trailing])

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
		MovieDetailsView(
			movieDetails: MovieDetails(id: 100, title: "Toy Story 4", releaseDateString: "2019-06-19", genres: [MovieDetails.Genre(id: 2, name: "Adventure")], posterPath: "/w9kR8qbmQ01HwnvK4alvnQ2ca0L.jpg", overview: "Woody has always been confident about his place in the world and that his priority is taking care of his kid, whether that's Andy or Bonnie. But when Bonnie adds a reluctant new toy called \"Forky\" to her room, a road trip adventure alongside old and new friends will show Woody how big the world can be for a toy.", rating: 7.6))
    }
}
