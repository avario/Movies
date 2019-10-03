//
//  MovieDetailsScreen.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct MovieDetailsScreen: View {

	@EnvironmentObject var moviesNetwork: MoviesNetwork

	@ObservedObject var data: MoviesDetailsScreenData

	let movieSummary: MovieSummary

	var body: some View {
		ScrollView {
			VStack {
				Text("Hello")
			}
		}
		.navigationBarTitle(movieSummary.title)
	}
}

//struct MovieDetailsScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		MovieDetailsScreen(movieSummary: )
//	}
//}
