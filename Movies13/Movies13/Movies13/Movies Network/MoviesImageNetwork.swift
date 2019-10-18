//
//  MoviesImageNetwork.swift
//  Movies13
//
//  Created by Avario Babushka on 18/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import Foundation
import NetworkKit

class MoviesImageNetwork: Network, ObservableObject {
	
	let baseURL: URL = Configuration.shared.imageBaseURL

	var previewMode: NetworkPreviewMode = .noPreview

	func preview(mode: NetworkPreviewMode) -> Self {
        previewMode = mode
        return self
    }
}
