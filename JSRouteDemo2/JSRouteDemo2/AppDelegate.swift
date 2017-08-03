//
//  AppDelegate.swift
//  JSRouteDemo2
//
//  Created by Bear on 2017/8/1.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import JLRoutes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let routes = JLRoutes.global()
        routes.addRoute("/:object/:action/:primaryKey") { (params: [String : Any]) -> Bool in
            
            print(String(describing: params))
            return true
        }
        
        JLRoutes.init(forScheme: "Demo2Route1").addRoute("/:object/:action/:primaryKey") { (params:[String : Any]) -> Bool in
            print("---Demo2Route1---\n")
            print(String(describing: params))
            return true
        }
        JLRoutes.init(forScheme: "Demo2Route2").addRoute("/:object/:action/:primaryKey") { (params:[String : Any]) -> Bool in
            print("---Demo2Route2---\n")
            print(String(describing: params))
            return true
        }
        JLRoutes.init(forScheme: "Demo2Route3").addRoute("/:object/:action/:primaryKey") { (params:[String : Any]) -> Bool in
            print("---Demo2Route3---\n")
            print(String(describing: params))
            return true
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return JLRoutes.routeURL(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return JLRoutes.routeURL(url)
    }

}

