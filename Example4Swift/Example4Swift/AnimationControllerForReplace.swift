//
//  AnimationControllerForReplace.swift
//  Example4Swift
//
//  Created by Patrick BODET on 16/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class AnimationControllerForReplace: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let toView = toViewController?.view
        
        let finalToViewFrame = transitionContext.finalFrame(for: toViewController!)
        var initialToViewFrame = finalToViewFrame
        initialToViewFrame.origin.x += finalToViewFrame.size.width
    
        toView!.frame = initialToViewFrame
        transitionContext.containerView.bringSubviewToFront(toView!)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .showHideTransitionViews, animations: {
            toView!.frame = finalToViewFrame
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }

        /*
        UIView.transitionWithView(fromView!, duration: transitionDuration(transitionContext), options: [.TransitionCurlUp, .ShowHideTransitionViews], animations: {
            fromView?.hidden = true
            }) { (finished) in
                transitionContext.completeTransition(finished)
        }
        */
    }
}
