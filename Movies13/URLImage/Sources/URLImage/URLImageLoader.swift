//
//  File.swift
//  
//
//  Created by Avario Babushka on 7/10/19.
//

import UIKit
import Combine

final public class URLImageLoader: ObservableObject {

    public enum Source {
        case preview
        case network
    }

    private let source: Source

    public init(source: Source) {
        self.source = source
    }

    internal func load(_ request: Request) {
        switch source {
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
