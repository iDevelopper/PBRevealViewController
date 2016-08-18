//
//  AnimationControllerForPush.swift
//  Example4Swift
//
//  Created by Patrick BODET on 16/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class AnimationControllerForPush: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromViewController?.view
        UIView.transitionWithView(fromView!, duration: transitionDuration(transitionContext), options: [.TransitionCurlUp, .ShowHideTransitionViews] , animations: {
            fromView?.hidden = true
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
