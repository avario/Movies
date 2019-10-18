//
//  File.swift
//  
//
//  Created by Avario Babushka on 18/10/19.
//

import Foundation
import NetworkKit
import Combine
import UIKit

struct BasicNetwork: Network {
	let baseURL: URL
}

struct BasicImageRequest: NetworkDataRequest {
    var method: HTTPMethod = .get
	let path: String
}

final public class NetworkImageLoader: ObservableObject {

	public enum State {
		case loading
		case error(NetworkError)
		case success(UIImage)
	}

	@Published public var state: State = .loading

	let request: AnyNetworkDataRequest
	let network: Network

    convenience init(url: URL) {
        self.init(
            request: BasicImageRequest(path: url.lastPathComponent),
            network: BasicNetwork(baseURL: url.deletingLastPathComponent()))
    }

    init<R: NetworkDataRequest>(request: R, network: Network) {
		self.request = AnyNetworkDataRequest(request)
		self.network = network
	}

	private var cancellable: Cancellable?

	func load(previewMode: NetworkPreviewMode = .noPreview) {

        cancellable = network
            .imageRequest(request, previewMode: previewMode)
			.map { .success($0) }
			.replaceError(with: .error(.unknown))
			.receive(on: DispatchQueue.main)
			.assign(to: \.state, on: self)
	}

	func cancel() {
		cancellable?.cancel()
	}

}
