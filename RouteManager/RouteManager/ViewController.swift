//
//  ViewController.swift
//  RouteManager
//
//  Created by Bear on 2017/8/11.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jump: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        jump.addTarget(self, action: #selector(handleJumpButtonClicked), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleJumpButtonClicked() {
        let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
        let url = URL.init(string: "https://www.baidu.com")
        guard url != nil else {
            return
        }
        UIApplication.shared.open(url!, options: options, completionHandler: nil)
    }


}

