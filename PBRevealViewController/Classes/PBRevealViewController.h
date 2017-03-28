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

/**
 *  A category of UIViewController to let childViewControllers easily access their parent PBRevealViewController.
 */
@interface UIViewController(PBRevealViewController)

- (PBRevealViewController *)revealViewController;

@end

#pragma mark - StoryBoard support Classes

/**
 *  String identifiers to be applied to segues on a storyboard.
 */
extern NSString* const PBSegueLeftIdentifier;   // this is @"pb_left"
extern NSString* const PBSegueMainIdentifier;   // this is @"pb_main"
extern NSString* const PBSegueRightIdentifier;  // this is @"pb_right"

/**
 *  Use this to segue to the initial state. View controller segues are "pb_left", "pb_main" and "pb_right".
 */
@interface PBRevealViewControllerSegueSetController : UIStoryboardSegue

@end

/**
 *  Use this to push a view controller from a storyboard.
 */
@interface PBRevealViewControllerSeguePushController : UIStoryboardSegue

@end

/**
 *  Constants for animating when a main view is pushed
 */
typedef NS_ENUM(NSInteger, PBRevealToggleAnimationType) {
    /**
     *  No anmmation
     */
    PBRevealToggleAnimationTypeNone,
    /**
     *  A transition that dissolves from one view to the next.
     */
    PBRevealToggleAnimationTypeCrossDissolve,
    /**
     *  A transition that the main view push the left/right view until it is hidden.
     */
    PBRevealToggleAnimationTypePushSideView,
    /**
     *  A transition that the side view move a little to right or left by the value of leftRevealOverdraw or rightRevealOverdraw before the main view push the left/right view until it is hidden.
     */
    PBRevealToggleAnimationTypeSpring,
    /**
     *  A transition provided by the delegate methods.
     *
     *  @see    -revealController:willAddViewController:forOperation:animated:
     *  @see    -revealController:animationBlockForOperation:fromViewController:toViewController:
     *  @see    -revealController:completionBlockForOperation:fromViewController:toViewController:
     *  @see    -revealController:blockForOperation:fromViewController:toViewController:finalBlock:
     *
     *  @warning    If -revealController:blockForOperation:fromViewController:toViewController:finalBlock: is implemented, the others methods are ignored.
     */
    PBRevealToggleAnimationTypeCustom
};

/**
 *  Constants for blur effect style to apply to left/right views (since iOS 8).
 */
typedef NS_ENUM(NSInteger, PBRevealBlurEffectStyle) {
    /**
     *  None.
     */
    PBRevealBlurEffectStyleNone = -1,
    /**
     *  The area of the view is lighter in hue than the underlying view.
     */
    PBRevealBlurEffectStyleExtraLight = UIBlurEffectStyleExtraLight,
    /**
     *  The area of the view is the same approximate hue of the underlying view.
     */
    PBRevealBlurEffectStyleLight = UIBlurEffectStyleLight,
    /**
     *  The area of the view is darker in hue than the underlying view.
     */
    PBRevealBlurEffectStyleDark = UIBlurEffectStyleDark
};

#pragma mark - PBRevealViewController

@interface PBRevealViewController : UIViewController

/**
 *  Instantiate a PBRevealViewController class programmatically
 *
 *  @param leftViewController  A subclass of UIViewController (optional).
 *  @param mainViewController  A subclass of UIViewController (required).
 *  @param rightViewController A subclass of UIViewController (optional).
 *
 *  @return PBRevealViewController instance.
 */
- (id)initWithLeftViewController:(UIViewController *)leftViewController mainViewController:(UIViewController *)mainViewController rightViewController:(UIViewController *)rightViewController;

/**
 *  Defines the radius of the main view's shadow, default is 2.5f.
 */
@property (nonatomic) CGFloat           mainViewShadowRadius;

/**
 *  Defines the main view's shadow offset, default is {0.0f,2.5f}.
 */
@property (nonatomic) CGSize            mainViewShadowOffset;

/**
 *  Defines the main view's shadow opacity, default is 1.0f.
 */
@property (nonatomic) CGFloat           mainViewShadowOpacity;

/**
 *  Defines the main view's shadow color, default is blackColor
 */
@property (nonatomic) UIColor           *mainViewShadowColor;

/**
 *  If YES (default is NO) the left view controller will be ofsseted vertically by the height of a navigation bar plus the height of status bar.
 */
@property (nonatomic) BOOL              leftPresentViewHierarchically;

/**
 *  If NO (default is YES) the left view controller will be presented below the main view controller.
 */
@property (nonatomic) BOOL              leftPresentViewOnTop;

/**
 *  Defines how much displacement is applied to the left view when animating or dragging the main view, default is 40.0f.
 */
@property (nonatomic) CGFloat           leftViewRevealDisplacement;

/**
 *  Defines the width of the left view when it is shown, default is 260.0f.
 */
@property (nonatomic) CGFloat           leftViewRevealWidth;

/**
 *  Defines the width of the left view when it is shown.
 *
 *  @param leftViewRevealWidth The left view width.
 *  @param animated            Specify YES to animate the new width or NO if you do not want it to be animated.
 */
- (void)setLeftViewRevealWidth:(CGFloat)leftViewRevealWidth animated:(BOOL)animated;

/**
 *  Duration for the left reveal/push animation, default is 0.5f.
 *
 *  @see    -animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
 */
@property (nonatomic) NSTimeInterval    leftToggleAnimationDuration;

/**
 *  The damping ratio for the spring animation, default is 0.8f.
 *
 *  @see    -animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
 */
@property (nonatomic) CGFloat           leftToggleSpringDampingRatio;

/**
 *  The initial spring velocity, default is 0.5f.
 *
 *  @see    -animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
*/
@property (nonatomic) CGFloat           leftToggleSpringVelocity;

/**
 *  Defines the radius of the left view's shadow, default is 2.5f.
 */
@property (nonatomic) CGFloat           leftViewShadowRadius;

/**
 *  Defines the left view's shadow offset, default is {0.0f, 2.5f}.
 */
@property (nonatomic) CGSize            leftViewShadowOffset;

/**
 *  Defines the left view's shadow opacity, default is 1.0f.
 */
@property (nonatomic) CGFloat           leftViewShadowOpacity;

/**
 *  Defines the left view's shadow color, default is blackColor
 */
@property (nonatomic) UIColor           *leftViewShadowColor;

/**
 *  Defines the left view's blur effect style, default is PBRevealBlurEffectStyleNone.
 */

@property (nonatomic) PBRevealBlurEffectStyle leftViewBlurEffectStyle;

/**
 * If YES (default is NO) the left view controller will be ofsseted vertically by the height of a navigation bar plus the height of status bar.
 */
@property (nonatomic) BOOL              rightPresentViewHierarchically;

/**
 *  If NO (default is YES) the right view controller will be presented below the main view controller.
 */
@property (nonatomic) BOOL              rightPresentViewOnTop;

/**
 *  Defines how much displacement is applied to the right view when animating or dragging the main view, default is 40.0f.
 */
@property (nonatomic) CGFloat           rightViewRevealDisplacement;

/**
 *  Defines the width of the right view when it is shown, default is 160.0f.
 */
@property (nonatomic) CGFloat           rightViewRevealWidth;

/**
 *  Defines the width of the right view.
 *
 *  @param rightViewRevealWidth The right view width.
 *  @param animated             Specify YES to animate the new width or NO if you do not want it to be animated.
 */
- (void)setRightViewRevealWidth:(CGFloat)rightViewRevealWidth animated:(BOOL)animated;

/**
 *  Duration for the right reveal/push animation, default is 0.5f.
 *
 *  @see    -animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
 */
@property (nonatomic) NSTimeInterval    rightToggleAnimationDuration;

/**
 *  The damping ratio for the spring animation, default is 0.8f.
 *
 *  @see    -animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
 */
@property (nonatomic) CGFloat           rightToggleSpringDampingRatio;

/**
 *  The initial spring velocity, default is 0.5f.
 *
 *  @see    -animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:
 */
@property (nonatomic) CGFloat           rightToggleSpringVelocity;

/**
 *  Defines the radius of the lrighteft view's shadow, default is 2.5f.
 */
@property (nonatomic) CGFloat           rightViewShadowRadius;

/**
 *  Defines the right view's shadow offset, default is {0.0f, 2.5f}.
 */
@property (nonatomic) CGSize            rightViewShadowOffset;

/**
 *  Defines the right view's shadow opacity, default is 1.0f.
 */
@property (nonatomic) CGFloat           rightViewShadowOpacity;

/**
 *  Defines the right view's shadow color, default is blackColor
 */
@property (nonatomic) UIColor           *rightViewShadowColor;

/**
 *  Defines the right view's blur effect style, default is PBRevealBlurEffectStyleNone.
 */

@property (nonatomic) PBRevealBlurEffectStyle rightViewBlurEffectStyle;

/**
 *  Animation type, default is PBRevealToggleAnimationTypeNone.
 */
@property (nonatomic) PBRevealToggleAnimationType toggleAnimationType;

/**
 *  Defines how much of an overdraw can occur when pushing further than leftViewRevealWidth, default is 60.0f.
 */
@property (nonatomic) CGFloat           leftViewRevealOverdraw;

/**
 *  Defines how much of an overdraw can occur when pushing further than rightViewRevealWidth, default is 60.0f.
 */
@property (nonatomic) CGFloat           rightViewRevealOverdraw;

/**
 *  Duration for animated replacement of view controllers, default is 0.25f.
 */
@property (nonatomic) NSTimeInterval    replaceViewAnimationDuration;

/**
 *  Velocity required for the controller to toggle its state based on a swipe movement, default is 250.0f.
 */
@property (nonatomic) CGFloat           swipeVelocity;

/**
 *  YES if left view is completely open (read only).
 */
@property (nonatomic, readonly) BOOL    isLeftViewOpen;

/**
 *  YES if right view is completely open (read only).
 */
@property (nonatomic, readonly) BOOL    isRightViewOpen;

/**
 *  YES if left view is panning (read only).
 */
@property (nonatomic, readonly) BOOL    isLeftViewDragging;

/**
 *  YES if right view is panning (read only).
 */
@property (nonatomic, readonly) BOOL    isRightViewDragging;

/**
 *  The default tap gesture recognizer added to the main view. Default behavior will hide the left or right view.
 */
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

/**
 *  The default pan gesture recognizer added to the main view. Default behavior will drag the left or right view
 */
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

/**
 *  Optional left view controller, can be nil if not used.
 */
@property (nonatomic) UIViewController *leftViewController;

/**
 *  Replace the left view controller.
 *
 *  @param leftViewController A subclass of UIViewController.
 *  @param animated           Specify YES to animate the replacement or NO if you do not want the replacement to be animated.
 *
 *  @see    -setRightViewController:animated:
 */
- (void)setLeftViewController:(UIViewController *)leftViewController animated:(BOOL)animated;

/**
 *  Main view controller, cannot be nil.
 */
@property (nonatomic) UIViewController *mainViewController;

/**
 *  Replace the main view controller.
 *
 *  @param mainViewController A subclass of UIViewController.
 *  @param animated           Specify YES to animate the replacement or NO if you do not want the replacement to be animated.
 */
- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;

/**
 *  Optional right view controller, can be nil if not used.
 */
@property (nonatomic) UIViewController *rightViewController;

/**
 *  Replace the right view controller.
 *
 *  @param rightViewController A subclass of UIViewController.
 *  @param animated            Specify YES to animate the replacement or NO if you do not want the replacement to be animated.
 *
 *  @see    -setLeftViewController:animated:
 */
- (void)setRightViewController:(UIViewController *)rightViewController animated:(BOOL)animated;

/**
 *  Sets the mainViewController pushing it and hide left view controller.
 *
 *  @param mainViewController A subclass of UIViewController.
 *  @param animated           Specify YES to animate the replacement or NO if you do not want the replacement to be animated.
 *
 */
- (void)pushMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated;

/**
 *  Reveal left view or hide it if shown. Hide the right view if it is open and show the left view.
 */
- (IBAction)revealLeftView;

/**
 *  Reveal right view or hide it if shown.  Hide the left view if it is open and show the right view.
 */
- (IBAction)revealRightView;

/**
 *  Hide left view.
 *
 *  @param animated Specify YES to animate the replacement or NO if you do not want the replacement to be animated.
 */
- (void)hideLeftViewAnimated:(BOOL)animated;

/**
 *  Hide right view.
 *
 *  @param animated Specify YES to animate the replacement or NO if you do not want the replacement to be animated.
 */
- (void)hideRightViewAnimated:(BOOL)animated;

/**
 *  The delegate of the PBRevealViewController object.
 */
@property (nonatomic,weak) id <PBRevealViewControllerDelegate> delegate;

@end

#pragma mark - PBRevealViewControllerDelegate Protocol

/**
 *  Constants for current operation.
 */
typedef NS_ENUM(NSInteger, PBRevealControllerOperation) {
    /**
     *  None.
     */
    PBRevealControllerOperationNone,
    /**
     *  Replacement of left view controller.
     */
    PBRevealControllerOperationReplaceLeftController,
    /**
     *  Replacement of main view controller.
     */
    PBRevealControllerOperationReplaceMainController,
    /**
     *  Replacement of right view controller.
     */
    PBRevealControllerOperationReplaceRightController,
    /**
     *  Pushing the main view controller from left view controller.
     */
    PBRevealControllerOperationPushMainControllerFromLeft,
    /**
     *  Pushing the main view controller from right view controller.
     */
    PBRevealControllerOperationPushMainControllerFromRight
};

/**
 *  Direction constants when panning.
 */
typedef NS_ENUM(NSInteger, PBRevealControllerPanDirection) {
    /**
     *  Panning to left. Should open right view controller.
     */
    PBRevealControllerPanDirectionLeft,
    /**
     *  Panning to right. Should open left view controller.
     */
    PBRevealControllerPanDirectionRight
};

/**
 *  Use a reveal view controller delegate (a custom object that implements this protocol) to modify behavior when a view controller is pushed or replaced. All methods are optionals.
 */
@protocol PBRevealViewControllerDelegate<NSObject>

@optional

/**
 *  Ask the delegate if the left view should be shown. Not called while a pan gesture.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The left view controller object.
 *
 *  @return YES if the left view controller should be shown, NO otherwise.
 *
 *  @see    -revealControllerPanGestureShouldBegin:direction:
 */
- (BOOL)revealController:(PBRevealViewController *)revealController shouldShowLeftViewController:(UIViewController *)controller;

/**
 *  Called just before the left view controller is presented.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The left view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController willShowLeftViewController:(UIViewController *)controller;

/**
 *  Called just after the left view controller is presented.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The left view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController didShowLeftViewController:(UIViewController *)controller;

/**
 *  Called just before the left view controller is hidden.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The left view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController willHideLeftViewController:(UIViewController *)controller;

/**
 *  Called just after the left view controller is hidden.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The left view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController didHideLeftViewController:(UIViewController *)controller;

/**
 *  Ask the delegate if the right view should be shown. Not called while a pan gesture.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The right view controller object.
 *
 *  @return YES if the right view controller should be shown, NO otherwise.
 *
 *  @see    -revealControllerPanGestureShouldBegin:direction:
 */
- (BOOL)revealController:(PBRevealViewController *)revealController shouldShowRightViewController:(UIViewController *)controller;

/**
 *  Called just before the right view controller is presented.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The right view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController willShowRightViewController:(UIViewController *)controller;

/**
 *  Called just after the right view controller is presented.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The right view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController didShowRightViewController:(UIViewController *)controller;

/**
 *  Called just before the right view controller is hidden.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The right view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController willHideRightViewController:(UIViewController *)controller;

/**
 *  Called just after the right view controller is hidden.
 *
 *  @param revealController The reveal view controller object.
 *  @param controller       The right view controller object.
 */
- (void)revealController:(PBRevealViewController *)revealController didHideRightViewController:(UIViewController *)controller;

/**
 *  Implement this to return NO when you want the pan gesture recognizer to be ignored.
 *
 *  @param revealController The reveal view controller object.
 *  @param direction        The panning direction.
 *
 *  @return NO if you want the pan gesture recognizer to be ignored, YES otherwise.
 *
 *  @see    -panGestureRecognizer
 */
- (BOOL)revealControllerPanGestureShouldBegin:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;

/**
 *  Implement this to return NO when you want the tap gesture recognizer to be ignored.
 *
 *  @param revealController The reveal view controller object.
 *
 *  @return NO if you want the tap gesture recognizer to be ignored, YES otherwise.
 *
 *  @see    -tapGestureRecognizer
 */
- (BOOL)revealControllerTapGestureShouldBegin:(PBRevealViewController *)revealController;

/**
 *  Implement this to return YES if you want other gesture recognizer to share touch events with the pan gesture.
 *
 *  @param revealController       The reveal view controller object.
 *  @param otherGestureRecognizer The other gesture recognizer.
 *
 *  @return YES if you want other gesture recognizer to share touch events with the pan gesture.
 *
 *  @see    -panGestureRecognizer
 */
- (BOOL)revealController:(PBRevealViewController *)revealController
panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

/**
 *  Implement this to return YES if you want other gesture recognizer to share touch events with the tap gesture.
 *
 *  @param revealController       The reveal view controller object.
 *  @param otherGestureRecognizer The other gesture recognizer.
 *
 *  @return YES if you want other gesture recognizer to share touch events with the tap gesture.
 *
 *  @see    -tapGestureRecognizer
 */
- (BOOL)revealController:(PBRevealViewController *)revealController
tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

/**
 *  Called when the gestureRecognizer began.
 *
 *  @param revealController The reveal view controller object.
 *  @param direction        The panning direction.
 *
 *  @see    -panGestureRecognizer
 */
- (void)revealControllerPanGestureBegan:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;

/**
 *  Called when the gestureRecognizer moved.
 *
 *  @param revealController The reveal view controller object.
 *  @param direction        The panning direction.
 *
 *  @see    -panGestureRecognizer
 */
- (void)revealControllerPanGestureMoved:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;

/**
 *  Called when the gestureRecognizer ended.
 *
 *  @param revealController The reveal view controller object.
 *  @param direction        The panning direction.
 *
 *  @see    -panGestureRecognizer
 */
- (void)revealControllerPanGestureEnded:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction;

/**
 *  Called just before child controller replacement (left, main or right).
 *
 *  @param revealController The reveal view controller object.
 *  @param viewController   The child view controller.
 *  @param operation        The current operation.
 *  @param animated         YES if you want the replacement to be animated, NO otherwise.
 *
 *  @see    -revealController:didAddViewController:forOperation:animated:
 */
- (void)revealController:(PBRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(PBRevealControllerOperation)operation animated:(BOOL)animated;

/**
 *  Called just after child controller replacement (left, main or right).
 *
 *  @param revealController The reveal view controller object.
 *  @param viewController   The child view controller.
 *  @param operation        The current operation.
 *  @param animated         YES if you want the replacement to be animated, NO otherwise.
 *
 *  @see    -revealController:willAddViewController:forOperation:animated:
 */
- (void)revealController:(PBRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(PBRevealControllerOperation)operation animated:(BOOL)animated;

/**
 *  Ask for animation block while pushing main view controller.
 *
 *  @param revealController   The reveal view controller object.
 *  @param operation          The current operation (push from left or push from right).
 *  @param fromViewController The main view controller.
 *  @param toViewController   The new main view controller. When called the toViewController's view is behind the fromViewController's view.
 *
 *  @return A block to be inserted in the view animation.
 *
 *  @see    -revealController:blockForOperation:fromViewController:toViewController:finalBlock:
 */
- (void (^)(void))revealController:(PBRevealViewController *)revealController animationBlockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

/**
 *  Ask for completion block while pushing main view controller.
 *
 *  @param revealController   The reveal view controller object.
 *  @param operation          The current operation (push from left or push from right).
 *  @param fromViewController The main view controller.
 *  @param toViewController   The new main view controller. When called the toViewController's view is behind the fromViewController's view.
 *
 *  @return A block to be inserted in the view animation completion.
 *
 *  @see    -revealController:blockForOperation:fromViewController:toViewController:finalBlock:
 */
- (void (^)(void))revealController:(PBRevealViewController *)revealController completionBlockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

/**
 *  Ask for a block with animation and completion while replacing/pushing child view controllers, please add the final block to your completion.
 *
 *  @param revealController   The reveal view controller object.
 *  @param operation          The current operation (push from left or push from right).
 *  @param fromViewController The main view controller.
 *  @param toViewController   The new main view controller. When called the toViewController's view is behind the fromViewController's view.
 *  @param finalBlock         The final block provided by the reveal view controller object. This block must be inserted in your completion block.
 *
 *  @see    -revealController:animationBlockForOperation:fromViewController:toViewController:
 *  @see    -revealController:completionBlockForOperation:fromViewController:toViewController:
 *  @see    -revealController:animationControllerForTransitionFromViewController:toViewController:forOperation:

 */
- (void (^)(void))revealController:(PBRevealViewController *)revealController blockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController finalBlock:(void(^)(void))finalBlock;

/**
 *  Ask for custom transition animations controller while replacing/pushing child view controllers. If implemented, it will be fired in response to calls setXXXViewController or pushXXXViewController child view controller (since iOS 7).
 *
 *  @param revealController   The reveal view controller object.
 *  @param fromViewController The child view controller to replace.
 *  @param toViewController   The new child view controller.
 *  @param operation          The current operation (push from left, push from right, or replace).
 *
 *  @return The animator object adopting the UIViewControllerAnimatedTransitioning protocol.
 */
- (id <UIViewControllerAnimatedTransitioning>)revealController:(PBRevealViewController *)revealController animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController forOperation:(PBRevealControllerOperation)operation;

@end

