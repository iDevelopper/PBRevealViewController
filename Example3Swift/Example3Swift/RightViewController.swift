//
//  RightViewController.swift
//  Example3Swift
//
//  Created by Patrick BODET on 07/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class RightViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //edgesForExtendedLayout = .Top

        //let backgroundImage = UIImage(named: "Sunset3")
        //let imageView = UIImageView(image: backgroundImage)
        //tableView.backgroundView = imageView

        tableView.backgroundColor = .clearColor()
        //tableView.backgroundColor = .lightGrayColor()

        tableView.tableFooterView = UIView(frame: CGRectZero)
}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //let backgroundView = UIView(frame: tableView.frame)
        //backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        //backgroundView.backgroundColor = UIColor.clearColor()
        //self.tableView.backgroundView = backgroundView
        //self.tableView.backgroundColor = UIColor.clearColor()
        
        // no lines where there aren't cells
        
        // center and scale background image
        //imageView.contentMode = .ScaleAspectFit
        
        // Set the background color to match better
        //tableView.backgroundColor = .whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.backgroundColor = .clearColor()
        cell.textLabel!.text = "Item \(indexPath.row)"
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        
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
        
        //tableView.backgroundColor = .darkGrayColor()
        //revealViewController().leftViewBlurEffectStyle = .None
        
        //addBlurToTableView(mainViewController.image)
    }
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
