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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = "Controller \((indexPath as NSIndexPath).row)"

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var controller: UIViewController?
        
        switch (indexPath as NSIndexPath).row {
        case 0:
            controller = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            
        case 1:
            controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
            
        default:
            break
        }
        if (controller != nil) {
            let nc = UINavigationController(rootViewController: controller!)
            revealViewController().pushMainViewController(nc, animated:true)
        }
    }
}
