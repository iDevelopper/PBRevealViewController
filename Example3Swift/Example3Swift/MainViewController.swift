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
        
        if (image == nil) {
            self.revealViewController()?.delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self.revealViewController()?.leftViewRevealWidth = 200
            
            self.revealViewController()?.rightPresentViewHierarchically = true
        }
        else {
            imageView.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
