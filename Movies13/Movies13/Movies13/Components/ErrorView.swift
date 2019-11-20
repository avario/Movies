//
//  MoviesErrorView.swift
//  Movies13
//
//  Created by Avario Babushka on 18/11/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import NetworkKit

struct ErrorView: View {

	private let errorMessage: String

	init(error: NetworkError<MoviesNetwork.RemoteError>, defaultMessage: String) {
		switch error {
		case .local:
			errorMessage = defaultMessage

		case .remote(let remoteError):
			errorMessage = remoteError.message
		}
	}

	var body: some View {
		Text(errorMessage)
			.foregroundColor(.secondary)
	}
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
		ErrorView(error: .local(.timeout), defaultMessage: "An unknown error occured.")
			.previewLayout(.sizeThatFits)
			.padding()
    }
}
