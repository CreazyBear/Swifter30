//
//  AppDelegate.swift
//  PhotoScroll
//
//  Created by Bear on 2017/6/28.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

