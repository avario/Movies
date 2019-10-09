//
//  URLImage.swift
//  URLImage
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import Combine

public struct URLImage: View {

    @Environment(\.urlImagePreviewMode) private var previewMode: PreviewMode

    @ObservedObject private var imageLoader = ImageLoader()
	
	private let url: URL
	
	public init(url: URL) {
		self.url = url
	}

    public var body: some View {
        ZStack {
            imageLoader.image.map { image in
                Image(uiImage: image)
                    .resizable()
            }
        }
		.onAppear { self.imageLoader.load(url: self.url, previewMode: self.previewMode) }
        .onDisappear(perform: imageLoader.cancel)
    }
	
	public enum PreviewMode: EnvironmentKey {

		case automatic
		case always
		case never

		public static let defaultValue: PreviewMode = .automatic
	}
}

final internal class ImageLoader: ObservableObject {

    @Published private(set) var image: UIImage? = nil

    private var cancellable: AnyCancellable?

    deinit {
        cancellable?.cancel()
    }

	func load(url: URL, previewMode: URLImage.PreviewMode) {
        cancel()

        guard image == nil else {
            return
        }

        switch previewMode {
        case .automatic:
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
                fallthrough
            }
        case .always:
            let localURL = url.deletingPathExtension()
            var localName = localURL.absoluteString
            if let scheme = localURL.scheme {
                localName = localName.replacingOccurrences(of: scheme, with: "").replacingOccurrences(of: "://", with: "")
            }

            image = UIImage(named: localName)
            return
        case .never:
            break
        }

        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [unowned self] (image) in
                self.image = image
            })
    }

    func cancel() {
        cancellable?.cancel()
    }

}

public extension EnvironmentValues {
	var urlImagePreviewMode: URLImage.PreviewMode {
        get {
			return self[URLImage.PreviewMode.self]
        }
        set {
			self[URLImage.PreviewMode.self] = newValue
        }
    }
}
