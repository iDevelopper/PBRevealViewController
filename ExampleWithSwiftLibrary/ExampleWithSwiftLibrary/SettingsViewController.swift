//
//  SettingsViewController.swift
//  ExampleWithSwiftLibrary
//
//  Created by Patrick BODET on 19/08/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

import UIKit
import PBRevealViewController

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    @IBOutlet weak var leftBlurSegmentedControl: UISegmentedControl!
    @IBOutlet weak var rightBlurSegmentedControl: UISegmentedControl!
    @IBOutlet weak var leftPresentOnTopSwitch: UISwitch!
    @IBOutlet weak var rightPresentOnTopSwitch: UISwitch!
    @IBOutlet weak var leftHierarchicallySwitch: UISwitch!
    @IBOutlet weak var rightHierarchicallySwitch: UISwitch!
    @IBOutlet weak var leftRevealWidthField: UITextField!
    @IBOutlet weak var rightRevealWidthField: UITextField!
    @IBOutlet weak var leftOverdrawField: UITextField!
    @IBOutlet weak var rightOverdrawField: UITextField!
    @IBOutlet weak var leftDisplacementField: UITextField!
    @IBOutlet weak var rightDisplacementField: UITextField!
    @IBOutlet weak var leftPanBoderWidthField: UITextField!
    @IBOutlet weak var rightPanBoderWidthField: UITextField!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    var currentTextField: UITextField?

    var isMainUserInteraction: Bool = true

    let styles:[PBRevealBlurEffectStyle] = [.none, .extraLight, .light, .dark]

    override func viewDidLoad() {
        super.viewDidLoad()

        leftButton.target = self.revealViewController()
        leftButton.action = #selector(PBRevealViewController.revealLeftView)
        
        rightButton.target = self.revealViewController()
        rightButton.action = #selector(PBRevealViewController.revealRightView)
        
        leftBlurSegmentedControl.selectedSegmentIndex = (revealViewController()?.leftViewBlurEffectStyle.rawValue)! + 1
        rightBlurSegmentedControl.selectedSegmentIndex = (revealViewController()?.rightViewBlurEffectStyle.rawValue)! + 1
        
        leftPresentOnTopSwitch.isOn = (revealViewController()?.isLeftPresentViewOnTop)!
        rightPresentOnTopSwitch.isOn = (revealViewController()?.isRightPresentViewOnTop)!
        
        leftHierarchicallySwitch.isOn = (revealViewController()?.isLeftPresentViewHierarchically)!
        rightHierarchicallySwitch.isOn = (revealViewController()?.isRightPresentViewHierarchically)!
        
        Bundle.main.loadNibNamed("KeyboardTool", owner: self, options: nil)
        
        leftRevealWidthField.inputAccessoryView = toolBar
        leftRevealWidthField.text = "\(Int((revealViewController()?.leftViewRevealWidth)!))"
        
        rightRevealWidthField.inputAccessoryView = toolBar
        rightRevealWidthField.text = "\(Int((revealViewController()?.rightViewRevealWidth)!))"
        
        leftOverdrawField.inputAccessoryView = toolBar
        leftOverdrawField.text = "\(Int((revealViewController()?.leftViewRevealOverdraw)!))"

        rightOverdrawField.inputAccessoryView = toolBar
        rightOverdrawField.text = "\(Int((revealViewController()?.rightViewRevealOverdraw)!))"

        leftDisplacementField.inputAccessoryView = toolBar
        leftDisplacementField.text = "\(Int((revealViewController()?.leftViewRevealDisplacement)!))"
        
        rightDisplacementField.inputAccessoryView = toolBar
        rightDisplacementField.text = "\(Int((revealViewController()?.rightViewRevealDisplacement)!))"
        
        leftPanBoderWidthField.inputAccessoryView = toolBar
        leftPanBoderWidthField.text = "\(Int((revealViewController()?.panFromLeftBorderWidth)!))"

        rightPanBoderWidthField.inputAccessoryView = toolBar
        rightPanBoderWidthField.text = "\(Int((revealViewController()?.panFromRightBorderWidth)!))"
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func blurValueChanged(_ sender: UISegmentedControl) {
        switch sender.tag {
        case 100: // Left
            revealViewController()?.leftViewBlurEffectStyle = styles[sender.selectedSegmentIndex]
            let nc = revealViewController()?.leftViewController as! UINavigationController
            let controller = nc.topViewController as! MenuTableViewController
            if sender.selectedSegmentIndex == 0 {
                controller.tableView.backgroundColor = UIColor.white
            }
            controller.tableView.reloadData()
        case 200: // Right
            revealViewController()?.rightViewBlurEffectStyle = styles[sender.selectedSegmentIndex]
            let nc = revealViewController()?.rightViewController as! UINavigationController
            let controller = nc.topViewController as! MenuTableViewController
            if sender.selectedSegmentIndex == 0 {
                controller.tableView.backgroundColor = UIColor.white
            }
            controller.tableView.reloadData()
        default:
            break
        }
    }

    @IBAction func onTopValueChanged(_ sender: UISwitch) {
        switch sender.tag {
        case 100: // Left
            revealViewController()?.isLeftPresentViewOnTop = sender.isOn
            if !sender.isOn {
                revealViewController()?.isLeftPresentViewHierarchically = false
                leftHierarchicallySwitch.isOn = false
            }
        case 200: // Right
            revealViewController()?.isRightPresentViewOnTop = sender.isOn
            if !sender.isOn {
                revealViewController()?.isRightPresentViewHierarchically = false
                rightHierarchicallySwitch.isOn = false
            }
        default:
            break
        }
    }
    
    @IBAction func hierarchicallyValueChanged(_ sender: UISwitch) {
        switch sender.tag {
        case 100: // Left
            revealViewController()?.isLeftPresentViewHierarchically = sender.isOn
            if sender.isOn {
                revealViewController()?.isLeftPresentViewOnTop = true
                leftPresentOnTopSwitch.isOn = true
            }
        case 200: // Right
            revealViewController()?.isRightPresentViewHierarchically = sender.isOn
            if sender.isOn {
                revealViewController()?.isRightPresentViewOnTop = true
                rightPresentOnTopSwitch.isOn = true
            }
        default:
            break
        }
    }
    
    @IBAction func mainUserInteractionValueChanged(_ sender: UISwitch) {
        isMainUserInteraction = sender.isOn
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        let contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        currentTextField?.text = nil
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if currentTextField == leftRevealWidthField {
            revealViewController()?.leftViewRevealWidth = CGFloat(Float(currentTextField!.text!)!)
        }
        if currentTextField == rightRevealWidthField {
            revealViewController()?.rightViewRevealWidth = CGFloat(Float(currentTextField!.text!)!)
        }
        if currentTextField == leftOverdrawField {
            revealViewController()?.leftViewRevealOverdraw = CGFloat(Float(currentTextField!.text!)!)
        }
        if currentTextField == rightOverdrawField {
            revealViewController()?.rightViewRevealOverdraw = CGFloat(Float(currentTextField!.text!)!)
        }
        if currentTextField == leftDisplacementField {
            revealViewController()?.leftViewRevealDisplacement = CGFloat(Float(currentTextField!.text!)!)
        }
        if currentTextField == rightDisplacementField {
            revealViewController()?.rightViewRevealDisplacement = CGFloat(Float(currentTextField!.text!)!)
        }
        if currentTextField == leftPanBoderWidthField {
            revealViewController()?.panFromLeftBorderWidth = CGFloat(Float(currentTextField!.text!)!)
        }
        if currentTextField == rightPanBoderWidthField {
            revealViewController()?.panFromRightBorderWidth = CGFloat(Float(currentTextField!.text!)!)
        }
        currentTextField?.resignFirstResponder()
        
        let contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
}
