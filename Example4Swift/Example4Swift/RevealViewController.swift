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
        self.toggleAnimationType = PBRevealToggleAnimationType.Spring
        //self.toggleAnimationType = PBRevealToggleAnimationType.Custom
        
        self.leftPresentViewOnTop = false
        //self.rightPresentViewOnTop = false
        
        //self.leftViewRevealDisplacement = 0.0
        //self.rightViewRevealDisplacement = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func revealController(revealController: PBRevealViewController!, blockForOperation operation: PBRevealControllerOperation, fromViewController: UIViewController!, toViewController: UIViewController!, finalBlock: (() -> Void)!) -> (() -> Void)! {
        let block = {
            () -> Void in
        
            UIView.transitionFromView(fromViewController.view, toView: toViewController.view, duration: 0.8, options: .TransitionCurlUp, completion: { (finished) in
                print("Custom completion")
                finalBlock()
            })
            
        }
        return block;
    }
}
