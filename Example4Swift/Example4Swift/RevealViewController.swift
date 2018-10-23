//
//  RevealViewController.swift
//  Example4Swift
//
//  Created by Patrick BODET on 10/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class RevealViewController: PBRevealViewController, PBRevealViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.leftViewRevealWidth = 160.0
        
        //self.toggleAnimationType = PBRevealToggleAnimationType.None
        //self.toggleAnimationType = PBRevealToggleAnimationType.CrossDissolve
        //self.toggleAnimationType = PBRevealToggleAnimationType.PushSideView
        //self.toggleAnimationType = PBRevealToggleAnimationType.Spring
        self.toggleAnimationType = PBRevealToggleAnimationType.custom
        
        self.leftPresentViewOnTop = false
        //self.rightPresentViewOnTop = false
        
        //self.leftViewRevealDisplacement = 0.0
        //self.rightViewRevealDisplacement = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func revealController(_ revealController: PBRevealViewController!, blockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController!, to toViewController: UIViewController!, finalBlock: (() -> Void)!) -> (() -> Void)!
    {
        let block = {
            () -> Void in
            
            UIView.transition(with: fromViewController.view.superview!, duration: 0.8, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: {
                fromViewController.view.isHidden = true
                }, completion: { (finished) in
                    print("Custom completion")
                    finalBlock()
            })
        }
        return block;
    }
    
    func revealController(_ revealController: PBRevealViewController!, animationControllerForTransitionFrom fromViewController: UIViewController!, to toViewController: UIViewController!, for operation: PBRevealControllerOperation) -> UIViewControllerAnimatedTransitioning!
    {
        if operation == PBRevealControllerOperation.replaceMainController {
            return AnimationControllerForReplace()
        }
        if operation == PBRevealControllerOperation.replaceRightController {
            return AnimationControllerForReplace()
        }
        if operation == PBRevealControllerOperation.pushMainControllerFromLeft {
            let nc = toViewController as! UINavigationController
            if nc.topViewController is SecondViewController {
                return AnimationControllerForPush()
            }
        }
        return nil
    }
    
}
