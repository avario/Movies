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

	@ObservedObject var data = MovieDetailsData()

	let movieSummary: MovieSummary

	var body: some View {
		List {
			data.movieDetails.map { movieDetails in
				MovieDetailsView(movieDetails: movieDetails)
			}
		}
		.onAppear { self.data.fetchMovieDetails(for: self.movieSummary, from: self.moviesNetwork) }
		.navigationBarTitle(movieSummary.title)
	}
}

struct MovieDetailsScreen_Previews: PreviewProvider {
	
	static var previews: some View {
		NavigationView {
			MovieDetailsScreen(movieSummary: try! MoviesNetwork().preview(FetchPopularMovies()).results[0])
		}
		.environmentObject(MoviesNetwork().alwaysPreview())
		.environmentObject(URLImageLoader().alwaysPreview())
		.previewLayout(.sizeThatFits)
	}
}
