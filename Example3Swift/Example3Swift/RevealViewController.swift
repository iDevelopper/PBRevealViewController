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
        leftViewShadowRadius = 0
        leftViewBlurEffectStyle = .Light
        
        rightPresentViewHierarchically = true
        rightViewBlurEffectStyle = .Light
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PBRevealViewController delegate

    func revealController(revealController: PBRevealViewController!, blockForOperation operation: PBRevealControllerOperation, fromViewController: UIViewController!, toViewController: UIViewController!, finalBlock: (() -> Void)!) -> (() -> Void)! {
        let block = {
            () -> Void in
            UIView.transitionWithView(fromViewController.view, duration: 0.8, options: [.TransitionCurlUp, .ShowHideTransitionViews], animations: {
                fromViewController.view.hidden = true
                }, completion: { (finished) in
                    finalBlock()
            })
        }
        return block;
    }
}
