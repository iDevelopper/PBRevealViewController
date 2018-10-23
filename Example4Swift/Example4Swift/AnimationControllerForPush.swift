//
//  AnimationControllerForPush.swift
//  Example4Swift
//
//  Created by Patrick BODET on 16/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class AnimationControllerForPush: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) {
            if let revealViewController = fromViewController.revealViewController() {
                revealViewController.revealLeftView()
            }
            let fromView = fromViewController.view!
            UIView.transition(with: fromView.superview!, duration: transitionDuration(using: transitionContext), options: [.transitionCurlUp, .showHideTransitionViews] , animations: {
                fromView.isHidden = true
            }) { (finished) in
                transitionContext.completeTransition(finished)
            }
        }
    }
}
