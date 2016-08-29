//
//  MainViewController.swift
//  Example3Swift
//
//  Created by Patrick BODET on 06/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        leftButton.target = self.revealViewController()
        leftButton.action = #selector(PBRevealViewController.revealLeftView)
        
        rightButton.target = self.revealViewController()
        rightButton.action = #selector(PBRevealViewController.revealRightView)

        if (image != nil) {
            imageView.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replaceLeftView(sender: UIBarButtonItem) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().leftViewController as! UINavigationController
        
        if nc.topViewController! is MenuTableViewController {
            controller = storyboard.instantiateViewControllerWithIdentifier("RightViewController")
            controller!.title = "Menu"
        }
        else {
            controller = storyboard.instantiateViewControllerWithIdentifier("MenuTableViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setLeftViewController(newNc, animated: true)
    }
    
    @IBAction func resizeLeftView(sender: UIBarButtonItem) {
        if revealViewController().leftViewRevealWidth < 200 {
            revealViewController().leftViewRevealWidth = 200
        }
        else {
            revealViewController().leftViewRevealWidth = 180
        }
    }
    
    @IBAction func replaceRightView(sender: UIBarButtonItem) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)        
        
        if revealViewController().rightViewController is RightViewController2 {
            controller = storyboard.instantiateViewControllerWithIdentifier("RightViewController")
            revealViewController().setRightViewController(controller, animated: true)
        }
        else {
            controller = storyboard.instantiateViewControllerWithIdentifier("RightViewController2")
            revealViewController().setRightViewController(controller, animated: true)
        }
    }
    
    @IBAction func resizeRightView(sender: UIBarButtonItem) {
        if revealViewController().rightViewRevealWidth < 180 {
            revealViewController().rightViewRevealWidth = 180
        }
        else {
            revealViewController().rightViewRevealWidth = 160
        }
    }
    
}
