//
//  File.swift
//  
//
//  Created by Avario Babushka on 18/10/19.
//

import Foundation
import UIKit
import NetworkKit
import Combine

public extension Network {

	func imageRequest<R: NetworkDataRequest>(_ request: R, previewMode: NetworkPreviewMode? = nil) -> AnyPublisher<UIImage, NetworkError> {

		return dataRequest(request, previewMode: previewMode)
			.tryMap {
				guard let image = UIImage(data: $0) else {
					throw NetworkError.unknown
				}
				return image
			}
			.mapError(NetworkError.init)
			.eraseToAnyPublisher()
	}
}
