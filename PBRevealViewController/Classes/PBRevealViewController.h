//
//  PBRevealViewController.h
//  PBRevealViewController
//
//  Created by Patrick BODET on 29/06/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBRevealViewController;
@protocol PBRevealViewControllerDelegate;

#pragma mark - UIViewController(PBRevealViewController) Category

// A category of UIViewController to let childViewControllers easily access their parent PBRevealViewController
@interface UIViewController(PBRevealViewController)

- (PBRevealViewController *)revealViewController;

@end

#pragma mark - StoryBoard support Classes

// String identifiers to be applied to segues on a storyboard
extern NSString* const PBSegueLeftIdentifier;   // this is @"pb_left"
extern NSString* const PBSegueMainIdentifier;   // this is @"pb_main"
extern NSString* const PBSegueRightIdentifier;  // this is @"pb_right"

/* This will allow the class to be defined on a storyboard */

// Use this along with one of the above segue identifiers to segue to the initial state
@interface PBRevealViewControllerSegueSetController : UIStoryboardSegue
@end

// Use this to push a view controller
@interface PBRevealViewControllerSeguePushController : UIStoryboardSegue

@end

// Enum values for toggleAnimationType
typedef enum
PBRevealToggleAnimationType
{
    PBRevealToggleAnimationTypeNone,
    PBRevealToggleAnimationTypeCrossDissolve,
    PBRevealToggleAnimationTypePushSideView,
    PBRevealToggleAnimationTypeCustom // See delegate methods
    
} PBRevealToggleAnimationType;

@interface PBRevealViewController : UIViewController

// If storyboard is not used
- (id)initWithLeftViewController:(UIViewController *)leftViewController mainViewController:(UIViewController *)mainViewController rightViewController:(UIViewController *)rightViewController;

// Properties

// Defines how much of the left view is shown, default is 260.0f
@property (nonatomic) CGFloat           leftViewRevealWidth;
// Defines how much of the right view is shown, default is 160.0f
@property (nonatomic) CGFloat           rightViewRevealWidth;

// Animation type, default is PBRevealToggleAnimationTypeNone
@property (nonatomic) PBRevealToggleAnimationType toggleAnimationType;

// Duration for the left reveal animation, default is 0.5f
// See animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
@property (nonatomic) NSTimeInterval    leftToggleAnimationDuration;
@property (nonatomic) CGFloat           leftToggleSpringDampingRatio;
@property (nonatomic) CGFloat           leftToggleSpringVelocity;

// Duration for the right reveal animation, default is 0.5f
// See animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
@property (nonatomic) NSTimeInterval    rightToggleAnimationDuration;
@property (nonatomic) CGFloat           rightToggleSpringDampingRatio;
@property (nonatomic) CGFloat           rightToggleSpringVelocity;

// Duration for animated replacement of view controllers, default is 0.25f
@property (nonatomic) NSTimeInterval    replaceViewAnimationDuration;

// Defines the radius of the left view's shadow, default is 5.0f
@property (nonatomic) CGFloat           leftViewShadowRadius;
// Defines the radius of the left view's shadow offset default is {0.0f,2.5f}
@property (nonatomic) CGSize            leftViewShadowOffset;
// Defines the left view's shadow opacity, default is 1.0f
@property (nonatomic) CGFloat           leftViewShadowOpacity;
// Defines the left view's shadow color, default is blackColor
@property (nonatomic) UIColor           *leftViewShadowColor;

// Defines the radius of the right view's shadow, default is 5.0f
@property (nonatomic) CGFloat           rightViewShadowRadius;
// Defines the radius of the right view's shadow offset default is {0.0f,2.5f}
@property (nonatomic) CGSize            rightViewShadowOffset;
// Defines the right view's shadow opacity, default is 1.0f
@property (nonatomic) CGFloat           rightViewShadowOpacity;
// Defines the right view's shadow color, default is blackColor
@property (nonatomic) UIColor           *rightViewShadowColor;

// Velocity required for the controller to toggle its state based on a swipe movement, default is 250.0f
@property (nonatomic) CGFloat           swipeVelocity;

// YES if left or right view is completlely open
@property (nonatomic) BOOL              isLeftViewOpen;
@property (nonatomic) BOOL              isRightViewOpen;

// YES if left or right view is panning
@property (nonatomic) BOOL              isLeftViewDragging;
@property (nonatomic) BOOL              isRightViewDragging;

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

// Optional left view controller, can be nil if not used
@property (nonatomic) UIViewController *leftViewController;
- (void)setLeftViewController:(UIViewController *)leftViewController animated:(BOOL)animated;

// Main view controller, cannot be nil
@property (nonatomic) UIViewController *mainViewController;
- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;

// Optional right view controller, can be nil if not used
@property (nonatomic) UIViewController *rightViewController;
- (void)setRightViewController:(UIViewController *)rightViewController animated:(BOOL)animated;

// Sets the mainViewController pushing it and hide left view controller
- (void)pushMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;

// Reveal left/right view
- (IBAction)revealLeftView;
- (IBAction)revealRightView;

// Hide left/right view
- (void)hideLeftViewAnimated:(BOOL)animated;
- (void)hideRightViewAnimated:(BOOL)animated;

// Delegate
@property (nonatomic,weak) id <PBRevealViewControllerDelegate> delegate;

@end

#pragma mark - PBRevealViewControllerDelegate Protocol

typedef enum
{
    PBRevealControllerOperationNone,
    PBRevealControllerOperationReplaceLeftController,
    PBRevealControllerOperationReplaceMainController,
    PBRevealControllerOperationReplaceRightController,
    PBRevealControllerOperationPushMainControllerFromLeft,
    PBRevealControllerOperationPushMainControllerFromRight
    
} PBRevealControllerOperation;

typedef enum
{
    PBRevealControllerPanDirectionLeft,
    PBRevealControllerPanDirectionRight,
    
} PBRevealControllerPanDirection;

@protocol PBRevealViewControllerDelegate<NSObject>

@optional

// The following delegate methods will be called before and after the left/right view will shon
- (BOOL)revealController:(PBRevealViewController *)revealController shouldShowLeftViewController:(UIViewController *)controller;
- (void)revealController:(PBRevealViewController *)revealController willShowLeftViewController:(UIViewController *)controller;
- (void)revealController:(PBRevealViewController *)revealController didShowLeftViewController:(UIViewController *)controller;
- (BOOL)revealController:(PBRevealViewController *)revealController shouldShowRightViewController:(UIViewController *)controller;
- (void)revealController:(PBRevealViewController *)revealController willShowRightViewController:(UIViewController *)controller;
- (void)revealController:(PBRevealViewController *)revealController didShowRightViewController:(UIViewController *)controller;

// Implement this to return NO when you want the pan gesture recognizer to be ignored
- (BOOL)revealControllerPanGestureShouldBegin:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;

// Implement this to return NO when you want the tap gesture recognizer to be ignored
- (BOOL)revealControllerTapGestureShouldBegin:(PBRevealViewController *)revealController;

// Implement this to return YES if you want other gesture recognizer to share touch events with the pan gesture
- (BOOL)revealController:(PBRevealViewController *)revealController
panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

// Implement this to return YES if you want other gesture recognizer to share touch events with the tap gesture
- (BOOL)revealController:(PBRevealViewController *)revealController
tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

// Called when the gestureRecognizer began, moved and ended
- (void)revealControllerPanGestureBegan:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;
- (void)revealControllerPanGestureMoved:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;
- (void)revealControllerPanGestureEnded:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;

// Notification of child controller replacement (left, main or right)
- (void)revealController:(PBRevealViewController *)revealController willAddViewController:(UIViewController *)viewController
            forOperation:(PBRevealControllerOperation)operation animated:(BOOL)animated;
- (void)revealController:(PBRevealViewController *)revealController didAddViewController:(UIViewController *)viewController
            forOperation:(PBRevealControllerOperation)operation animated:(BOOL)animated;

// Ask for animation block of child controller replacement when pushed
- (void (^)(void))revealController:(PBRevealViewController *)revealController animationBlockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

// Ask for completion block of child controller replacement when pushed
- (void (^)(void))revealController:(PBRevealViewController *)revealController completionBlockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

// Ask for a block with animation and completion of child controller replacement when pushed, please add the final block to your completion
 
// Example:
// See AppDelegate.m in example

- (void (^)(void))revealController:(PBRevealViewController *)revealController blockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController finalBlock:(void(^)(void))finalBlock;

@end

