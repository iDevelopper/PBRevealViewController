# PBRevealViewController

[![Version](https://img.shields.io/cocoapods/v/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)
[![License](https://img.shields.io/cocoapods/l/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)
[![Platform](https://img.shields.io/cocoapods/p/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)

A UIViewController subclass for revealing a left and/or right view controller above or below a main view controller.

## Examples

![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Video.gif) ![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Video2.gif)
![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Video3.gif) ![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Video4.gif)

## Installation

To run the example projects, clone the repo, and run `pod install` in your Terminal from the Example directory first.

You can also run `pod try PBRevealViewController` in your Terminal from anywhere.

The easiest way to install it is by copying the following to your project:
* PBRevealViewController.h
* PBRevealViewController.m

PBRevealViewController is also available through [CocoaPods](http://cocoapods.org). To install the library to your project, simply copy to clipbooard the pod command as shown below and paste it in your Podfile:

![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Cocoa.png)

## Features

* A Reveal view controller implemented using view controller containment.
* A category method on UIViewController, `revealViewController`, to get the parent `PBRevealViewController` of any child controller, similar to the UIViewController's property `navigationController`.
* Support for any combination of left/right/main view controllers.
* Handling of rotations.
* Can be embedded as a child view controller of other controllers or deployed as the rootViewController.
* Plays nicely with any child view controllers or parent controllers.
* Can be deployed as a child of itself to create cascade-like, hierarchical interfaces.
* Seamless integration of tap and pan gesture recognizers.
* Delegate methods for getting full state of the controller and implementing your own code hooks for customizing behavior.
* Delegate methods to ask animation/completion block for main view controller when pushing.
* Delegate methods to ask block for child controller when pushing.

## Requirements

* iOS 8.3 or later.
* ARC memory management.

## Usage

On your project:
* Initialize an instance of a PBRevealViewController passing in a "left" (optinal), "main" (required) and "right" (optional) view controllers.
* Use the PBRevealViewController instance in your code as you would use any view controller.
* Deploy as the application window rootViewController, or as a child of other containment controllers.
* You can leave panGestureRecognized and tapGestureRecognizer provided by the PBRevealViewController as they are for the default behavior or you can add them to a suitable view on your "main" view controller. For example add the panGestureRecognizer to a navigationBar on the viewDidLoad method of your main view controller.
* Cancel the gestureRecoGnized provided by the PBRevealViewController:
```objective-c
- (BOOL)revealControllerTapGestureShouldBegin:
- (BOOL)revealControllerPanGestureShouldBegin:direction:
```
* At any time, you can reveal, hide the "left" or "right" views or replace any of the view controllers, programmatically or based on user actions, with or without animations enabled

## Basic API Description

* Initializing a PBRevealViewController programmatically:
```objective-c
- (id)initWithLeftViewController:(UIViewController *)leftViewController mainViewController:(UIViewController *)mainViewController rightViewController:(UIViewController *)rightViewController;
```
* Initializing a PBRevealViewController with Storyboard:

![Image](https://github.com/iDevelopper/PBRevealViewController/blob/master/PBRevealViewController_Story.png)

* Pushing a main view controller:
```objective-c
- (void)pushMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;
```
* replace a view controller:
```objective-c
- (void)setLeftViewController:(UIViewController *)leftViewController animated:(BOOL)animated;
- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;
- (void)setRightViewController:(UIViewController *)rightViewController animated:(BOOL)animated;
```

* Other methods are documented in the PBRevealViewController.h header file. 

## Author

iDevelopper, patrick.bodet4@wanadoo.fr

## License

PBRevealViewController is available under the MIT license. See the LICENSE file for more info.
