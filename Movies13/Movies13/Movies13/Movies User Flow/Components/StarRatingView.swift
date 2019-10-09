//
//  StarRating.swift
//  Movies13
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct StarRating: View {

	@State var rating: Int

    var body: some View {
		HStack(spacing: 3) {
			ForEach(1...5, id: \.self) { star in
				Image(systemName: "star.fill")
					.foregroundColor(star > self.rating ? Color.primary.opacity(0.3) : .yellow)
			}
		}
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
		ForEach(0...5, id: \.self) { rating in
			StarRating(rating: rating)
				.previewLayout(.sizeThatFits)
				.padding()
		}
    }
}
