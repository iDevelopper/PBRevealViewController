//
//  AnimationControllerForReplace.swift
//  Example4Swift
//
//  Created by Patrick BODET on 16/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class AnimationControllerForReplace: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let toView = toViewController?.view
        
        let finalToViewFrame = transitionContext.finalFrameForViewController(toViewController!)
        var initialToViewFrame = finalToViewFrame
        initialToViewFrame.origin.x += finalToViewFrame.size.width
    
        toView!.frame = initialToViewFrame
        transitionContext.containerView()?.bringSubviewToFront(toView!)

        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, options: [.TransitionNone, .ShowHideTransitionViews], animations: {
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
