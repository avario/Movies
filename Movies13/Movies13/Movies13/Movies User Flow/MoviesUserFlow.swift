//
//  MoviesUserFlow.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct MoviesUserFlow: View {
    var body: some View {
		NavigationView {
			MoviesListScreen(data: MoviesListScreenData())
		}
    }
}

struct MoviesUserFlow_Previews: PreviewProvider {
    static var previews: some View {
        MoviesUserFlow()
    }
}
