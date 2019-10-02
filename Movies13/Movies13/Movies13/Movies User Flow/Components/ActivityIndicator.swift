//
//  ActivityIndicator.swift
//  Movies13
//
//  Created by Avario Babushka on 2/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

	let isLoading: Bool

	func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView(style: .medium)

		if isLoading {
			activityIndicator.startAnimating()
		}

		return activityIndicator
	}

	func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) { }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(isLoading: true)
    }
}
