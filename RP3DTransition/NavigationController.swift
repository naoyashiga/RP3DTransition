//
//  NavigationController.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    var interactiveTransition:RP3DInterativeTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = RP3DTransitionAnimator()
        
        switch operation {
        case .Push:
            interactiveTransition = nil
            animator.transitionType = .Push
            return animator
            
        case .Pop:
            animator.transitionType = .Pop
            return animator
            
        default:
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactiveTransition
    }
}
