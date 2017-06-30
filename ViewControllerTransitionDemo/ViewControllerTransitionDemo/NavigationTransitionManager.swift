//
//  TransitionManager.swift
//  ViewControllerTransitionDemo
//
//  Created by Bear on 2017/6/30.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class NavigationPushTransitionManager :NSObject, UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        let container = transitionContext.containerView
        let vcTwo = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! ViewControllerTwo
        let vcOne = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! ViewController

        let vcTwoView = vcTwo.view
        let vcOneView = vcOne.view
        
        container.addSubview(vcTwoView!)
        container.bringSubview(toFront: vcOneView!)
        
        vcTwo.imageView.transform = CGAffineTransform(translationX: -400, y: 0)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            
            vcOneView?.alpha = 0.0
            vcOneView?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            vcTwoView?.alpha = 1.0
            
            vcTwo.imageView.transform = CGAffineTransform.identity
            
        }, completion: { finished in
            vcOneView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            vcOneView?.alpha = 1.0
            transitionContext.completeTransition(true)
        })
    }
    
}

class NavigationPopTransitionManager: NSObject,UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 1.0
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        let container = transitionContext.containerView
        let vcTwo = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! ViewControllerTwo
        let vcOne = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! ViewController
        
        let vcTwoView = vcTwo.view
        let vcOneView = vcOne.view
        
        container.addSubview(vcOneView!)
        container.bringSubview(toFront: vcTwoView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        vcOne.button.transform = CGAffineTransform(translationX: 400, y: 0)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            
            vcTwoView?.alpha = 0.0
            vcTwoView?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            vcOneView?.alpha = 1.0
            
            vcOne.button.transform = CGAffineTransform.identity
            
        }, completion: { finished in
            vcTwoView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            vcTwoView?.alpha = 1.0
            transitionContext.completeTransition(true)
        })
    }

}


class NavigationTransitionManager:NSObject, UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC.isKind(of: ViewController.self)
        {
            return NavigationPushTransitionManager()
        }
        else
        {
            return NavigationPopTransitionManager()
        }
        
    }
}
