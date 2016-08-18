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
        self.toggleAnimationType = PBRevealToggleAnimationType.Custom
        
        self.leftPresentViewOnTop = false
        //self.rightPresentViewOnTop = false
        
        //self.leftViewRevealDisplacement = 0.0
        //self.rightViewRevealDisplacement = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func revealController(revealController: PBRevealViewController!, blockForOperation operation: PBRevealControllerOperation, fromViewController: UIViewController!, toViewController: UIViewController!, finalBlock: (() -> Void)!) -> (() -> Void)!
    {
        let block = {
            () -> Void in
            
            UIView.transitionWithView(fromViewController.view, duration: 0.8, options: [.TransitionFlipFromRight, .ShowHideTransitionViews], animations: {
                fromViewController.view.hidden = true
                }, completion: { (finished) in
                    print("Custom completion")
                    finalBlock()
            })
        }
        return block;
    }
    
    func revealController(revealController: PBRevealViewController!, animationControllerForTransitionFromViewController fromViewController: UIViewController!, toViewController: UIViewController!, forOperation operation: PBRevealControllerOperation) -> UIViewControllerAnimatedTransitioning!
    {
        if operation == PBRevealControllerOperation.ReplaceMainController {
            return AnimationControllerForReplace()
        }
        if operation == PBRevealControllerOperation.ReplaceRightController {
            return AnimationControllerForReplace()
        }
        if operation == PBRevealControllerOperation.PushMainControllerFromLeft {
            let nc = toViewController as! UINavigationController
            if nc.topViewController is SecondViewController {
                return AnimationControllerForPush()
            }
        }
        return nil
    }
    
}
