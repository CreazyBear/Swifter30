//
//  AppDelegate.swift
//  SearchCandy
//
//  Created by Bear on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var navMaster:UINavigationController?
    var navDetail:UINavigationController?
    let splitViewController = UISplitViewController.init()
    let masterVC = MasterViewController()
    let detailVC = DetailViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        navMaster = UINavigationController.init(rootViewController: masterVC)
        navMaster!.navigationBar.backgroundColor = UIColor.candyGreen()
        
        navDetail = UINavigationController.init(rootViewController: detailVC)
        navDetail!.navigationBar.backgroundColor = UIColor.candyGreen()
        
        splitViewController.viewControllers = [navMaster!,navDetail!]
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
        
        UISearchBar.appearance().barTintColor = UIColor.candyGreen()
        UISearchBar.appearance().tintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.candyGreen()
        UINavigationBar.appearance().barTintColor = UIColor.candyGreen()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    // MARK: - Split view
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailCandy == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController?
    {
        return nil
    }
    
    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController?
    {
        return nil
    }


}

extension UIColor {
    static func candyGreen() -> UIColor {
        return UIColor(red: 67.0/255.0, green: 205.0/255.0, blue: 135.0/255.0, alpha: 1.0)
    }
}
