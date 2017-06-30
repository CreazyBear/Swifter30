//
//  ViewController.swift
//  ViewControllerTransitionDemo
//
//  Created by Bear on 2017/6/29.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    let navigationTransitionManager = NavigationTransitionManager()
    
    let modalTransitionManager = ModalTransitionMananger()
    
    let interactiveTransitionManager = InteractiveTransitionManager()
    
    
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
        let vcTwo = ViewControllerTwo()
        
        //MARK: 这个是使用navigationController的自定义动画，在push的VC里也需要设置对应的delegate
//        navigationController?.delegate = navigationTransitionManager
//        navigationController?.pushViewController(vcTwo, animated: true)
        
        //MARK: 这里是使用present方式展示自定义动画的设置，from和to的transitioningDelegate都需要在这里设置，而在to的VC中则不需要再做其设置
//        self.transitioningDelegate = modalTransitionManager
//        vcTwo.transitioningDelegate = modalTransitionManager
//        self.present(vcTwo, animated: true, completion: nil)
        
        navigationController?.pushViewController(vcTwo, animated: true)
        
        
    }

}
