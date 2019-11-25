//
//  PopularMoviesScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import NetworkKit
import SwiftUI

struct PopularMoviesScreen: View {
	@EnvironmentObject var moviesNetwork: MoviesNetwork
	@ObservedObject var popularMoviesFetcher: PopularMoviesFetcher = .init()

	var body: some View {
		Content(state: popularMoviesFetcher.state)
			.onAppear { self.popularMoviesFetcher.fetch(on: self.moviesNetwork) }
	}
}

struct PopularMoviesScreen_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			PopularMoviesScreen()
		}
		.environmentObject(MoviesNetwork())
	}
}
