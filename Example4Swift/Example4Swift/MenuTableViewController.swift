//
//  MenuTableViewController.swift
//  Example4Swift
//
//  Created by Patrick BODET on 09/08/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = "Controller \(indexPath.row)"

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var controller: UIViewController?
        
        switch indexPath.row {
        case 0:
            controller = storyboard.instantiateViewControllerWithIdentifier("MainViewController")
            
        case 1:
            controller = storyboard.instantiateViewControllerWithIdentifier("SecondViewController")
            
        default:
            break
        }
        if (controller != nil) {
            let nc = UINavigationController(rootViewController: controller!)
            revealViewController().pushMainViewController(nc, animated:true)
        }
    }
}
