//
//  FifthViewController.swift
//  ExampleWithSwiftLibrary
//
//  Created by Patrick BODET on 19/08/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

import UIKit
import PBRevealViewController

class FifthViewController: UIViewController {

    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        leftButton.target = self.revealViewController()
        leftButton.action = #selector(PBRevealViewController.revealLeftView)

        rightButton.target = self.revealViewController()
        rightButton.action = #selector(PBRevealViewController.revealRightView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
