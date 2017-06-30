//
//  InteractiveTransitionManager.swift
//  ViewControllerTransitionDemo
//
//  Created by Bear on 2017/6/30.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit




/// 交互过渡动画，通过对panGesture的属性进行分析，来调用UIPercentDrivenInteractiveTransition的接口
class InteractiveTransitionManager: UIPercentDrivenInteractiveTransition {
    
    let animatedTime = 0.35
    var operation: UINavigationControllerOperation = .none
    var isInteracting = false
    var containerView: UIView!
    
    
    /// 本例使用的是NavigationController的pop操作，所以传入的是navigationViewController。
    /// 此属性用来计算，交互动画进行的百分比
    var navigationController: UINavigationController! = nil {
        didSet {
            containerView = navigationController.view
            containerView.addGestureRecognizer(panGesture)
        }
    }
    var panGesture: UIPanGestureRecognizer! = nil {
        didSet {
            panGesture.addTarget(self, action: #selector(self.handlePan(gesture:)))
        }
    }
    
    
    /// 处理滑动手势
    ///
    /// - Parameter gesture: 滑动手势
    func handlePan(gesture: UIPanGestureRecognizer) {
        
        func finishOrCancel() {
            let translation = gesture.translation(in: containerView)
            let percent = translation.x / containerView.bounds.width
            let velocityX = gesture.velocity(in: containerView).x
            let isFinished: Bool
            
            // 修改这里可以改变手势结束时的处理
            if velocityX > 100 {
                isFinished = true
            } else if percent > 0.5 {
                isFinished = true
            } else{
                isFinished = false
            }
            
            isFinished ? finish() : cancel()
        }
        
        switch gesture.state {
            
        case .began:
            isInteracting = true
            // pop
            if navigationController.viewControllers.count > 0 {
                //navigationController的delegate在ViewControllerTwo中已经设置好了
                //这里调用pop会调用到下面extension的delegate
                _ = navigationController.popViewController(animated: true)
            }
        case .changed:
            if isInteracting {
                let translation = gesture.translation(in: containerView)
                var percent = translation.x / containerView.bounds.width
                percent = max(percent, 0)
                update(percent)
                
            }
        case .cancelled:
            if isInteracting {
                finishOrCancel()
                isInteracting = false
            }
        case .ended:
            if isInteracting {
                finish()
                isInteracting = false
            }
        default:
            break
            
        }
        
        
    }
    
}

///在提供交互过渡时，以面两个接口都需要实现
extension InteractiveTransitionManager: UINavigationControllerDelegate
{
    
    /// 提供非交互动画 UIViewControllerAnimatedTransitioning
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC.isKind(of: ViewController.self)
        {
            return InteractivePushTransitionManager()
        }
        else
        {
            return InteractivePopTransitionManager()
        }
        
    }
    
    /// 提供交互型动画 UIPercentDrivenInteractiveTransition
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return self
    }
}


class InteractivePushTransitionManager :NSObject, UIViewControllerAnimatedTransitioning{
    
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

class InteractivePopTransitionManager:NSObject, UIViewControllerAnimatedTransitioning {
    
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


