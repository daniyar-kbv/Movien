//
//  AppDelegate.swift
//  Movien
//
//  Created by Daniyar on 11/24/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MovieListView()
        let navController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navController
        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        return true
    }
}
