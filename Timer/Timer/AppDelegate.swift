//
//  AppDelegate.swift
//  Timer
//
//  Created by 熊伟 on 2017/6/24.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewContrller:ViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        rootViewContrller = ViewController()
        self.window?.rootViewController = rootViewContrller
        self.window?.makeKeyAndVisible()
        return true
    }
}

