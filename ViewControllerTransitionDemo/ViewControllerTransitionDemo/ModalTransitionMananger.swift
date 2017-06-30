//
//  ModalTransitionMananger.swift
//  ViewControllerTransitionDemo
//
//  Created by Bear on 2017/6/30.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ModalTransitionMananger: NSObject {
    fileprivate var presenting = false
}

extension ModalTransitionMananger: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        //MARK: 这里有个问题：如果from的viewcontroller来自一个navigationController的话，这里得到的fromViewController也是一个
        //navigationController. 对navigationController的View操作不当的话，会引起黑屏，即所有的view都不可见
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)

        let vcTwo = !self.presenting ? screens.from : screens.to
        let vcOne = !self.presenting ? screens.to : screens.from
        
        let vcTwoView = vcTwo.view
        let vcOneView = vcOne.view
        
        
        
        
        //MARK: 原项目里将两个view都加到container里面了，但，container里面默认是有from的view的。
        //也就是，我们只用添加to的View到container里就好了。
        //再次就是如果不改变view的alpha的话，view会存在遮挡的问题，也就是有的动画是会被盖住的
        if presenting
        {
            container.addSubview(vcTwoView!)
            container.bringSubview(toFront: vcTwoView!)
            (vcTwo as! ViewControllerTwo).imageView.transform = CGAffineTransform(translationX: 400, y: 0)
            vcTwoView?.alpha = 0
        }
        else
        {
            container.addSubview(vcOneView!)
            container.bringSubview(toFront: vcTwoView!)
        }
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                (vcTwo as! ViewControllerTwo).imageView.transform = CGAffineTransform.identity
                vcTwoView?.alpha = 1.0
            }
            else {
                (vcTwo as! ViewControllerTwo).imageView.transform = CGAffineTransform(translationX: 400, y: 0)
                vcTwoView?.alpha = 0.0
            }
            
        }, completion: { finished in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
            
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
}

extension ModalTransitionMananger: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
