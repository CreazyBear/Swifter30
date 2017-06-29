//
//  ViewController.swift
//  DotDemo
//
//  Created by Bear on 2017/6/29.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dotOne : UIImageView!
    var dotTwo : UIImageView!
    var dotThree : UIImageView!
    
    lazy var logoImage : UIImageView = {
        let view : UIImageView = UIImageView(frame: CGRect.init(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 100))
        view.image = #imageLiteral(resourceName: "logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        view.addSubview(logoImage)
        
        dotOne = generateImgeView(frame: CGRect.init(x: 50, y: 150, width: 30, height: 30))
        dotTwo = generateImgeView(frame: CGRect.init(x: 90, y: 150, width: 30, height: 30))
        dotThree = generateImgeView(frame: CGRect.init(x: 130, y: 150, width: 30, height: 30))
        
        view.addSubview(dotOne)
        view.addSubview(dotTwo)
        view.addSubview(dotThree)
        startAnimation()
    }
    
    func startAnimation()
    {
        dotOne.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotTwo.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotThree.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.dotOne.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.dotTwo.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            self.dotThree.transform = CGAffineTransform.identity
        }, completion: nil)
    }


    func generateImgeView(frame:CGRect) -> UIImageView {
        let view : UIImageView = UIImageView(frame: frame)
        view.image = #imageLiteral(resourceName: "dot")
        view.contentMode = .scaleAspectFit
        return view
    }
}

