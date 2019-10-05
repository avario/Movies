//
//  MovieDetailsScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import URLImage
import ChainKit

struct MovieDetailsScreen: View {

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	@ObservedObject var data: MovieDetailsData

	let movieSummary: MovieSummary

	var body: some View {
		ScrollView {
			if data.movieDetails == nil {
				EmptyView()
			} else {
				VStack {
					URLImage(url: data.movieDetails!.posterURL)
						.cornerRadius(5)
						.padding([.leading, .trailing], 24)
					
					HStack {
						Text(data.movieDetails!.releaseDate, formatter: Self.yearDateFormatter)
							.font(.title)
							.fontWeight(.heavy)
						
						Text(data.movieDetails!.genres.map { $0.name }.joined(separator: ", "))
							.font(.callout)
							.foregroundColor(.secondary)
					}
					
					Text(data.movieDetails!.overview)
						.foregroundColor(.secondary)
					
					StarRating(rating: data.movieDetails!.starRating)
				}
			}
		}
		.navigationBarTitle(movieSummary.title)
	}
	
	static let yearDateFormatter = DateFormatter()
		.localizedDateFormatTemplate("yyyy")
		
}

//struct MovieDetailsScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		MovieDetailsScreen(movieSummary: )
//	}
//}

extension Text {
	
	init<R>(_ text: R, formatter: Formatter) where R: ReferenceConvertible {
		self.init("\(text, formatter: formatter)")
	}
}
