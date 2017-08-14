//
//  AppDelegate.swift
//  RouteManager
//
//  Created by Bear on 2017/8/11.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import JLRoutes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav : BGNavigationViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        nav = BGNavigationViewController(rootViewController: ViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        initRoute()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return JLRoutes.routeURL(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return JLRoutes.routeURL(url)
    }

    func initRoute() {
        JLRoutes.init(forScheme: "bgrouter").addRoute("/page") { (params:[String : Any]) -> Bool in
            let className = params["className"]
            let urlParmas = (params["params"] as? String ?? "").removingPercentEncoding
            let urlParamsData = urlParmas?.data(using: .utf8)
            let urlParamsDic = try! JSONSerialization.jsonObject(with: urlParamsData!, options: JSONSerialization.ReadingOptions.mutableContainers)
            let targetClass = NSClassFromString(className as! String) as! NSObject.Type
            let targetVC = targetClass.init()
            self.nav?.pushViewController(targetVC as! UIViewController, animated: true)
            return true
        }
    }


}
