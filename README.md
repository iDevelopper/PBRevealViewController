# PBRevealViewController

[![Version](https://img.shields.io/cocoapods/v/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)
[![License](https://img.shields.io/cocoapods/l/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)
[![Platform](https://img.shields.io/cocoapods/p/PBRevealViewController.svg?style=flat)](http://cocoapods.org/pods/PBRevealViewController)

A slide UIViewController subclass for revealing a side (left and/or right) view controller above or below a main view controller for iOS and tvOS, inspired on SWRevealViewController subclass.

PBRevealViewController is compatible with both iOS and tvOS, and currently works with Swift 5.0, Swift 4.2 (swift-4.2 branch) and Objective-C!

## Examples

![Image](https://raw.githubusercontent.com/iDevelopper/PBRevealViewController/master/Sources/Assets/PBRevealViewController_Video.gif)
![Image](https://raw.githubusercontent.com/iDevelopper/PBRevealViewController/master/Sources/Assets/PBRevealViewController_Video2.gif)
![Image](https://raw.githubusercontent.com/iDevelopper/PBRevealViewController/master/Sources/Assets/PBRevealViewController_Video3.gif)
![Image](https://raw.githubusercontent.com/iDevelopper/PBRevealViewController/master/Sources/Assets/PBRevealViewController_Video4.gif)

## Installation

To run the example projects, clone the repo, and run `pod install` in your Terminal from the Example directory first.

You can also run `pod try PBRevealViewController` in your Terminal from anywhere.

## In your project

The easiest way to install it is by copying the following to your project:
* PBRevealViewController.h
* PBRevealViewController.m

Or
* PBRevealViewController.swift

PBRevealViewController is also available through [CocoaPods](http://cocoapods.org).

To install the library to your project:

PBRevealViewController has [subspecs](https://guides.cocoapods.org/syntax/podspec.html#subspec) for both Objective-C and Swift! Currently, Objective-C is the default subspec.

That means to use PBRevealViewController in an Objective-C project, add the following to your project's Podfile:
```ruby
pod 'PBRevealViewController'
```
But if you're using Swift, add the following instead to specify the Swift subspec:
```ruby
pod 'PBRevealViewController/Swift'
```

## Features

* A Reveal view controller implemented using view controller containment.
* A category method on UIViewController, `revealViewController`, to get the parent `PBRevealViewController` of any child controller, similar to the UIViewController's property `navigationController`.
* Support for any combination of left/right/main view controllers.
* Handling of rotations.
* Can be embedded as a child view controller of other controllers or deployed as the rootViewController.
* Plays nicely with any child view controllers or parent controllers.
* Can be deployed as a child of itself to create cascade-like, hierarchical interfaces.
* Seamless integration of tap and pan gesture recognizers.
* If needed, provide a blur effect to left/right views.
* Delegate methods for getting full state of the controller and implementing your own code hooks for customizing behavior.
* Delegate methods for asking animation/completion block for main view controller when pushing.
* Delegate method for asking block for child controller when pushing.
* Delegate method for asking an animator controller adopting the UIViewControllerAnimatedTransitioning protocol for custom animatiion transitions (push or set).

## Requirements

* iOS 6.0 or later.
* tvOS 9.0 or later.
* ARC memory management.

## Usage

* Initialize an instance of a PBRevealViewController passing in a "left" (optinal), "main" (required) and "right" (optional) view controllers.
* Use the PBRevealViewController instance in your code as you would use any view controller.
* Deploy as the application window rootViewController, or as a child of other containment controllers.
* You can leave panGestureRecognized and tapGestureRecognizer provided by the PBRevealViewController as they are for the default behavior or you can add them to a suitable view on your "main" view controller. For example add the panGestureRecognizer to a navigationBar on the viewDidLoad method of your main view controller.
* Cancel the gestures recognizer behavior provided by the PBRevealViewController:
```objective-c
- (BOOL)revealControllerTapGestureShouldBegin:
- (BOOL)revealControllerPanGestureShouldBegin:direction:
```
Example: Allow opening left/right view only if the user starts swiping on the edge of the screen.

New: See panFromLeftBorderWidth and panFromRightBorderWidth properties!

Objective-C:
```objective-c
- (BOOL)revealControllerPanGestureShouldBegin:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction
{
	CGPoint point = [revealController.panGestureRecognizer locationInView:self.view];
	if (!revealController.isLeftViewOpen && direction == PBRevealControllerPanDirectionRight && point.x < 50.0) {
		return YES;
	}
	if (!revealController.isRightViewOpen && direction == PBRevealControllerPanDirectionLeft && point.x > (self.view.bounds.size.width - 50)) {
		return YES;
	}
	if (revealController.isLeftViewOpen || revealController.isRightViewOpen) {
		return YES;
	}
	return NO;
}
```
Swift 3:
```Swift
    func revealControllerPanGestureShouldBegin(_ revealController: PBRevealViewController!, direction: PBRevealControllerPanDirection) -> Bool {
        let point = revealController.panGestureRecognizer.location(in: view)
        if !revealController.isLeftViewOpen && direction == .right && point.x < 50.0 {
            return true
        }
        if !revealController.isRightViewOpen && direction == .left && point.x > (view.bounds.size.width - 50) {
            return true
        }
        if revealController.isLeftViewOpen || revealController.isRightViewOpen {
            return true
        }
        return false
    }
```

* At any time, you can reveal, hide the "left" or "right" views or replace any of the view controllers, programmatically or based on user actions, with or without animations enabled

## Basic API Description

* Initializing a PBRevealViewController programmatically:
```objective-c
- (id)initWithLeftViewController:(UIViewController *)leftViewController mainViewController:(UIViewController *)mainViewController rightViewController:(UIViewController *)rightViewController;
```
* Initializing a PBRevealViewController with Storyboard:

![Image](https://raw.githubusercontent.com/iDevelopper/PBRevealViewController/master/PBRevealViewController/Assets/PBRevealViewController_Story.png)

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

* Other methods are documented in the PBRevealViewController.h header file and at [CocoaPods](http://cocoapods.org). 

## Special Mention

A Special Thank to [Joan Lluch](https://github.com/John-Lluch).

This code was inspired on her excellent and similar class [SWRevealViewController](https://github.com/John-Lluch/SWRevealViewController).

## Author

iDevelopper, patrick.bodet4@wanadoo.fr

## License

PBRevealViewController is available under the MIT license. See the LICENSE file for more info.

Please tell me when you use this controller in your project!

Regards,

Patrick Bodet aka iDevelopper


