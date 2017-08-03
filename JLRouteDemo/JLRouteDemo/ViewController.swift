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
        if UIApplication.shared.canOpenURL(URL(string: "Demo2Route2://post/edit/123?debug=true&foo=bar")!)
        {
            let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
            UIApplication.shared.open(URL(string: "Demo2Route2://post/edit/123?debug=true&foo=bar")!, options: options, completionHandler: { (complete) in
                print("finished")
            })
        }
    }

}

