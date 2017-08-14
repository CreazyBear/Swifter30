//
//  ViewController.swift
//  JLRouteDemo
//
//  Created by Bear on 2017/8/1.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var JumpToDemo2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JumpToDemo2.addTarget(self, action: #selector(self.handleJumpToDemo2), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //myapp://user/view/joeldev

    func handleJumpToDemo2() {
        let url = "bgrouter://page?className=RouteManager.BGViewController2&params=%7B%22title%22%3A%22hello%22%7D"
        if UIApplication.shared.canOpenURL(URL(string: url)!)
        {
            let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
            UIApplication.shared.open(URL(string: url)!, options: options, completionHandler: { (complete) in
                print("finished")
            })
        }
    }

}

