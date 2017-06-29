//
//  ViewController.swift
//  ViewControllerTransitionDemo
//
//  Created by Bear on 2017/6/29.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var button : UIButton = {
        let view : UIButton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        view.center = self.view.center
        view.backgroundColor = UIColor.gray
        view.addTarget(self, action: #selector(self.startTransition), for: .touchUpInside)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TransitionDemo"
        view.backgroundColor = UIColor.white
        view.addSubview(button)
    }
    
    @objc
    func startTransition() {
        
        navigationController?.pushViewController(ViewControllerTwo(), animated: true)
    }

}

