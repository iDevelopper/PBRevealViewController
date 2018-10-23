//
//  RevealViewController.swift
//  Example3Swift
//
//  Created by Patrick BODET on 27/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class RevealViewController: PBRevealViewController, PBRevealViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        leftViewRevealWidth = 180
        leftViewBlurEffectStyle = .light
        leftToggleSpringDampingRatio = 1.0

        rightPresentViewHierarchically = true
        rightViewBlurEffectStyle = .light
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PBRevealViewController delegate
/*
    func revealController(revealController: PBRevealViewController!, didShowLeftViewController controller: UIViewController!) {
        revealController.mainViewController.view.userInteractionEnabled = false
    }
    
    func revealController(revealController: PBRevealViewController!, didHideLeftViewController controller: UIViewController!) {
        revealController.mainViewController.view.userInteractionEnabled = true
    }
    
    func revealController(revealController: PBRevealViewController!, didShowRightViewController controller: UIViewController!) {
        revealController.mainViewController.view.userInteractionEnabled = false
    }
    
    func revealController(revealController: PBRevealViewController!, didHideRightViewController controller: UIViewController!) {
        revealController.mainViewController.view.userInteractionEnabled = true
    }
*/    
    func revealController(_ revealController: PBRevealViewController!, blockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController!, to toViewController: UIViewController!, finalBlock: (() -> Void)!) -> (() -> Void)! {
    
        if operation == .pushMainControllerFromLeft || operation == .pushMainControllerFromRight {
            let block = {
                () -> Void in
                if operation == .pushMainControllerFromLeft {revealController.revealLeftView()} else {revealController.revealRightView()}
                // superview: Container view
                UIView.transition(with: fromViewController.view.superview!, duration: 0.8, options: [.transitionCurlUp, .showHideTransitionViews], animations: {
                    fromViewController.view.isHidden = true
                    }, completion: { (finished) in
                        finalBlock()
                })
            }
            return block;
        }
        
        if (UIDevice.current.systemVersion as NSString).floatValue >= 10.0 {
            if operation == .replaceLeftController || operation == .replaceRightController {
                let block = {
                    () -> Void in
                    UIView.transition(with: fromViewController.view.superview!, duration: 0.25, options: [.transitionCrossDissolve, .showHideTransitionViews, .layoutSubviews], animations: {
                        fromViewController.view.isHidden = true
                        }, completion: { (finished) in
                            finalBlock()
                    })
                }
                return block;
            }
        }
        
        return nil
    }
}
