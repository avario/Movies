//
//  SceneDelegate.swift
//  Movies13
//
//  Created by Avario Babushka on 30/09/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = scene as? UIWindowScene else {
			return
		}

		let moviesUserFlow = NavigationView {
			PopularMoviesScreen()
		}
		.environmentObject(MoviesNetwork())//.preview(mode: .success))
//		.environment(\.networkImagePreviewMode, .success)

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

