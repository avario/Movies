//
//  StarRating.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct StarRating: View {

	let rating: Int

    var body: some View {
		HStack(spacing: 3) {
			ForEach(1...5, id: \.self) { star in
				Image(systemName: "star.fill")
					.foregroundColor(star > self.rating ? Color.primary.opacity(0.5) : .yellow)
			}
		}
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			StarRating(rating: 2)
				.previewLayout(.sizeThatFits)
				.previewDisplayName("2 Star | Light Mode")
				.padding(10)
			
			StarRating(rating: 4)
				.previewLayout(.sizeThatFits)
				.previewDisplayName("4 Star | Dark Mode")
				.padding(10)
				.background(Color.black)
				.environment(\.colorScheme, .dark)
		}
    }
}
