//
//  AppDelegate.swift
//  evchargers
//
//  Created by John on 30/12/2018.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyCIK2e8WKgIpfWqSCWjuIg7tQOGlF0Wwhw")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MapRouter.createModule()
        window?.makeKeyAndVisible()
        
        return true
    }
}

