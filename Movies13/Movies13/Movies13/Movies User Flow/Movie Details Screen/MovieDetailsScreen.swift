//
//  MovieDetailsScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import URLImage
import FormatKit

struct MovieDetailsScreen: View {

	let movieSummary: MovieSummary

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	@ObservedObject var movieDetailsFetcher: MovieDetailsFetcher = .init()

	var body: some View {
		List { () -> AnyView in // Must wrap with AnyView until SwiftUI supports switch statements
			switch movieDetailsFetcher.state {
			case .loading:
				return AnyView(
					ActivityIndicator()
				)

			case .error(let errorMessage):
				return AnyView(
					Text(errorMessage)
						.foregroundColor(.secondary)
				)

			case .fetched(let movieDetails):
				return AnyView(
					VStack(spacing: 10) {
						URLImage(url: movieDetails.posterURL)
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
				)
			}
		}
		.onAppear { self.movieDetailsFetcher.fetch(forMovieID: self.movieSummary.id, from: self.moviesNetwork) }
		.navigationBarTitle(movieSummary.title)
	}

	static let yearDateFormatter = DateFormatter()
		.localizedDateFormatTemplate("yyyy")
}

struct MovieDetailsScreen_Previews: PreviewProvider {

	static let movieSummary = try! MoviesNetwork().preview(FetchPopularMovies()).results[0]
	
	static var previews: some View {
		Group {
			NavigationView {
				MovieDetailsScreen(movieSummary: movieSummary)
			}
			.environmentObject(MoviesNetwork().preview(mode: .success))
			.previewDisplayName("Success")

			NavigationView {
				MovieDetailsScreen(movieSummary: movieSummary)
			}
			.environmentObject(MoviesNetwork().preview(mode: .loading))
			.previewDisplayName("Loading")

			NavigationView {
				MovieDetailsScreen(movieSummary: movieSummary)
			}
			.environmentObject(MoviesNetwork().preview(mode: .failure(error: .unknown)))
			.previewDisplayName("Failure")
		}
		.onAppear { UIView.setAnimationsEnabled(false) }
		.previewLayout(.sizeThatFits)
	}
}
