//
//  MainViewController.swift
//  Example4Swift
//
//  Created by Patrick BODET on 09/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.target = self.revealViewController()
        menuButton.action = #selector(PBRevealViewController.revealLeftView)
        
        rightButton.target = self.revealViewController()
        rightButton.action = #selector(PBRevealViewController.revealRightView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resizeLeftView(sender: UIButton) {
        if revealViewController().leftViewRevealWidth < 260 {
            revealViewController().leftViewRevealWidth = 260
        }
        else {
            revealViewController().leftViewRevealWidth = 160
        }
    }
    
    @IBAction func replaceLeftView(sender: UIButton) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().leftViewController as! UINavigationController
        
        if nc.topViewController!.isKindOfClass(MenuTableViewController.classForCoder()) {
            controller = storyboard.instantiateViewControllerWithIdentifier("RightMenuTableViewController")
        }
        else {
            controller = storyboard.instantiateViewControllerWithIdentifier("MenuTableViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setLeftViewController(newNc, animated: true)
    }

    @IBAction func replaceMainView(sender: UIButton) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().mainViewController as! UINavigationController
        
        if nc.topViewController!.isKindOfClass(MainViewController.classForCoder()) {
            controller = storyboard.instantiateViewControllerWithIdentifier("SecondViewController")
        }
        else {
            controller = storyboard.instantiateViewControllerWithIdentifier("MainViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setMainViewController(newNc, animated: true)
    }
    
    @IBAction func replaceRightView(sender: UIButton) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().rightViewController as! UINavigationController
        
        if nc.topViewController!.isKindOfClass(RightMenuTableViewController.classForCoder()) {
            controller = storyboard.instantiateViewControllerWithIdentifier("MenuTableViewController")
        }
        else {
            controller = storyboard.instantiateViewControllerWithIdentifier("RightMenuTableViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setRightViewController(newNc, animated: true)
    }
    
    @IBAction func resizeRightView(sender: UIButton) {
        if revealViewController().rightViewRevealWidth < 260 {
            revealViewController().rightViewRevealWidth = 260
        }
        else {
            revealViewController().rightViewRevealWidth = 160
        }
    }
}
