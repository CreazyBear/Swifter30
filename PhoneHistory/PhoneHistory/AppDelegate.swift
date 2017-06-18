//
//  AppDelegate.swift
//  PhoneHistory
//
//  Created by Bear on 2017/6/15.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var tabBar: UITabBarController?
    
    
    var navigationController : UINavigationController?
    var viewController:ViewController?
    var aboutMeViewController: AboutMeViewController?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        viewController = ViewController.init(title: "PhoneList")
        
        navigationController = UINavigationController.init(rootViewController: viewController!)
        aboutMeViewController = AboutMeViewController()
        aboutMeViewController?.title = "AboutMe"
        
        tabBar =  UITabBarController.init()
        tabBar?.viewControllers = [navigationController!,aboutMeViewController!]

        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        return true
    }
}

