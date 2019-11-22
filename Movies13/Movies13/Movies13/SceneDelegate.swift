//
//  SceneDelegate.swift
//  Movies13
//
//  Created by Avario Babushka on 30/09/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else {
			return
		}

		let moviesUserFlow = NavigationView {
			PopularMoviesScreenController()
		}
		.environmentObject(MoviesNetwork())

		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = UIHostingController(rootView: moviesUserFlow)
		self.window = window
		window.makeKeyAndVisible()
	}
}

extension View {
	func eraseToAnyView() -> AnyView {
		return AnyView(self)
	}
}

extension Collection where Element: Identifiable {
	func first(with id: Element.ID) -> Element? {
		first { (element) -> Bool in
			element.id == id
		}
	}

	func first<I: Identifiable>(matching identifiable: I) -> Element? where I.ID == Element.ID {
		first { (element) -> Bool in
			element.id == identifiable.id
		}
	}
}
