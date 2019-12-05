//
//  AppDelegate.swift
//  Movien
//
//  Created by Daniyar on 11/24/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginView()
        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()

        return true
    }
}
