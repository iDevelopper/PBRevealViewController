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
    
    @IBAction func replaceLeftView(_ sender: UIBarButtonItem) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = revealViewController().leftViewController as! UINavigationController
        
        if nc.topViewController! is MenuTableViewController {
            self.revealViewController().leftViewBlurEffectStyle = .none
            controller = storyboard.instantiateViewController(withIdentifier: "RightViewController")
            controller!.title = "Menu"
        }
        else {
            self.revealViewController().leftViewBlurEffectStyle = .light
            controller = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController")
        }
        
        let newNc = UINavigationController(rootViewController: controller!)
        revealViewController().setLeft(newNc, animated: true)
    }
    
    @IBAction func resizeLeftView(_ sender: UIBarButtonItem) {
        if revealViewController().leftViewRevealWidth < 200 {
            revealViewController().setLeftViewRevealWidth(200, animated: true)
        }
        else {
            revealViewController().setLeftViewRevealWidth(180, animated: true)
        }
    }
    
    @IBAction func replaceRightView(_ sender: UIBarButtonItem) {
        var controller: UIViewController?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)        
        
        if revealViewController().rightViewController is RightViewController2 {
            controller = storyboard.instantiateViewController(withIdentifier: "RightViewController")
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: "RightViewController2")
        }
        revealViewController().setRight(controller, animated: true)
    }
    
    @IBAction func resizeRightView(_ sender: UIBarButtonItem) {
        if revealViewController().rightViewRevealWidth < 180 {
            revealViewController().rightViewRevealWidth = 180
        }
        else {
            revealViewController().rightViewRevealWidth = 160
        }
    }
    
}
