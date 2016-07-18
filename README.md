# PBRevealViewController

[![Version](https://img.shields.io/cocoapods/v/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)
[![License](https://img.shields.io/cocoapods/l/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)
[![Platform](https://img.shields.io/cocoapods/p/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)

A UIViewController subclass for revealing a left and/or right view controller above a main view controller.

## Example

![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Video.gif)

## Installation

• To run the example project, clone the repo, and run `pod install` in Terminal from the Example directory first.

• PBRevealViewController is also available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Cocoa.png)

## Features

• A Reveal view controller implemented using view controller containment.

• Support for any combination of left/right/main view controllers.

• Handling of rotations.

• Can be embedded as a child view controller of other controllers or deployed as the rootViewController.

• Plays nicely with any child view controllers or parent controllers.

• Can be deployed as a child of itself to create cascade-like, hierarchical interfaces.

• Seamless integration of pan gesture recognizer, behaving as smooth as silk.

• A category method on UIViewController, `revealViewController`, to get the parent `PBRevealViewController` of any child controller, similar to the UIViewController's property `navigationController`.

• Delegate methods for getting full state of the controller and implementing your own code hooks for customizing behavior.

• Delegate methods to ask animation/completion block for child controller replacement

## Requirements

• iOS 8.3 or later.

• ARC memory management.

## Usage

The easiest way to install it is by copying the following to your project:

• PBRevealViewController.h

• PBRevealViewController.m

On your project:

• Initialize an instance of a PBRevealViewController passing in a "left" (optinal), "main" (required) and "right" (optional) view controllers.

• Use the PBRevealViewController instance in your code as you would use any view controller.

• Deploy as the application window rootViewController, or as a child of other containment controllers.

• Add the panGestureRecognized and tapGestureRecognizer provided by the PBRevealViewController. You can leave them as they are for the default behavior or you can add them to a suitable view on your "main" view controller. For example add the panGestureRecognizer to a navigationBar on the viewDidLoad method of your front controller.

• Cancel the gestureRecoGnized provided by the PBRevealViewController:
    - (BOOL)revealControllerTapGestureShouldBegin:
    - (BOOL)revealControllerPanGestureShouldBegin:direction:

• At any time, you can reveal, conceal the "left" or "right" views or replace any of the view controllers, programmatically or based on user actions, with or without animations enabled

## Basic API Description

Initializing a PBRevealViewController programmatically:

- (id)initWithLeftViewController:(UIViewController *)leftViewController mainViewController:(UIViewController *)mainViewController rightViewController:(UIViewController *)rightViewController ;

• Animated pushing a main view controller:

- (void)pushMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;

• Other methods are documented in the PBRevealViewController.h header file. 

• Initializing a PBRevealViewController with Storyboard:

![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Story.png)


```ruby
pod "PBRevealViewController"
```

## Author

iDevelopper, patrick.bodet4@wanadoo.fr

## License

PBRevealViewController is available under the MIT license. See the LICENSE file for more info.
