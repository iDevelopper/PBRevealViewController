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
    
    @IBAction func resizeLeftView(_ sender: UIButton) {
        if revealViewController().leftViewRevealWidth < 260 {
            revealViewController().leftViewRevealWidth = 260
        }
        else {
            revealViewController().leftViewRevealWidth = 160
        }
    }
    
    @IBAction func replaceLeftView(_ sender: UIButton) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().leftViewController as! UINavigationController
        
        if nc.topViewController! is MenuTableViewController {
            controller = storyboard.instantiateViewController(withIdentifier: "RightMenuTableViewController")
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setLeft(newNc, animated: true)
    }

    @IBAction func replaceMainView(_ sender: UIButton) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().mainViewController as! UINavigationController
        
        if nc.topViewController! is MainViewController {
            controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setMain(newNc, animated: true)
    }
    
    @IBAction func replaceRightView(_ sender: UIButton) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().rightViewController as! UINavigationController
        
        if nc.topViewController! is RightMenuTableViewController {
            controller = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController")
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "RightMenuTableViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setRight(newNc, animated: true)
    }
    
    @IBAction func resizeRightView(_ sender: UIButton) {
        if revealViewController().rightViewRevealWidth < 260 {
            revealViewController().rightViewRevealWidth = 260
        }
        else {
            revealViewController().rightViewRevealWidth = 160
        }
    }
}
