//
//  MenuTableViewController.swift
//  ExampleWithSwiftLibrary
//
//  Created by Patrick BODET on 19/08/2017.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import UIKit
import PBRevealViewController

class MenuTableViewController: UITableViewController {
    
    var settingsNavigationController: UINavigationController?

    let items: [String] = ["None", "CrossDissolve", "PushSideView", "Spring", "Custom", "Replace Main", "Settings"]
    let animations:[PBRevealToggleAnimationType] = [.none, .crossDissolve, .pushSideView, .spring, .custom, .none, .none]
    let controllers: [String] = ["MainViewController", "SecondViewController", "ThirdViewController", "FourthViewController", "FifthViewController", "ReplaceMainViewController", "SettingsNavigationController"]

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
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row]
        
        cell.backgroundColor = UIColor.white
        if revealViewController()?.leftViewBlurEffectStyle != PBRevealBlurEffectStyle.none {
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controller: UIViewController?
        
        revealViewController()?.toggleAnimationType = animations[indexPath.row]
        
        if controllers[indexPath.row] == "SettingsNavigationController" {
            if settingsNavigationController == nil {
                settingsNavigationController = storyboard.instantiateViewController(withIdentifier: controllers[indexPath.row]) as? UINavigationController
            }
            revealViewController()?.pushMainViewController(settingsNavigationController!, animated:true)
        }
        else if controllers[indexPath.row] == "ReplaceMainViewController" {
            controller = storyboard.instantiateViewController(withIdentifier: controllers[indexPath.row])
            let nc = UINavigationController(rootViewController: controller!)
            revealViewController()?.setMainViewController(nc, animated:true)
        }
        else {
            controller = storyboard.instantiateViewController(withIdentifier: controllers[indexPath.row])
            let nc = UINavigationController(rootViewController: controller!)
            revealViewController()?.pushMainViewController(nc, animated:true)
        }
    }
}
