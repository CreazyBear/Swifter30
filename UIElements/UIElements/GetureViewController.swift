//
//  GetureViewController.swift
//  UIElements
//
//  Created by 熊伟 on 2017/6/20.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import Foundation


class GetureViewController: UIViewController {

    
    lazy var box = {()->UIView in
        let box = UIView.init(frame: CGRect.init(x: 100, y: 199, width: 100, height: 100))
        box.backgroundColor = UIColor.red
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.title = "Gesture"
        
        self.view.addSubview(box)
        
        //tap
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleTapGesture(_:)))
        box.addGestureRecognizer(tapGestureRecognizer)
        //double tap
        let doubleTapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleDoubleTapGesture(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delegate = self
        box.addGestureRecognizer(doubleTapGestureRecognizer)
        
        //longpress
        let longPressGestureRecgonizer = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPressGesture(_:)))
        box.addGestureRecognizer(longPressGestureRecgonizer)
        //swip
        let swipLeftGestureRecgonizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipGesture(_:)))
        swipLeftGestureRecgonizer.direction = .left
        box.addGestureRecognizer(swipLeftGestureRecgonizer)
        
        let swipRightGestureRecgonizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipGesture(_:)))
        swipRightGestureRecgonizer.direction = .right
        box.addGestureRecognizer(swipRightGestureRecgonizer)
        
        let swipUpGestureRecgonizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipGesture(_:)))
        swipUpGestureRecgonizer.direction = .up
        box.addGestureRecognizer(swipUpGestureRecgonizer)
        
        let swipDownGestureRecgonizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipGesture(_:)))
        swipDownGestureRecgonizer.direction = .down
        box.addGestureRecognizer(swipDownGestureRecgonizer)
        
        //pan
        let panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(handlePanGesture(_:)))
        box.addGestureRecognizer(panGestureRecognizer)
        
        //pinch
        let pinchGestureRecgonizer = UIPinchGestureRecognizer.init(target: self, action: #selector(handlePinchGesture(_:)))
        pinchGestureRecgonizer.delegate = self
        box.addGestureRecognizer(pinchGestureRecgonizer)
        
        //rotation:
        let rotationGestureRecgonizer = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotationGesture(_:)))
        rotationGestureRecgonizer.delegate = self
        box.addGestureRecognizer(rotationGestureRecgonizer)
        //MARK: 如果需要同时旋转和缩放需要设置代码方法返回true
        
        
        //MARK: 1.当navigationController左滑返回的优先级更高。2.只会响应边缘开始的滑动，大概只有12px响应区域
        
        let screenEdgePanGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(handleEdgePanGesture(_:)))
        screenEdgePanGesture.edges = .all
        self.view.addGestureRecognizer(screenEdgePanGesture)
        
    }
    
    var rate:CGFloat = 100.0
    func handleTapGesture(_ gesture:UIGestureRecognizer) {
        
        
        UIView.animate(withDuration: 2, animations: {
            self.box.frame = CGRect.init(x: self.box.frame.origin.x, y: self.box.frame.origin.y, width: self.rate, height: self.rate)
            self.rate += 100.0
            
        })
    }
    
    func handleDoubleTapGesture(_ gesture:UIGestureRecognizer) {
        UIView.animate(withDuration: 2, animations: {
            self.box.frame = CGRect.init(x: self.box.frame.origin.x, y: self.box.frame.origin.y, width: 50, height: 50)
            
        })
    }
    
    func handleLongPressGesture(_ gesture:UIGestureRecognizer) {
        UIView.animate(withDuration: 2) {
            self.box.backgroundColor = UIColor.gray
        }
    }
    
    func handleSwipGesture(_ gesture:UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.left:
            UIView.animate(withDuration: 2, animations: {
                self.box.frame = CGRect.init(x: self.box.frame.origin.x-100, y: self.box.frame.origin.y, width: 50, height: 50)
                
            })
        case UISwipeGestureRecognizerDirection.right:
            UIView.animate(withDuration: 2, animations: {
                self.box.frame = CGRect.init(x: self.box.frame.origin.x+100, y: self.box.frame.origin.y, width: 50, height: 50)
                
            })
        case UISwipeGestureRecognizerDirection.up:
            UIView.animate(withDuration: 2, animations: {
                self.box.frame = CGRect.init(x: self.box.frame.origin.x, y: self.box.frame.origin.y-100, width: 50, height: 50)
                
            })
        case UISwipeGestureRecognizerDirection.down:
            UIView.animate(withDuration: 2, animations: {
                self.box.frame = CGRect.init(x: self.box.frame.origin.x, y: self.box.frame.origin.y+100, width: 50, height: 50)
                
            })
        default:
            break
        }
        
    }
    
    func handlePanGesture(_ gesture:UIPanGestureRecognizer) {
        
        let transP = gesture.translation(in: box)
        self.box.transform = self.box.transform.translatedBy(x: transP.x, y: transP.y)
        gesture.setTranslation(CGPoint.zero, in: self.box)
    }
    
    func handlePinchGesture(_ gesture:UIPinchGestureRecognizer) {
        self.box.transform = self.box.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1.0
    }
    
    func handleRotationGesture(_ gesture:UIRotationGestureRecognizer) {
        self.box.transform = self.box.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
    
    func handleEdgePanGesture(_ gesture:UIScreenEdgePanGestureRecognizer) {
        
    }
}

extension GetureViewController :UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
