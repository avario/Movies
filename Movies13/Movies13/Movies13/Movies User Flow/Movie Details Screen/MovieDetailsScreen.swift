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

	@State var movieDetails: MovieDetails? = nil
	@State var isLoading: Bool = false

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	public var data: MovieDetailsData? = .init()

	var body: some View {
		ScrollView {
			movieDetails.map { movieDetails in
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
			}
		}
		.onAppear { self.data?.fetchMovieDetails(for: self.movieSummary, from: self.moviesNetwork, into: self) }
		.navigationBarItems(trailing: ActivityIndicator(isLoading: isLoading))
		.navigationBarTitle(movieSummary.title)
	}

	static let yearDateFormatter = DateFormatter()
		.localizedDateFormatTemplate("yyyy")
}

struct MovieDetailsScreen_Previews: PreviewProvider {

	static var previews: some View {
		NavigationView {
			MovieDetailsScreen(
				movieSummary: try! MoviesNetwork().preview(FetchPopularMovies()).results[0],
				movieDetails: try! MoviesNetwork().preview(FetchMovieDetails(movieId: 301528)),
				isLoading: false,
				data: nil)
		}
		.environmentObject(MoviesNetwork())
		.previewLayout(.sizeThatFits)
	}
}
