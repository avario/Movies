//
//  MovieDetailsView.swift
//  Movies13
//
//  Created by Avario Babushka on 12/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import NetworkImage
import FormatKit

struct MovieDetailsView: View {

	enum State {
		case loading
		case error(message: String)
		case fetched(movieDetails: MovieDetails)
	}

	let state: State

	var body: some View {
		List { () -> AnyView in // Must wrap with AnyView until SwiftUI supports switch statements
			switch state {
			case .loading:
				return
					ActivityIndicator()
						.eraseToAnyView()

			case .error(let errorMessage):
				return
					Text(errorMessage)
						.foregroundColor(.secondary)
						.eraseToAnyView()

			case .fetched(let movieDetails):
				return
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
					.eraseToAnyView()
			}
		}
	}

	static let yearDateFormatter = DateFormatter()
		.localizedDateFormatTemplate("yyyy")
}

struct MovieDetailsView_Previews: PreviewProvider {

	static let movieSummary = try! FetchPopularMovies().preview(on: MoviesNetwork()).results[0]

	static var previews: some View {
		NavigationView {
			MovieDetailsView(state: .fetched(movieDetails: try! FetchMovieDetails(movieID: movieSummary.id).preview(on: MoviesNetwork())))
		}
		.previewLayout(.sizeThatFits)
	}
}
