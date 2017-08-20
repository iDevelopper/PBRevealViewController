//
//  AnimationControllerForPush.swift
//  ExampleWithSwiftLibrary
//
//  Created by Patrick BODET on 19/08/2017.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class AnimationControllerForPush: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let fromView = fromViewController?.view
        UIView.transition(with: fromView!, duration: transitionDuration(using: transitionContext), options: [.transitionCurlUp, .showHideTransitionViews] , animations: {
            fromView?.isHidden = true
        }) { (finished) in
            fromView?.isHidden = false
            transitionContext.completeTransition(finished)
        }
    }
}
