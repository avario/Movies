//
//  File.swift
//  
//
//  Created by Avario Babushka on 7/10/19.
//

import UIKit
import Combine

final public class URLImageLoader: ObservableObject {

    internal enum Setting {
        case preview
        case network
    }

    private var setting: Setting = .network

    public init() { }

    internal func load(_ request: Request) {
        switch setting {
        case .preview:
            let localURL = request.url.deletingPathExtension()
            var localName = localURL.absoluteString
            if let scheme = localURL.scheme {
                localName = localName.replacingOccurrences(of: scheme, with: "").replacingOccurrences(of: "://", with: "")
            }
            
            request.image = UIImage(named: localName)

        case .network:
            request.cancel()

            guard request.image == nil else {
                return
            }

            request.cancellable = URLSession.shared
                .dataTaskPublisher(for: request.url)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in }, receiveValue: { [unowned request] (image) in
                    request.image = image
                })
        }
    }

    public func alwaysPreview() -> Self {
        setting = .preview
        return self
    }

    internal class Request: ObservableObject {

        @Published var image: UIImage? = nil

        let url: URL
        var cancellable: AnyCancellable?

        init(url: URL) {
            self.url = url
        }

        deinit {
            cancellable?.cancel()
        }

        func cancel() {
            cancellable?.cancel()
        }
    }

}
