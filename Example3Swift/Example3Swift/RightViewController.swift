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

        //tableView.backgroundColor = UIColor.clear

        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        cell.backgroundColor = UIColor.clear
        cell.textLabel!.text = "Item \((indexPath as NSIndexPath).row)"
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        switch (indexPath as NSIndexPath).row {
        case 0:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.none
            mainViewController.image = UIImage(named: "Sunset1")
            
        case 1:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.crossDissolve
            mainViewController.image = UIImage(named: "Sunset2")
            
        case 2:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.pushSideView
            mainViewController.image = UIImage(named: "Sunset3")
            
        case 3:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.spring
            mainViewController.image = UIImage(named: "Sunset4")
            
        case 4:
            self.revealViewController().toggleAnimationType = PBRevealToggleAnimationType.custom
            mainViewController.image = UIImage(named: "Sunset5")
            
        default: break
        }
        
        let nc = UINavigationController(rootViewController: mainViewController)
        revealViewController().pushMainViewController(nc, animated:true)
    }
}
