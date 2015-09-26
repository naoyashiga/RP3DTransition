//
//  RP3DTransitionAnimator.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class RP3DTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let kForwardAnimationDuration: NSTimeInterval = 0.3
    let kForwardCompleteAnimationDuration: NSTimeInterval = 0.3
    
    var isPush = false
    let rotateAngle: CGFloat = CGFloat(M_PI_4)
    
    private(set) weak var transitionContext: UIViewControllerContextTransitioning?
    
    var containerView: UIView? {
        return transitionContext?.containerView()
    }
    
    var toViewController: UIViewController? {
        return transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)
        //            return transitionContext.viewControllerForKey(isPush ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey)
    }
    
    var fromViewController: UIViewController? {
        return transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)
        //            return transitionContext.viewControllerForKey(isPush ? UITransitionContextFromViewControllerKey : UITransitionContextToViewControllerKey)
    }
    
    private func prepare() {
        
        guard let fromViewController = fromViewController, toViewController = toViewController else {
            return
        }
        
        toViewController.view.layer.zPosition = fromViewController.view.layer.zPosition + 1
    }
    
    private func start() {
        guard let fromViewController = fromViewController, toViewController = toViewController, containerView = containerView else {
            return
        }
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        var leftViewTransform = CATransform3DIdentity
        leftViewTransform.m34 = 1.0 / -500
        leftViewTransform = CATransform3DRotate(leftViewTransform, rotateAngle, 0, 1, 0)
        leftViewTransform = CATransform3DTranslate(leftViewTransform, -screenWidth / 2, 0, -screenWidth / 2)
        
        var rightViewTransform = CATransform3DIdentity
        rightViewTransform.m34 = 1.0 / -500
        rightViewTransform = CATransform3DTranslate(rightViewTransform, screenWidth, 0, 0)
        rightViewTransform = CATransform3DTranslate(rightViewTransform, -screenWidth / 2, 0, 0)
        rightViewTransform = CATransform3DRotate(rightViewTransform, -rotateAngle, 0, 1, 0)
        rightViewTransform = CATransform3DTranslate(rightViewTransform, screenWidth / 2, 0, 0)
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        toViewController.view.layer.transform = rightViewTransform
        fromViewController.view.alpha = 1
        
        UIView.animateWithDuration(kForwardAnimationDuration, delay: 0, options: .CurveEaseOut, animations: {
            
            fromViewController.view.layer.transform = leftViewTransform
            fromViewController.view.alpha = 0
            
            toViewController.view.layer.transform = CATransform3DIdentity
            
            }, completion: { finished in
                
                self.transitionContext!.completeTransition(!self.transitionContext!.transitionWasCancelled())
        })
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return kForwardAnimationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        prepare()
        
        start()
        
    }
}
