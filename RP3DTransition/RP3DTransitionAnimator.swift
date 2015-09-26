//
//  RP3DTransitionAnimator.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

enum TransitionType {
    case Push,Pop
}

class RP3DTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let kForwardAnimationDuration: NSTimeInterval = 0.3
    let kForwardCompleteAnimationDuration: NSTimeInterval = 0.3
    
    
    let duration: Double = 0.55
    let relativeDelayLeftView: Double = 0.09
    let relativeDelayRightView: Double = 0.12
    
    let rotateAngle: CGFloat = CGFloat(M_PI_4)
    
    var transitionType = TransitionType.Push
    
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
        
        switch transitionType {
        case .Push:
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            toViewController.view.layer.transform = rightViewTransform
            fromViewController.view.alpha = 1
            
            UIView.animateKeyframesWithDuration(kForwardAnimationDuration, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: {
                
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1, animations: {
                    fromViewController.view.layer.transform = leftViewTransform
                    fromViewController.view.alpha = 0
                })
                
                UIView.addKeyframeWithRelativeStartTime(
                    self.relativeDelayLeftView / self.duration,
                    relativeDuration: 1 - self.relativeDelayLeftView / self.duration,
                    animations: {
                        toViewController.view.layer.transform = CATransform3DIdentity
                })
                
                }, completion: { finished in
                    
                    self.transitionContext!.completeTransition(!self.transitionContext!.transitionWasCancelled())
            })
            
        case .Pop:
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            toViewController.view.layer.transform = leftViewTransform
            toViewController.view.alpha = 0
            
            UIView.animateKeyframesWithDuration(kForwardAnimationDuration, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: {
                
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1, animations: {
                    fromViewController.view.layer.transform = rightViewTransform
                })
                
                UIView.addKeyframeWithRelativeStartTime(
                    self.relativeDelayRightView / self.duration,
                    relativeDuration: 1 - self.relativeDelayRightView / self.duration,
                    animations: {
                        toViewController.view.layer.transform = CATransform3DIdentity
                })
                
                UIView.addKeyframeWithRelativeStartTime(
                    0,
                    relativeDuration: 0.85,
                    animations: {
                        toViewController.view.alpha = 0.5
                })
                
                UIView.addKeyframeWithRelativeStartTime(
                    0.85,
                    relativeDuration: 0.15,
                    animations: {
                        toViewController.view.alpha = 1
                })
                
                }, completion: { finished in
                    
                    self.transitionContext!.completeTransition(!self.transitionContext!.transitionWasCancelled())
            })
            
        }
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
