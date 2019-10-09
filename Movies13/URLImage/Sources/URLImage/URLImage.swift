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

    @Environment(\.urlImagePreview) private var preview: URLImagePreview

    @ObservedObject private var imageLoader: ImageLoader

    public init(url: URL) {
        imageLoader = ImageLoader(url: url)
    }

    public var body: some View {
        ZStack {
            imageLoader.image.map { image in
                Image(uiImage: image)
                    .resizable()
            }
        }
        .onAppear(perform: imageLoader.load)
        .onDisappear(perform: imageLoader.cancel)
    }
}

final internal class ImageLoader: ObservableObject {

    @Published private(set) var image: UIImage? = nil

    private let url: URL
    private let preview: URLImagePreview

    private var cancellable: AnyCancellable?

    init(url: URL, preview: URLImagePreview) {
        self.url = url
        self.preview = preview
    }

    deinit {
        cancellable?.cancel()
    }

    func load() {
        cancel()

        guard image == nil else {
            return
        }

        switch preview {
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

public enum URLImagePreview: EnvironmentKey {

    case automatic
    case always
    case never

    public static let defaultValue: URLImagePreview = .automatic
}

public extension EnvironmentValues {
    var urlImagePreview: URLImagePreview {
        get {
            return self[URLImagePreview.self]
        }
        set {
            self[URLImagePreview.self] = newValue
        }
    }
}
