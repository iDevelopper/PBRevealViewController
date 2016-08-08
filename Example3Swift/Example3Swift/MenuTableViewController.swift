//
//  MenuTableViewController.swift
//  Example3Swift
//
//  Created by Patrick BODET on 06/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addBlurToTableView(UIImage(named: "Sunset1"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = "None"
            
        case 1:
            cell.textLabel!.text = "CrossDissolve"
            
        case 2:
            cell.textLabel!.text = "PushSideView"
            
        case 3:
            cell.textLabel!.text = "Spring"
            
        case 4:
            cell.textLabel!.text = "Custom"
            
        default:
            break
        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("Main") as! MainViewController
        
        switch indexPath.row {
        case 0:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.None
            mainViewController.image = UIImage(named: "Sunset1")
            
        case 1:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.CrossDissolve
            mainViewController.image = UIImage(named: "Sunset2")
            
        case 2:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.PushSideView
            mainViewController.image = UIImage(named: "Sunset3")
            
        case 3:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.Spring
            mainViewController.image = UIImage(named: "Sunset4")
            
        case 4:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.Custom
            mainViewController.image = UIImage(named: "Sunset5")
            
        default: break
        }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        mainViewController.title = cell?.textLabel?.text
        let nc = UINavigationController(rootViewController: mainViewController)
        revealViewController().pushMainViewController(nc, animated:true)

        addBlurToTableView(mainViewController.image)
    }
    
    func addBlurToTableView(image: UIImage!) {
        let effect = UIBlurEffect(style: .Light)
        let resizingMask: UIViewAutoresizing = [.FlexibleWidth, .FlexibleHeight]
        
        let backgroundView = UIView(frame: view.frame)
        backgroundView.autoresizingMask = resizingMask

        let imageView = UIImageView(image: image)
        imageView.frame = view.frame
        imageView.autoresizingMask = resizingMask
        backgroundView.addSubview(imageView)
        
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = view.frame
        blurView.autoresizingMask = resizingMask
        backgroundView.addSubview(blurView)
        
        tableView.backgroundView = backgroundView
        tableView.separatorEffect = UIVibrancyEffect(forBlurEffect: effect)
    }
}
