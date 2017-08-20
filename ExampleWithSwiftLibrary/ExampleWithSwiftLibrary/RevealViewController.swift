//
//  RevealViewController.swift
//  ExampleWithSwiftLibrary
//
//  Created by Patrick BODET on 19/08/2017.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit
import PBRevealViewController

class RevealViewController: PBRevealViewController, PBRevealViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.leftViewRevealWidth = 160.0
        
        self.leftViewBlurEffectStyle = .light
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PBRevealViewControllerDelegate Protocol
    
    func revealController(_ revealController: PBRevealViewController, shouldShowLeft viewController: UIViewController) -> Bool
    {
        print("shouldShowLeft:")
        return true
    }
    
    func revealController(_ revealController: PBRevealViewController, willShowLeft viewController: UIViewController)
    {
        print("willShowLeft:")
        
        let nc = revealViewController()?.leftViewController as! UINavigationController
        let menuTableViewController = nc.topViewController as! MenuTableViewController
        
        if let nc = menuTableViewController.settingsNavigationController {
            let settingsViewController = nc.topViewController as! SettingsViewController
            mainViewController?.view.isUserInteractionEnabled = settingsViewController.isMainUserInteraction
            if settingsViewController.isMainUserInteraction == false {
                mainViewController?.view.alpha = 0.9
            }
        }
    }
    
    func revealController(_ revealController: PBRevealViewController, didShowLeft viewController:UIViewController)
    {
        print("didShowLeft:")
    }
    
    func revealController(_ revealController: PBRevealViewController, willHideLeft viewController: UIViewController)
    {
        print("willHideLeft:")
        
        mainViewController?.view.isUserInteractionEnabled = true
        mainViewController?.view.alpha = 1
    }
    
    func revealController(_ revealController: PBRevealViewController, didHideLeft viewController: UIViewController)
    {
        print("didHideLeft:")
    }
    
    func revealController(_ revealController: PBRevealViewController, shouldShowRight viewController: UIViewController) -> Bool
    {
        print("shouldShowRight:")
        return true
    }
    
    func revealController(_ revealController: PBRevealViewController, willShowRight viewController: UIViewController)
    {
        print("willShowRight:")
        
        let nc = revealViewController()?.leftViewController as! UINavigationController
        let menuTableViewController = nc.topViewController as! MenuTableViewController
        
        if let nc = menuTableViewController.settingsNavigationController {
            let settingsViewController = nc.topViewController as! SettingsViewController
            mainViewController?.view.isUserInteractionEnabled = settingsViewController.isMainUserInteraction
            if settingsViewController.isMainUserInteraction == false {
                mainViewController?.view.alpha = 0.9
            }
        }
    }
    
    func revealController(_ revealController: PBRevealViewController, didShowRight viewController: UIViewController)
    {
        print("didShowRight:")
    }
    
    func revealController(_ revealController: PBRevealViewController, willHideRight viewController: UIViewController)
    {
        print("willHideRight:")
        
        mainViewController?.view.isUserInteractionEnabled = true
        mainViewController?.view.alpha = 1
    }
    
    func revealController(_ revealController: PBRevealViewController, didHideRight viewController: UIViewController)
    {
        print("didHideRight:")
    }
    

    func revealControllerPanGestureShouldBegin(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection) -> Bool
    {
        print("revealControllerPanGestureShouldBegin:direction:")
        mainViewController?.view.alpha = 1
        return true
    }
    
    func revealControllerTapGestureShouldBegin(_ revealController: PBRevealViewController) -> Bool
    {
        print("revealControllerTapGestureShouldBegin")
        return true
    }
    
    func revealController(_ revealController: PBRevealViewController, panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer, direction: PBRevealControllerPanDirection) -> Bool
    {
        print("panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:")
        return false
    }
    
    func revealController(_ revealController: PBRevealViewController, tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        print("tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:")
        return false
    }
    
    func revealControllerPanGestureBegan(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection)
    {
        print("revealControllerPanGestureBegan:direction:")
    }
    
    func revealControllerPanGestureMoved(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection)
    {
        print("revealControllerPanGestureMoved:direction:")
    }
    
    func revealControllerPanGestureEnded(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection)
    {
        print("revealControllerPanGestureEnded:direction:")
    }
    
    func revealController(_ revealController: PBRevealViewController, willAdd viewController: UIViewController, for operation: PBRevealControllerOperation, animated: Bool)
    {
        print("willAdd:for:")
    }
    
    func revealController(_ revealController: PBRevealViewController, didAdd viewController: UIViewController, for operation: PBRevealControllerOperation, animated: Bool)
    {
        print("didAdd:for:")
    }
    
    func revealController(_ revealController: PBRevealViewController, animationBlockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController, to toViewController: UIViewController) -> ((_: Void) -> Void)?
    {
        print("animationBlockFor:from:to:")
        return nil
    }
    
    func revealController(_ revealController: PBRevealViewController, completionBlockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController, to toViewController: UIViewController) -> ((_: Void) -> Void)?
    {
        print("completionBlockFor:from:to:")
        return nil
    }
    
    func revealController(_ revealController: PBRevealViewController, blockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController, to toViewController: UIViewController, finalBlock: @escaping (_: Void) -> Void) -> ((_: Void) -> Void)?
    {
        print("blockFor:from:to:")
        return nil
    }
    
    func revealController(_ revealController: PBRevealViewController, animationControllerForTransitionFrom fromViewController: UIViewController, to toViewController: UIViewController, for operation: PBRevealControllerOperation) -> UIViewControllerAnimatedTransitioning?
    {
        print("animationControllerForTransitionFrom:to:for:")
        if operation == .pushMainControllerFromLeft {
            return AnimationControllerForPush()
        }
        if operation == .pushMainControllerFromRight {
            return AnimationControllerForPush()
        }
        return nil
    }
}
