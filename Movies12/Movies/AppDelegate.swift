//
//  AppDelegate.swift
//  Movies
//
//  Created by Avario on 09/09/2018.
//  Copyright © 2018 Avario. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = .movieBlue
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let moviesScreen = MoviesListScreen(moviesNetwork: MoviesNetwork())
        let moviesNavigationController = UINavigationController(rootViewController: moviesScreen)
        moviesNavigationController.navigationBar.barStyle = .black
        moviesNavigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = moviesNavigationController
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
