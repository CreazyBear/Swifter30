//
//  ViewController.swift
//  RouteManager
//
//  Created by Bear on 2017/8/11.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var jump : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Jump", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.addTarget(self, action: #selector(handleJumpButtonClicked), for: .touchUpInside)
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VC 1"
        view.backgroundColor = UIColor.white
        view.addSubview(jump)
        jump.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        jump.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        jump.widthAnchor.constraint(equalToConstant: 140).isActive = true
        jump.heightAnchor.constraint(equalToConstant: 40).isActive = true
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

