//
//  URLImage.swift
//  URLImage
//
//  Created by Avario Babushka on 1/10/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI

public struct URLImage: View {
    @EnvironmentObject private var imageLoader: URLImageLoader

	@ObservedObject private var request: URLImageLoader.Request

    public init(url: URL) {
		request = URLImageLoader.Request(url: url)
    }

	public var body: some View {
        ZStack {
            if request.image != nil {
                Image(uiImage: request.image!)
                    .resizable()
            }
        }
		.onAppear { self.imageLoader.load(self.request) }
        .onDisappear(perform: request.cancel)
    }
}
