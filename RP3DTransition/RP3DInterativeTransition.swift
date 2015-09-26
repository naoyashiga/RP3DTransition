//
//  RP3DInterativeTransition.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class RP3DInterativeTransition: UIPercentDrivenInteractiveTransition {
    
    private var parentViewController = UIViewController()
    private let percentageAdjustFactor: CGFloat = 2.5
    
    func attachToViewController(viewController: UIViewController) {
        
        parentViewController = viewController
        
        let edgePanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges = UIRectEdge.Left
        
        parentViewController.view.addGestureRecognizer(edgePanRecognizer)
    }
    
    private func handleEdgePanRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        
        var progress = recognizer.translationInView(parentViewController.view).x / parentViewController.view.bounds.size.width / percentageAdjustFactor
        progress = min(1.0, max(0.0, progress))
        
        
        switch recognizer.state {
        case .Began:
            parentViewController.navigationController?.popViewControllerAnimated(true)
            
        case .Changed:
            updateInteractiveTransition(progress)
            
        default:
            
            if recognizer.velocityInView(parentViewController.view).x >= 0 {
                
                finishInteractiveTransition()
                parentViewController.view.removeGestureRecognizer(recognizer)
                
            } else {
                
                cancelInteractiveTransition()
                
            }
            
            break;
        }
    }

}