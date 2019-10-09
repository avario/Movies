//
//  SceneDelegate.swift
//  Movies13
//
//  Created by Avario Babushka on 30/09/19.
//  Copyright © 2019 Avario Babushka. All rights reserved.
//

import UIKit
import SwiftUI
import URLImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		let moviesUserFlow = NavigationView {
			MoviesListScreen(
				model: MoviesListModel(),
				actions: MoviesListActions(moviesNetwork: MoviesNetwork()))
		}
		
		if let windowScene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: windowScene)
			window.rootViewController = UIHostingController(rootView: moviesUserFlow)
			self.window = window
			window.makeKeyAndVisible()
		}
	}
	
}

