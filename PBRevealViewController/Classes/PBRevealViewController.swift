//  PBRevealViewController.swift
//  PBRevealViewController
//
//  Created by Patrick BODET on 29/06/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

import QuartzCore
import UIKit
import UIKit.UIGestureRecognizerSubclass

// MARK: - Enum types

/**
 Constants for animating when a main view is pushed
 */
@objc public enum PBRevealToggleAnimationType : Int {
    /**
     No anmmation
     */
    case none
    /**
     A transition that dissolves from one view to the next.
     */
    case crossDissolve
    /**
     A transition that the main view push the left/right view until it is hidden.
     */
    case pushSideView
    /**
     A transition that the side view move a little to right or left by the value of leftRevealOverdraw or rightRevealOverdraw before the main view push the left/right view until it is hidden.
     */
    case spring
    /**
     A transition provided by the delegate methods.
     
     See also:
     
        revealController(_ :willAdd:for:animated:)
     
        revealController(_ :animationBlockFor:from:to:)
     
        revealController(_ :completionBlockFor:from:to:)
     
        revealController(_ :blockFor:from:to:finalBlock:)
     
     - Important:
        If revealController(_ :blockFor:from:to:finalBlock:) is implemented, the others methods are ignored.
     */
    case custom
}

/**
 Constants for blur effect style to apply to left/right views (since iOS 8).
 */

@objc public enum PBRevealBlurEffectStyle : Int {
    /**
     None.
     */
    case none = -1
    /**
     The area of the view is lighter in hue than the underlying view.
     */
    case extraLight
    /**
     The area of the view is the same approximate hue of the underlying view.
     */
    case light
    /**
     The area of the view is darker in hue than the underlying view.
     */
    case dark
}

// MARK: - PBRevealViewControllerDelegate Protocol
/**
 Constants for current operation.
 */
@objc public enum PBRevealControllerOperation : Int {
    /**
     None.
     */
    case none
    /**
     Replacement of left view controller.
     */
    case replaceLeftController
    /**
     Replacement of main view controller.
     */
    case replaceMainController
    /**
     Replacement of right view controller.
     */
    case replaceRightController
    /**
     Pushing the main view controller from left view controller.
     */
    case pushMainControllerFromLeft
    /**
     Pushing the main view controller from right view controller.
     */
    case pushMainControllerFromRight
}

/**
 Direction constants when panning.
 */
@objc public enum PBRevealControllerPanDirection : Int {
    /**
     Panning to left. Should open right view controller.
     */
    case left
    /**
     Panning to right. Should open left view controller.
     */
    case right
}

// MARK: - Delegate functions

/**
Use a reveal view controller delegate (a custom object that implements this protocol) to modify behavior when a view controller is pushed or replaced. All methods are optionals.
 */
@objc public protocol PBRevealViewControllerDelegate: NSObjectProtocol {
    /**
     Ask the delegate if the left view should be shown. Not called while a pan gesture.
     
     See also:
     
        revealControllerPanGestureShouldBegin(_ :direction:)

     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The left view controller object.
     
     - Returns:
        true if the left view controller should be shown, false otherwise.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, shouldShowLeft viewController: UIViewController) -> Bool

    /**
     Called just before the left view controller is presented.

     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The left view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, willShowLeft viewController: UIViewController)

    /**
     Called just after the left view controller is presented.
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The left view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, didShowLeft viewController:UIViewController)

    /**
     Called just before the left view controller is hidden.
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The left view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, willHideLeft viewController: UIViewController)

    /**
     Called just after the left view controller is hidden.
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The left view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, didHideLeft viewController: UIViewController)
    
    /**
     Ask the delegate if the right view should be shown. Not called while a pan gesture.
     
     See also:
     
     revealControllerPanGestureShouldBegin(_ :direction:)
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The right view controller object.
     
     - Returns:

        true if the right view controller should be shown, false otherwise.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, shouldShowRight viewController: UIViewController) -> Bool

    /**
     Called just before the right view controller is presented.
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The right view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, willShowRight viewController: UIViewController)

    /**
     Called just after the right view controller is presented.
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The right view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, didShowRight viewController: UIViewController)

    /**
     Called just before the right view controller is hidden.
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The right view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, willHideRight viewController: UIViewController)

    /**
     Called just after the right view controller is hidden.
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The right view controller object.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, didHideRight viewController: UIViewController)

    /**
     Implement this to return NO when you want the pan gesture recognizer to be ignored.
     
     See also:
     
        panGestureRecognizer
     
     - Parameters:
        - revealController: The reveal view controller object.
        - direction:        The panning direction.

     - Returns:
        false if you want the pan gesture recognizer to be ignored, true otherwise.
     */
    @objc optional func revealControllerPanGestureShouldBegin(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection) -> Bool

    /**
     Implement this to return NO when you want the tap gesture recognizer to be ignored.
     
     See also:
     
        tapGestureRecognizer
     
     - Parameters:
        - revealController: The reveal view controller object.

     - Returns:
        false if you want the tap gesture recognizer to be ignored, true otherwise.
     */
    @objc optional func revealControllerTapGestureShouldBegin(_ revealController: PBRevealViewController) -> Bool

    /**
     Implement this to return true if you want other gesture recognizer to share touch events with the pan gesture.
     
     See also:
     
        panGestureRecognizer
     
     - Parameters:
        - revealController:       The reveal view controller object.
        - otherGestureRecognizer: The other gesture recognizer.
        - direction:              The panning direction.
     
     - Returns:
        true if you want other gesture recognizer to share touch events with the pan gesture.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer, direction: PBRevealControllerPanDirection) -> Bool

    /**
     Implement this to return true if you want other gesture recognizer to share touch events with the tap gesture.
     
     See also:
     
        tapGestureRecognizer
     
     - Parameters:
        - revealController:       The reveal view controller object.
        - otherGestureRecognizer: The other gesture recognizer.

     - Returns:
        true if you want other gesture recognizer to share touch events with the tap gesture.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool

    /**
     Called when the gestureRecognizer began.
     
     See also:
     
     panGestureRecognizer

     - Parameters:
        - revealController: The reveal view controller object.
        - direction:        The panning direction.
     */
    @objc optional func revealControllerPanGestureBegan(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection)

    /**
     Called when the gestureRecognizer moved.
     
     See also:
     
     panGestureRecognizer
     
     - Parameters:
        - revealController: The reveal view controller object.
        - direction:        The panning direction.
     */
    @objc optional func revealControllerPanGestureMoved(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection)

    /**
     Called when the gestureRecognizer ended.
     
     See also:
     
     panGestureRecognizer
     
     - Parameters:
        - revealController: The reveal view controller object.
        - direction:        The panning direction.
     */
    @objc optional func revealControllerPanGestureEnded(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection)

    /**
     Called just before child controller replacement (left, main or right).
     
     See also:
     
     revealController(_ :didAdd:for:animated:)
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The child view controller.
        - operation:        The current operation.
        - animated:         true if the replacement is animated, false otherwise.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, willAdd viewController: UIViewController, for operation: PBRevealControllerOperation, animated: Bool)

    /**
     Called just after child controller replacement (left, main or right).
     
     See also:
     
     revealController(_ :willAdd:for:animated:)
     
     - Parameters:
        - revealController: The reveal view controller object.
        - viewController:   The child view controller.
        - operation:        The current operation.
        - animated:         true if the replacement is animated, false otherwise.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, didAdd viewController: UIViewController, for operation: PBRevealControllerOperation, animated: Bool)

    /**
     Ask for animation block while pushing main view controller.
     
     See also:
     
     revealController(_ :blockFor:from:to:finalBlock:)
     
     - Parameters:
        - revealController:   The reveal view controller object.
        - operation:          The current operation (push from left or push from right).
        - fromViewController: The main view controller.
        - toViewController:   The new main view controller. When called the toViewController's view is behind the fromViewController's view.

     - Returns:
        A block to be inserted in the view animation.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, animationBlockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController, to toViewController: UIViewController) -> ((_: Void) -> Void)?

    /**
     Ask for completion block while pushing main view controller.
     
     See also:
     
     revealController(_ :blockFor:from:to:finalBlock:)
     
     - Parameters:
        - revealController:   The reveal view controller object.
        - operation:          The current operation (push from left or push from right).
        - fromViewController: The main view controller.
        - toViewController:   The new main view controller. When called the toViewController's view is behind the fromViewController's view.

     - Returns:
        A block to be inserted in the view animation completion.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, completionBlockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController, to toViewController: UIViewController) -> ((_: Void) -> Void)?

    /**
     Ask for a block with animation and completion while replacing/pushing child view controllers, please add the final block to your completion.
     
     See also:
     
     revealController(_ :animationBlockFor:from:to:)
     
     revealController(_ :completionBlockFor:from:to:)
     
     revealController(_ :animationControllerForTransitionFrom:to:for:)
     
     - Parameters:
        - revealController:   The reveal view controller object.
        - operation:          The current operation (push from left or push from right).
        - fromViewController: The main view controller.
        - toViewController:   The new main view controller. When called the toViewController's view is behind the fromViewController's view.
        - finalBlock:         The final block provided by the reveal view controller object. This block must be inserted in your completion block.

     - Returns:
        A block with animation and completion (add the final block to your completion).
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, blockFor operation: PBRevealControllerOperation, from fromViewController: UIViewController, to toViewController: UIViewController, finalBlock: @escaping (_: Void) -> Void) -> ((_: Void) -> Void)?

    /**
     Ask for custom transition animations controller while replacing/pushing child view controllers. If implemented, it will be fired in response to calls setXXXViewController or pushXXXViewController child view controller (since iOS 7).
     
     - Parameters:
        - revealController:   The reveal view controller object.
        - fromViewController: The child view controller to replace.
        - toViewController:   The new child view controller.
        - operation:          The current operation (push from left, push from right, or replace).

     - Returns:
        The animator object adopting the UIViewControllerAnimatedTransitioning protocol.
     */
    @objc optional func revealController(_ revealController: PBRevealViewController, animationControllerForTransitionFrom fromViewController: UIViewController, to toViewController: UIViewController, for operation: PBRevealControllerOperation) -> UIViewControllerAnimatedTransitioning?
}

// MARK: - StoryBoard support Classes

// MARK: - PBRevealViewControllerSegueSetController class

/**
 String identifiers to be applied to PBRevealViewControllerSegueSetController segues on a storyboard.
 */

let PBSegueLeftIdentifier: String   = "pb_left"
let PBSegueMainIdentifier: String   = "pb_main"
let PBSegueRightIdentifier: String  = "pb_right"

/**
 Use this to segue to the initial state. View controller segues are "pb_left", "pb_main" and "pb_right".
 */
@objc(PBRevealViewControllerSegueSetController)
open class PBRevealViewControllerSegueSetController: UIStoryboardSegue {
    override open func perform() {
        let identifier: String = self.identifier!
        let rvc: PBRevealViewController? = source as? PBRevealViewController
        let dvc: UIViewController? = destination
        if (identifier == PBSegueMainIdentifier) {
            rvc?.addChildViewController(dvc!)
            dvc?.didMove(toParentViewController: rvc)
            rvc?.mainViewController = dvc
        }
        else if (identifier == PBSegueLeftIdentifier) {
            rvc?.addChildViewController(dvc!)
            dvc?.didMove(toParentViewController: rvc)
            rvc?.leftViewController = dvc
        }
        else if (identifier == PBSegueRightIdentifier) {
            rvc?.addChildViewController(dvc!)
            dvc?.didMove(toParentViewController: rvc)
            rvc?.rightViewController = dvc
        }
        
        #if os(iOS)
            if (floor(NSFoundationVersionNumber) < 7.0) {
                var frame: CGRect? = dvc?.view?.frame
                frame?.origin.y = 0
                if (dvc is UINavigationController) {
                    let statusBarIsHidden: Bool = (UIApplication.shared.statusBarFrame.size.height == 0.0)
                    if !statusBarIsHidden {
                        frame?.size.height -= UIApplication.shared.statusBarFrame.size.height
                    }
                }
                dvc?.view?.frame = frame!
            }
        #endif
    }
}

// MARK: - PBRevealViewControllerSeguePushController class

/**
 Use this to push a view controller from a storyboard.
 */
@objc(PBRevealViewControllerSeguePushController)
open class PBRevealViewControllerSeguePushController: UIStoryboardSegue {
    override open func perform() {
        let rvc: PBRevealViewController? = source.revealViewController()
        let dvc: UIViewController? = destination
        rvc?.pushMainViewController(dvc!, animated: true)
    }
}

// MARK: - PBRevealViewController class - Public

@objc(PBRevealViewController)
open class PBRevealViewController: UIViewController, UIGestureRecognizerDelegate {

    /**
     Defines the radius of the main view's shadow, default is 2.5f.
     */
    open var mainViewShadowRadius: CGFloat = 2.5 {
        didSet {
            _reloadMainShadow()
        }
    }
    
    /**
     Defines the main view's shadow offset, default is {0.0f,2.5f}.
     */
    open var mainViewShadowOffset = CGSize(width: 0.0, height: 2.5) {
        didSet {
            _reloadMainShadow()
        }
    }
    
    /**
     Defines the main view's shadow opacity, default is 1.0f.
     */
    open var mainViewShadowOpacity: Float = 1.0 {
        didSet {
            _reloadMainShadow()
        }
    }
    
    /**
     Defines the main view's shadow color, default is blackColor
     */
    open var mainViewShadowColor: UIColor = UIColor.black {
        didSet {
            _reloadMainShadow()
        }
    }
    
    /**
     If true (default is false) the left view controller will be ofsseted vertically by the height of a navigation bar plus the height of status bar.
     */
    open var isLeftPresentViewHierarchically: Bool = false {
        didSet {
            if self.leftViewController != nil {
                var frame: CGRect = self.leftViewController!.view.frame
                frame.origin.y = 0
                frame.size.height = self.view.bounds.size.height
                self.leftViewController?.view.frame = frame
                if isLeftPresentViewHierarchically {
                    let frame: CGRect = adjustsFrameForController(self.leftViewController!)
                    self.leftViewController?.view.frame = frame
                }
            }
        }
    }
    
    /**
     If false (default is true) the left view controller will be presented below the main view controller.
     */
    open var isLeftPresentViewOnTop: Bool = true
    
    /**
     Defines how much displacement is applied to the left view when animating or dragging the main view, default is 40.0f.
     */
    open var leftViewRevealDisplacement: CGFloat = 40.0
    
    /**
     Defines the width of the left view when it is shown, default is 260.0f.
     */
    open var leftViewRevealWidth: CGFloat = 260.0 {
        didSet {
            if leftViewRevealWidth > UIScreen.main.bounds.size.width {
                leftViewRevealWidth = UIScreen.main.bounds.size.width
            }
            if self.isLeftViewOpen {
                var frame: CGRect = self.leftViewController!.view.frame
                frame.origin.x = 0.0
                frame.size.width = leftViewRevealWidth
                self.leftViewController?.view.frame = frame
                if !self.isLeftPresentViewOnTop {
                    frame = (self.mainViewController?.view.frame)!
                    frame.origin.x = leftViewRevealWidth
                    self.mainViewController?.view.frame = frame
                }
            }
        }
    }
    
    /**
     Duration for the left reveal/push animation, default is 0.5.
     */
    open var leftToggleAnimationDuration: TimeInterval = 0.5
    
    /**
     The damping ratio for the spring animation, default is 0.8.
     */
    open var leftToggleSpringDampingRatio: CGFloat = 0.8
    
    /**
     The initial spring velocity, default is 0.5.
    */
    open var leftToggleSpringVelocity: CGFloat = 0.5
    
    /**
     Defines the radius of the left view's shadow, default is 2.5.
     */
    open var leftViewShadowRadius: CGFloat = 2.5 {
        didSet {
            _reloadLeftShadow()
        }
    }
    
    /**
     Defines the left view's shadow offset, default is {0.0f, 2.5f}.
     */
    open var leftViewShadowOffset: CGSize = CGSize(width: 0.0, height: 2.5) {
        didSet {
            _reloadLeftShadow()
        }
    }
    
    /**
     Defines the left view's shadow opacity, default is 1.0f.
     */
    open var leftViewShadowOpacity: CGFloat = 1.0 {
        didSet {
            _reloadLeftShadow()
        }
    }
    
    /**
     Defines the left view's shadow color, default is blackColor
     */
    open var leftViewShadowColor: UIColor = UIColor.black {
        didSet {
            _reloadLeftShadow()
        }
    }
    
    /**
     Defines the left view's blur effect style, default is PBRevealBlurEffectStyleNone.
     */
    open var leftViewBlurEffectStyle = PBRevealBlurEffectStyle.none {
        didSet {
            if leftViewBlurEffectStyle != oldValue {
                _reloadSideBlurEffectStyle(style: leftViewBlurEffectStyle.rawValue, forController: self.leftViewController, forOperation: .replaceLeftController)
            }
        }
    }
    
    /**
     If true (default is false) the left view controller will be ofsseted vertically by the height of a navigation bar plus the height of status bar.
     */
    open var isRightPresentViewHierarchically: Bool = false {
        didSet {
            if self.rightViewController != nil {
                var frame: CGRect = self.rightViewController!.view.frame
                frame.origin.y = 0
                frame.size.height = self.view.bounds.size.height
                self.rightViewController?.view.frame = frame
                if isRightPresentViewHierarchically {
                    let frame: CGRect = adjustsFrameForController(self.rightViewController!)
                    self.rightViewController?.view.frame = frame
                }
            }
        }
    }
    
    /**
     If false (default is true) the right view controller will be presented below the main view controller.
     */
    open var isRightPresentViewOnTop: Bool = true
    
    /**
     Defines how much displacement is applied to the right view when animating or dragging the main view, default is 40.0f.
     */
    open var rightViewRevealDisplacement: CGFloat = 40.0
    
    /**
     Defines the width of the right view when it is shown, default is 160.0f.
     */
    open var rightViewRevealWidth: CGFloat = 160.0 {
        didSet {
            if rightViewRevealWidth > UIScreen.main.bounds.size.width {
                rightViewRevealWidth = UIScreen.main.bounds.size.width
            }
            if self.isRightViewOpen {
                var frame: CGRect = self.rightViewController!.view.frame
                frame.origin.x = self.view.bounds.size.width - rightViewRevealWidth
                frame.size.width = rightViewRevealWidth
                self.rightViewController?.view.frame = frame
                if !self.isRightPresentViewOnTop {
                    frame = (self.mainViewController?.view.frame)!
                    frame.origin.x = -(rightViewRevealWidth)
                    self.mainViewController?.view.frame = frame
                }
            }
        }
    }
    
    /**
     Duration for the right reveal/push animation, default is 0.5.
     */
    open var rightToggleAnimationDuration: TimeInterval = 0.5
    
    /**
     The damping ratio for the spring animation, default is 0.8f.
     */
    open var rightToggleSpringDampingRatio: CGFloat = 0.8
    
    /**
     The initial spring velocity, default is 0.5f.
     */
    open var rightToggleSpringVelocity: CGFloat = 0.5
    
    /**
     Defines the radius of the lrighteft view's shadow, default is 2.5f.
     */
    open var rightViewShadowRadius: CGFloat = 2.5 {
        didSet {
            _reloadRightShadow()
        }
    }
    
    /**
     Defines the right view's shadow offset, default is {0.0f, 2.5f}.
     */
    open var rightViewShadowOffset: CGSize = CGSize(width: 0.0, height: 2.5) {
        didSet {
            _reloadRightShadow()
        }
    }
    
    /**
     Defines the right view's shadow opacity, default is 1.0f.
     */
    open var rightViewShadowOpacity: CGFloat = 1.0 {
        didSet {
            _reloadRightShadow()
        }
    }
    
    /**
     Defines the right view's shadow color, default is blackColor
     */
    open var rightViewShadowColor: UIColor = UIColor.black {
        didSet {
            _reloadRightShadow()
        }
    }
    
    /**
     Defines the right view's blur effect style, default is PBRevealBlurEffectStyleNone.
     */
    open var rightViewBlurEffectStyle = PBRevealBlurEffectStyle.none {
        didSet {
            if rightViewBlurEffectStyle != oldValue {
                _reloadSideBlurEffectStyle(style: rightViewBlurEffectStyle.rawValue, forController: self.rightViewController, forOperation: .replaceRightController)
            }
        }
    }
    
    /**
     Animation type, default is PBRevealToggleAnimationTypeNone.
     */
    open var toggleAnimationType = PBRevealToggleAnimationType.none
    
    /**
     Defines how much of an overdraw can occur when pushing further than leftViewRevealWidth, default is 60.0f.
     */
    open var leftViewRevealOverdraw: CGFloat = 60.0
    
    /**
     Defines how much of an overdraw can occur when pushing further than rightViewRevealWidth, default is 60.0f.
     */
    open var rightViewRevealOverdraw: CGFloat = 60.0
    
    /**
     Duration for animated replacement of view controllers, default is 0.25.
     */
    open var replaceViewAnimationDuration: TimeInterval = 0.25
    
    /**
     Velocity required for the controller to toggle its state based on a swipe movement, default is 250.0f.
     */
    open var swipeVelocity: CGFloat = 250.0
    
    /**
     true if left view is completely open (read only).
     */
    open private(set) var isLeftViewOpen: Bool = false
    
    /**
     true if right view is completely open (read only).
     */
    open private(set) var isRightViewOpen: Bool = false
    
    /**
     true if left view is panning (read only).
     */
    open private(set) var isLeftViewDragging: Bool = false
    
    /**
     true if right view is panning (read only).
     */
    open private(set) var isRightViewDragging: Bool = false
    
#if os(tvOS)
    /**
     An optional invisible focusable button for revealing left view, default is nil, call [self tvOSLeftRevealButton] once to add it to the reveal view controller's view.
     */
    open var tvOSLeftRevealButton: UIButton?
    
    /**
     An optional invisible focusable button for revealing right view, default is nil, call [self tvOSRightRevealButton] once to add it to the reveal view controller's view.
     */
    open var tvOSRightRevealButton: UIButton?
    
    /**
     An optional swipe gesture recognizer for hidding left view, default is nil, call [self tvOSRightSwipeGestureRecognizer] once to add it to the reveal view controller's view.
     */
    open var tvOSRightSwipeGestureRecognizer: UISwipeGestureRecognizer?
    
    /**
     An optional swipe gesture recognizer for hidding right view, default is nil, call [self tvOSLeftSwipeGestureRecognizer] once to add it to the reveal view controller's view.
     */
    open var tvOSLeftSwipeGestureRecognizer: UISwipeGestureRecognizer?
    
    /**
     The preferred focused view on the main view.
     */
    open var tvOSMainPreferredFocusedView: UIView?
    
    /**
     The preferred focused view on the left view.
     */
    open var tvOSLeftPreferredFocusedView: UIView?
    
    /**
     The preferred focused view on the right view.
     */
    open var tvOSRightPreferredFocusedView: UIView?
    
    /**
     If isPressTypeMenuAllowed is set to true (default is false), show left view when Apple TV Menu button is pressed, back to Apple TV home screen if left menu is open.
     */
    open var isPressTypeMenuAllowed: Bool = false
    
    /**
     If isPressTypePlayPauseAllowed is set to true (default is false), hide left view if opened, show/hide right view when Apple TV PlayPause button is pressed.
     */
    open var isPressTypePlayPauseAllowed: Bool = false
#endif
    
    /**
     The default tap gesture recognizer added to the main view. Default behavior will hide the left or right view.
     */
    open var tapGestureRecognizer: UITapGestureRecognizer?
    
    /**
     The default pan gesture recognizer added to the reveal view. Default behavior will drag the left or right view.
     */
    open var panGestureRecognizer: UIPanGestureRecognizer?
    
    /**
     The default border width allowing pan gesture from left. If > 0.0, this is the acceptable starting width for the gesture.
     */
    open var panFromLeftBorderWidth: CGFloat = 0.0
    
    /**
     The default border width allowing pan gesture from right. If > 0.0, this is the acceptable starting width for the gesture.
     */
    open var panFromRightBorderWidth: CGFloat = 0.0
    
    /**
     Optional left view controller, can be nil if not used.
     */
    open var leftViewController: UIViewController? {
        didSet {
            if leftViewController != oldValue {
                _setLeftViewController(leftViewController: leftViewController!)
            }
        }
    }
    
    /**
     Main view controller, cannot be nil.
     */
    open var mainViewController: UIViewController? {
        didSet {
            if mainViewController != oldValue {
                _setMainViewController(mainViewController: mainViewController!)
            }
        }
    }
    
    /**
     Optional right view controller, can be nil if not used.
     */
    open var rightViewController: UIViewController? {
        didSet {
            if rightViewController != oldValue {
                _setRightViewController(rightViewController: rightViewController!)
            }
        }
    }
    
    /**
     The delegate of the PBRevealViewController object.
     */
    weak open var delegate: PBRevealViewControllerDelegate?

    // MARK: - PBRevealViewController class - Private
    
    private var contentView: UIView?
    private var isUserInteractionStore: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    private var navigationBar: UINavigationBar = UINavigationBar()
    private var leftEffectView: UIVisualEffectView?
    private var leftShadowView: UIView?
    private var leftShadowOpacity: CGFloat = 0.0
    private var rightEffectView: UIVisualEffectView?
    private var rightShadowView: UIView?
    private var rightShadowOpacity: CGFloat = 0.0

    // MARK: - Init

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     Instantiate a PBRevealViewController class programmatically
     
     - Parameters:
        - leftViewController:  A subclass of UIViewController (optional).
        - mainViewController:  A subclass of UIViewController (required).
        - rightViewController: A subclass of UIViewController (optional).

     - Returns:
        PBRevealViewController instance.
     */
    @objc public init(leftViewController: UIViewController?, mainViewController: UIViewController, rightViewController: UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        
        addChildViewController(mainViewController)
        mainViewController.didMove(toParentViewController: self)
        self.mainViewController = mainViewController
        if (leftViewController != nil) {
            addChildViewController(leftViewController!)
            leftViewController!.didMove(toParentViewController: self)
        }
        self.leftViewController = leftViewController
        if rightViewController != nil {
            addChildViewController(rightViewController!)
            rightViewController!.didMove(toParentViewController: self)
        }
        self.rightViewController = rightViewController
        
        #if os(iOS)
            if (floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_7_0) {
                let statusBarIsHidden: Bool = (UIApplication.shared.statusBarFrame.size.height == 0.0)
                var frame: CGRect = mainViewController.view.frame
                frame.origin.y = 0
                if (mainViewController is UINavigationController) {
                    if !statusBarIsHidden {
                        frame.size.height -= UIApplication.shared.statusBarFrame.size.height
                    }
                }
                mainViewController.view.frame = frame
                if (leftViewController != nil) {
                    frame = (leftViewController?.view.frame)!
                    frame.origin.y = 0
                    if (leftViewController is UINavigationController) {
                        if !statusBarIsHidden {
                            frame.size.height -= UIApplication.shared.statusBarFrame.size.height
                        }
                    }
                    leftViewController?.view.frame = frame
                }
                if (rightViewController != nil) {
                    frame = (rightViewController?.view.frame)!
                    frame.origin.y = 0
                    if (rightViewController is UINavigationController) {
                        if !statusBarIsHidden {
                            frame.size.height -= UIApplication.shared.statusBarFrame.size.height
                        }
                    }
                    rightViewController?.view.frame = frame
                }
            }
        #endif
        
        _reloadLeftShadow()
        _reloadRightShadow()
        _reloadMainShadow()
    }

    // MARK: - View lifecycle
    
    override open func loadView() {
        super.loadView()
        var frame: CGRect = UIScreen.main.bounds
        #if os(iOS)
            if (floor(NSFoundationVersionNumber) < 7.0) {
                let statusBarIsHidden: Bool = (UIApplication.shared.statusBarFrame.size.height == 0.0)
                if !statusBarIsHidden {
                    frame.size.height -= UIApplication.shared.statusBarFrame.size.height
                }
            }
        #endif
        self.contentView = PBRevealView(frame: frame, controller: self)
        self.contentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view = self.contentView
        loadStoryboardControllers()
        self.contentView?.addSubview((self.mainViewController?.view)!)
        #if os(iOS)
            _ = _tapGestureRecognizer()
            _ = _panGestureRecognizer()
        #endif
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isUserInteractionStore = (self.contentView?.isUserInteractionEnabled)!
    }
    
    /*
    private func initDefaultProperties() {
        navigationBar = UINavigationBar()
        leftEffectView = nil
        leftShadowView = nil
        leftShadowOpacity = 0.0
        rightEffectView = nil
        rightShadowView = nil
        rightShadowOpacity = 0.0
        mainViewShadowRadius = 2.5
        mainViewShadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(2.5))
        mainViewShadowOpacity = 1.0
        mainViewShadowColor = UIColor.black
        isLeftPresentViewHierarchically = false
        isLeftPresentViewOnTop = true
        leftViewRevealDisplacement = 40.0
        leftViewRevealWidth = 260.0
        leftToggleAnimationDuration = 0.5
        leftToggleSpringDampingRatio = 0.8
        leftToggleSpringVelocity = 0.5
        leftViewShadowRadius = 2.5
        leftViewShadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(2.5))
        leftViewShadowOpacity = 1.0
        leftViewShadowColor = UIColor.black
        leftViewBlurEffectStyle = PBRevealBlurEffectStyle.none
        isRightPresentViewHierarchically = false
        isRightPresentViewOnTop = true
        rightViewRevealDisplacement = 40.0
        rightViewRevealWidth = 160.0
        rightToggleAnimationDuration = 0.5
        rightToggleSpringDampingRatio = 0.8
        rightToggleSpringVelocity = 0.5
        rightViewShadowRadius = 2.5
        rightViewShadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(2.5))
        rightViewShadowOpacity = 1.0
        rightViewShadowColor = UIColor.black
        rightViewBlurEffectStyle = PBRevealBlurEffectStyle.none
        replaceViewAnimationDuration = 0.25
        swipeVelocity = 250.0
        toggleAnimationType = PBRevealToggleAnimationType.none
        leftViewRevealOverdraw = 60.0
        rightViewRevealOverdraw = 60.0
        isLeftViewOpen = false
        isLeftViewDragging = false
        isRightViewOpen = false
        isRightViewDragging = false
        isUserInteractionStore = true
        #if os(tvOS)
            isPressTypeMenuAllowed = false
            isPressTypePlayPauseAllowed = false
        #endif
    }
    */
    
    // Load any defined Main/Left/Right controllers from the storyboard
    private func loadStoryboardControllers() {
        
        if (self.storyboard != nil) && leftViewController == nil {
            
            //Try each segue separately so it doesn't break prematurely if either Rear or Right views are not used.
            self.performSegue(id: PBSegueLeftIdentifier, sender: nil)
            self.performSegue(id: PBSegueMainIdentifier, sender: nil)
            self.performSegue(id: PBSegueRightIdentifier, sender: nil)
        }
    }
    
    // MARK: - Public methods

    /**
     Defines the width of the left view when it is shown.

     - Parameters:
        - leftViewRevealWidth: The left view width.
        - animated:            Specify true to animate the new width or false if you do not want it to be animated.
     */
    @objc open func setLeftViewRevealWidth(_ leftViewRevealWidth: CGFloat, animated: Bool) {
        let duration: TimeInterval = animated ? leftToggleAnimationDuration : 0.0
        if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) {
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: leftToggleSpringDampingRatio, initialSpringVelocity: leftToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                self.leftViewRevealWidth = leftViewRevealWidth
            }, completion: {(_ finished: Bool) -> Void in
            })
        }
        else {
            UIView.animate(withDuration: duration, animations: {() -> Void in
                self.leftViewRevealWidth = leftViewRevealWidth
            })
        }
    }

    /**
     Defines the width of the right view.

     - Parameters:
        - rightViewRevealWidth: The right view width.
        - animated:             Specify true to animate the new width or false if you do not want it to be animated.
     */
    @objc open func setRightViewRevealWidth(_ rightViewRevealWidth: CGFloat, animated: Bool) {
        let duration: TimeInterval = animated ? rightToggleAnimationDuration : 0.0
        if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) {
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: rightToggleSpringDampingRatio, initialSpringVelocity: rightToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                self.rightViewRevealWidth = rightViewRevealWidth
            }, completion: {(_ finished: Bool) -> Void in
            })
        }
        else {
            UIView.animate(withDuration: duration, animations: {() -> Void in
                self.rightViewRevealWidth = rightViewRevealWidth
            })
        }
    }

    /**
     Replace the left view controller.

     - Parameters:
        - leftViewController: A subclass of UIViewController.
        - animated:           Specify true to animate the replacement or false if you do not want the replacement to be animated.
     */
    @objc open func setLeftViewController(_ leftViewController: UIViewController, animated: Bool) {
        if isLeftPresentViewHierarchically {
            let frame: CGRect = adjustsFrameForController(leftViewController)
            leftViewController.view.frame = frame
        }
        _reloadSideBlurEffectStyle(style: self.leftViewBlurEffectStyle.rawValue, forController: leftViewController, forOperation: .replaceLeftController)
        if isLeftViewOpen {
            _swapFromViewController(self.leftViewController!, toViewController: leftViewController, operation: .replaceLeftController, animated: animated)
        }
        self.leftViewController = leftViewController
        _reloadLeftShadow()
    }

    /**
     Replace the main view controller.

     - Parameters:
        - mainViewController: A subclass of UIViewController.
        - animated:           Specify true to animate the replacement or false if you do not want the replacement to be animated.
     */
    @objc open func setMainViewController(_ mainViewController: UIViewController, animated: Bool) {
        if (self.mainViewController != nil) && animated {
            _swapFromViewController(self.mainViewController!, toViewController: mainViewController, operation: .replaceMainController, animated: animated)
        }
        self.mainViewController = mainViewController
        _reloadMainShadow()
    }

    /**
     Replace the right view controller.

     - Parameters:
        - rightViewController: A subclass of UIViewController.
        - animated:            Specify true to animate the replacement or false if you do not want the replacement to be animated.
     */
    @objc open func setRightViewController(_ rightViewController: UIViewController, animated: Bool) {
        if isRightPresentViewHierarchically {
            let frame: CGRect = adjustsFrameForController(rightViewController)
            rightViewController.view.frame = frame
        }
        _reloadSideBlurEffectStyle(style: self.rightViewBlurEffectStyle.rawValue, forController: rightViewController, forOperation: .replaceRightController)
        if isRightViewOpen {
            _swapFromViewController(self.rightViewController!, toViewController: rightViewController, operation: .replaceRightController, animated: animated)
        }
        self.rightViewController = rightViewController
        _reloadRightShadow()
    }

    /**
     Sets the mainViewController pushing it and hide left view controller.

     - Parameters:
        - mainViewController: A subclass of UIViewController.
        - animated:           Specify true to animate the replacement or false if you do not want the replacement to be animated.
     */
    @objc open func pushMainViewController(_ mainViewController: UIViewController, animated: Bool) {
        var operation: PBRevealControllerOperation
        if isLeftViewOpen {
            operation = .pushMainControllerFromLeft
        }
        else if isRightViewOpen {
            operation = .pushMainControllerFromRight
        }
        else {
            return
        }
        
        let fromViewController: UIViewController? = self.mainViewController
        self.mainViewController = mainViewController
        _pushFromViewController(fromViewController!, toViewController: mainViewController, operation: operation, animated: animated)
    }

    /**
     Reveal left view or hide it if shown. Hide the right view if it is open and show the left view.
     */
    @IBAction @objc open func revealLeftView() {
        if (self.leftViewController != nil) {
            if isLeftViewOpen {
                hideLeftView(animated: true)
                return
            }
            if isRightViewOpen {
                hideRightView(animated: true)
            }
            if delegate?.revealController?(self, shouldShowLeft: self.leftViewController!) == false {
                return
            }
            delegate?.revealController?(self, willShowLeft: self.leftViewController!)
            var leftFrame: CGRect = self.leftViewController!.view.frame
            if self.isLeftPresentViewOnTop {
                leftFrame.origin.x = -(self.leftViewRevealWidth)
            }
            else {
                leftFrame.origin.x = -(self.leftViewRevealDisplacement)
            }
            leftFrame.size.width = self.leftViewRevealWidth
            self.leftViewController?.view.frame = leftFrame
            if self.isLeftPresentViewOnTop {
                self.contentView?.addSubview((self.leftViewController?.view)!)
            }
            else {
                self.contentView?.insertSubview((self.leftViewController?.view)!, belowSubview: (self.mainViewController?.view)!)
            }
            addChildViewController(self.leftViewController!)
            self.leftViewController?.didMove(toParentViewController: self)
            let completion: (() -> Void) = {() -> Void in
                self.isLeftViewOpen = true
                #if os(iOS)
                    self.tapGestureRecognizer?.cancelsTouchesInView = true
                #endif
                #if os(tvOS)
                    self.tvOSLeftRevealButton?.removeFromSuperview()
                    self.tvOSRightRevealButton?.removeFromSuperview()
                    self.setNeedsFocusUpdate()
                    self.updateFocusIfNeeded()
                #endif
                self.delegate?.revealController?(self, didShowLeft: self.leftViewController!)
            }
            leftFrame.origin.x = 0
            leftFrame.size.width = self.leftViewRevealWidth
            var mainFrame: CGRect = self.mainViewController!.view.frame
            if !self.isLeftPresentViewOnTop {
                mainFrame.origin.x = self.leftViewRevealWidth
            }
            if (floor(NSFoundationVersionNumber) >= 7.0) {
                self.leftViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: leftToggleAnimationDuration, delay: 0.0, usingSpringWithDamping: leftToggleSpringDampingRatio, initialSpringVelocity: leftToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                    self.leftViewController?.view.layoutIfNeeded()
                    self.leftViewController?.view.frame = leftFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
            else {
                self.leftViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: leftToggleAnimationDuration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                    self.leftViewController?.view.layoutIfNeeded()
                    self.leftViewController?.view.frame = leftFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
        }
    }

    /**
     Reveal right view or hide it if shown.  Hide the left view if it is open and show the right view.
     */
    @IBAction @objc open func revealRightView() {
        if (self.rightViewController != nil) {
            if isRightViewOpen {
                hideRightView(animated: true)
                return
            }
            if isLeftViewOpen {
                hideLeftView(animated: true)
            }
            if delegate?.revealController?(self, shouldShowRight: self.rightViewController!) == false {
                return
            }
            delegate?.revealController?(self, willShowRight: self.rightViewController!)
            var rightFrame: CGRect = self.rightViewController!.view.frame
            if self.isRightPresentViewOnTop {
                rightFrame.origin.x = view.bounds.size.width
            }
            else {
                rightFrame.origin.x = view.bounds.size.width - (rightViewRevealWidth) + rightViewRevealDisplacement
            }
            rightFrame.size.width = rightViewRevealWidth
            self.rightViewController?.view.frame = rightFrame
            if self.isRightPresentViewOnTop {
                self.contentView?.addSubview((self.rightViewController?.view)!)
            }
            else {
                self.contentView?.insertSubview((self.rightViewController?.view)!, belowSubview: (self.mainViewController?.view)!)
            }
            addChildViewController(self.rightViewController!)
            self.rightViewController?.didMove(toParentViewController: self)
            let completion: (() -> Void) = {() -> Void in
                self.isRightViewOpen = true
                #if os(iOS)
                    self.tapGestureRecognizer?.cancelsTouchesInView = true
                #endif
                #if os(tvOS)
                    self.tvOSLeftRevealButton?.removeFromSuperview()
                    self.tvOSRightRevealButton?.removeFromSuperview()
                    self.setNeedsFocusUpdate()
                    self.updateFocusIfNeeded()
                #endif
                self.delegate?.revealController?(self, didShowRight: self.rightViewController!)
            }
            rightFrame.origin.x = view.bounds.size.width - self.rightViewRevealWidth
            rightFrame.size.width = self.rightViewRevealWidth
            var mainFrame: CGRect = self.mainViewController!.view.frame
            if !self.isRightPresentViewOnTop {
                mainFrame.origin.x = -(self.rightViewRevealWidth)
            }
            if (floor(NSFoundationVersionNumber) >= 7.0) {
                self.rightViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: rightToggleAnimationDuration, delay: 0.0, usingSpringWithDamping: rightToggleSpringDampingRatio, initialSpringVelocity: rightToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                    self.rightViewController?.view.layoutIfNeeded()
                    self.rightViewController?.view.frame = rightFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
            else {
                self.rightViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: rightToggleAnimationDuration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                    self.rightViewController?.view.layoutIfNeeded()
                    self.rightViewController?.view.frame = rightFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
        }
    }

    /**
     Hide left view.

     - Parameters:
        - animated: Specify true to animate the replacement or false if you do not want the replacement to be animated.
     */
    @objc open func hideLeftView(animated: Bool) {
        if (self.leftViewController != nil) {
            delegate?.revealController?(self, willHideLeft: self.leftViewController!)
            let duration: TimeInterval = animated ? leftToggleAnimationDuration : 0.0
            var leftFrame: CGRect = self.leftViewController!.view.frame
            if isLeftPresentViewOnTop {
                leftFrame.origin.x = -(self.leftViewRevealWidth)
            }
            else {
                leftFrame.origin.x = -(self.leftViewRevealDisplacement)
            }
            leftFrame.size.width = self.leftViewRevealWidth
            var mainFrame: CGRect = self.mainViewController!.view.frame
            mainFrame.origin.x = 0
            let completion: (() -> Void) = {() -> Void in
                self.isLeftViewOpen = false
                #if os(iOS)
                    self.tapGestureRecognizer?.cancelsTouchesInView = false
                    if self.isRightViewOpen {
                        self.tapGestureRecognizer?.cancelsTouchesInView = true
                    }
                #endif
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController?.willMove(toParentViewController: nil)
                self.leftViewController?.removeFromParentViewController()
                #if os(tvOS)
                    self.setNeedsFocusUpdate()
                    self.updateFocusIfNeeded()
                    self.contentView?.addSubview(self.tvOSLeftRevealButton!)
                    self.contentView?.addSubview(self.tvOSRightRevealButton!)
                #endif
                self.delegate?.revealController?(self, didHideLeft: self.leftViewController!)
            }
            if (floor(NSFoundationVersionNumber) >= 7.0) {
                self.leftViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: leftToggleSpringDampingRatio, initialSpringVelocity: leftToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                    self.leftViewController?.view.layoutIfNeeded()
                    self.leftViewController?.view.frame = leftFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
            else {
                self.leftViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: duration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                    self.leftViewController?.view.layoutIfNeeded()
                    self.leftViewController?.view.frame = leftFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
        }
    }

    /**
     Hide right view.

     - Parameters:
        - animated: Specify true to animate the replacement or false if you do not want the replacement to be animated.
     */
    @objc open func hideRightView(animated: Bool) {
        if (self.rightViewController != nil) {
            delegate?.revealController?(self, willHideRight: self.rightViewController!)
            let duration: TimeInterval = animated ? rightToggleAnimationDuration : 0.0
            var rightFrame: CGRect = self.rightViewController!.view.frame
            if self.isRightPresentViewOnTop {
                rightFrame.origin.x = view.bounds.size.width
            }
            else {
                rightFrame.origin.x = view.bounds.size.width - (rightViewRevealWidth) + rightViewRevealDisplacement
            }
            rightFrame.size.width = rightViewRevealWidth
            var mainFrame: CGRect = self.mainViewController!.view.frame
            mainFrame.origin.x = 0
            let completion: (() -> Void) = {() -> Void in
                self.isRightViewOpen = false
                #if os(iOS)
                    self.tapGestureRecognizer?.cancelsTouchesInView = false
                    if self.isLeftViewOpen {
                        self.tapGestureRecognizer?.cancelsTouchesInView = true
                    }
                #endif
                self.rightViewController?.view.removeFromSuperview()
                self.rightViewController?.willMove(toParentViewController: nil)
                self.rightViewController?.removeFromParentViewController()
                #if os(tvOS)
                    self.setNeedsFocusUpdate()
                    self.updateFocusIfNeeded()
                    self.contentView?.addSubview(self.tvOSLeftRevealButton!)
                    self.contentView?.addSubview(self.tvOSRightRevealButton!)
                #endif
                self.delegate?.revealController?(self, didHideRight: self.rightViewController!)
            }
            if (floor(NSFoundationVersionNumber) >= 7.0) {
                self.rightViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: rightToggleSpringDampingRatio, initialSpringVelocity: rightToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                    self.rightViewController?.view.layoutIfNeeded()
                    self.rightViewController?.view.frame = rightFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
            else {
                self.rightViewController?.view.layoutIfNeeded()
                UIView.animate(withDuration: duration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                    self.rightViewController?.view.layoutIfNeeded()
                    self.rightViewController?.view.frame = rightFrame
                    self.mainViewController?.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            }
        }
    }

    // MARK: - Private methods

    private func _reloadMainShadow() {
        let layer: CALayer? = self.mainViewController?.view.layer
        layer?.masksToBounds = false
        layer?.shadowColor = self.mainViewShadowColor.cgColor
        layer?.shadowOpacity = self.mainViewShadowOpacity
        layer?.shadowOffset = self.mainViewShadowOffset
        layer?.shadowRadius = self.mainViewShadowRadius
    }

    private func _reloadLeftShadow() {
        if self.leftShadowOpacity != 0.0 {
            self.leftViewController?.view.layer.shadowOpacity = 0.0
            if self.leftShadowView == nil {
                self.leftShadowView = UIView(frame: (self.leftViewController?.view.bounds)!)
            }
            self.leftShadowView?.translatesAutoresizingMaskIntoConstraints = false
            
            self.leftShadowView?.backgroundColor = UIColor.black
            self.leftShadowView?.layer.masksToBounds = false
            self.leftShadowView?.layer.shadowColor = self.leftViewShadowColor.cgColor
            self.leftShadowView?.layer.shadowOffset = self.leftViewShadowOffset
            self.leftShadowView?.layer.shadowOpacity = Float(self.leftViewShadowOpacity)
            self.leftShadowView?.layer.shadowRadius = self.leftViewShadowRadius
            
            self.leftViewController?.view.insertSubview(self.leftShadowView!, at: 0)
            
            // Set constraints programmatically, as this view is animatable
            NSLayoutConstraint(item: self.leftShadowView!, attribute: .trailing, relatedBy: .equal, toItem: self.leftViewController?.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.leftShadowView!, attribute: .top, relatedBy: .equal, toItem: self.leftViewController?.view, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.leftShadowView!, attribute: .bottom, relatedBy: .equal, toItem: self.leftViewController?.view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.leftShadowView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 5.0).isActive = true
            return
        }
        let layer: CALayer? = self.leftViewController?.view.layer
        layer?.masksToBounds = false
        layer?.shadowColor = self.leftViewShadowColor.cgColor
        layer?.shadowOpacity = Float(self.leftViewShadowOpacity)
        layer?.shadowOffset = self.leftViewShadowOffset
        layer?.shadowRadius = self.leftViewShadowRadius
    }

    private func _reloadRightShadow() {
        if self.rightShadowOpacity != 0.0 {
            self.rightViewController?.view.layer.shadowOpacity = 0.0
            if rightShadowView == nil {
                self.rightShadowView = UIView(frame: (self.rightViewController?.view.bounds)!)
            }
            self.rightShadowView?.translatesAutoresizingMaskIntoConstraints = false
            
            self.rightShadowView?.backgroundColor = UIColor.white
            self.rightShadowView?.layer.masksToBounds = false
            self.rightShadowView?.layer.shadowColor = self.rightViewShadowColor.cgColor
            self.rightShadowView?.layer.shadowOffset = self.rightViewShadowOffset
            self.rightShadowView?.layer.shadowOpacity = Float(self.rightViewShadowOpacity)
            self.rightShadowView?.layer.shadowRadius = self.rightViewShadowRadius
            
            self.rightViewController?.view.insertSubview(self.rightShadowView!, at: 0)
            
            // Set constraints programmatically, as this view is animatable
            NSLayoutConstraint(item: self.rightShadowView!, attribute: .leading, relatedBy: .equal, toItem: self.rightViewController?.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.rightShadowView!, attribute: .top, relatedBy: .equal, toItem: self.rightViewController?.view, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.rightShadowView!, attribute: .bottom, relatedBy: .equal, toItem: rightViewController?.view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.rightShadowView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 5.0).isActive = true
            return
        }
        let layer: CALayer? = self.rightViewController?.view.layer
        layer?.masksToBounds = false
        layer?.shadowColor = self.rightViewShadowColor.cgColor
        layer?.shadowOpacity = Float(self.rightViewShadowOpacity)
        layer?.shadowOffset = self.rightViewShadowOffset
        layer?.shadowRadius = self.rightViewShadowRadius
    }

    private func _reloadSideBlurEffectStyle(style: Int, forController sideViewController: UIViewController?, forOperation operation:PBRevealControllerOperation) {
        if sideViewController == nil {
            return
        }
        if (floor(NSFoundationVersionNumber) >= 8.0) {
            var tableView: UITableView?
            if (sideViewController is UINavigationController) {
                let nc: UINavigationController? = (sideViewController as? UINavigationController)
                tableView = self.tableViewInView((nc?.topViewController?.view)!)
            }
            else {
                tableView = self.tableViewInView((sideViewController?.view)!)
            }
            if style != PBRevealBlurEffectStyle.none.rawValue {
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle(rawValue: style)!)
                let sideEffectView = UIVisualEffectView(effect: blurEffect)
                sideEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                #if os(iOS)
                    let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
                #endif
                switch operation {
                case .replaceLeftController:
                    self.leftEffectView?.removeFromSuperview()
                    self.leftEffectView = sideEffectView
                    if #available(iOS 10, *) {
                        if (floor(NSFoundationVersionNumber) >= 10.0) {
                            if self.leftViewShadowOpacity > 0.0 {
                                self.leftShadowOpacity = self.leftViewShadowOpacity
                                _reloadLeftShadow()
                            }
                        }
                    }
                    
                case .replaceRightController:
                    self.rightEffectView?.removeFromSuperview()
                    self.rightEffectView = sideEffectView
                    if #available(iOS 10, *) {
                        if (floor(NSFoundationVersionNumber) >= 10.0) {
                            if self.rightViewShadowOpacity > 0.0 {
                                self.rightShadowOpacity = self.rightViewShadowOpacity
                                _reloadRightShadow()
                            }
                        }
                    }
                    
                default:
                    break
                }
                
                if tableView != nil {
                    switch operation {
                    case .replaceLeftController:
                        self.leftEffectView?.frame = (tableView?.bounds)!
                        tableView?.backgroundView = self.leftEffectView
                    case .replaceRightController:
                        self.rightEffectView?.frame = (tableView?.bounds)!
                        tableView?.backgroundView = self.rightEffectView
                    default:
                        break
                    }
                    
                    tableView?.backgroundColor = UIColor.clear
                    #if os(iOS)
                        tableView?.separatorEffect = vibrancyEffect
                    #endif
                }
                else {
                    var sideView: UIView? = sideViewController?.view
                    if (sideViewController is UINavigationController) {
                        let nc: UINavigationController? = (sideViewController as? UINavigationController)
                        sideView = nc?.topViewController?.view
                    }
                    sideView?.backgroundColor = UIColor.clear
                    switch operation {
                    case .replaceLeftController:
                        self.leftEffectView?.frame = (sideView?.bounds)!
                        sideView?.addSubview(self.leftEffectView!)
                    case .replaceRightController:
                        self.rightEffectView?.frame = (sideView?.bounds)!
                        sideView?.addSubview(self.rightEffectView!)
                    default:
                        break
                    }
                }
            }
            else {
                if tableView != nil {
                    if ((tableView?.backgroundView) != nil) && (tableView?.backgroundView == self.leftEffectView || tableView?.backgroundView == self.rightEffectView) {
                        tableView?.backgroundView = nil
                        #if os(iOS)
                            tableView?.separatorEffect = nil
                        #endif
                    }
                }
                else {
                    switch operation {
                    case .replaceLeftController:
                        self.leftEffectView?.removeFromSuperview()
                    case .replaceRightController:
                        self.rightEffectView?.removeFromSuperview()
                    default:
                        break
                    }
                }
                switch operation {
                case .replaceLeftController:
                    self.leftEffectView = nil
                    self.leftShadowOpacity = 0.0
                    self.leftShadowView?.removeFromSuperview()
                    _reloadLeftShadow()
                case .replaceRightController:
                    self.rightEffectView = nil
                    self.rightShadowOpacity = 0.0
                    self.rightShadowView?.removeFromSuperview()
                    _reloadRightShadow()
                default:
                    break
                }
            }
        }
    }

    private func _setLeftViewController(leftViewController: UIViewController) {
        setLeftViewController(leftViewController, animated: false)
    }

    private func _setMainViewController(mainViewController: UIViewController) {
        setMainViewController(mainViewController, animated: false)
    }

    private func _setRightViewController(rightViewController: UIViewController) {
        setRightViewController(rightViewController, animated: false)
    }

    private func _swapFromViewController(_ fromViewController: UIViewController, toViewController: UIViewController, operation: PBRevealControllerOperation, animated: Bool) {
        let duration: TimeInterval = animated ? replaceViewAnimationDuration : 0.0
        if fromViewController != toViewController {
            toViewController.view.frame = fromViewController.view.frame
            delegate?.revealController?(self, willAdd: toViewController, for: operation, animated: animated)
            switch operation {
            case .replaceLeftController, .replaceRightController:
                self.contentView?.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            case .replaceMainController:
                self.contentView?.insertSubview(toViewController.view, belowSubview: fromViewController.view)
                #if os(iOS)
                    self.contentView?.addGestureRecognizer(self.tapGestureRecognizer!)
                    self.contentView?.addGestureRecognizer(self.panGestureRecognizer!)
                #endif
                
            default:
                break
            }
            
            addChildViewController(toViewController)
            fromViewController.willMove(toParentViewController: nil)
            let completion: (() -> Void) = {() -> Void in
                fromViewController.view.removeFromSuperview()
                fromViewController.removeFromParentViewController()
                toViewController.didMove(toParentViewController: self)
                self.delegate?.revealController?(self, didAdd: toViewController, for: operation, animated: animated)
            }
            var customBlock: (() -> Void)?
            customBlock = delegate?.revealController?(self, blockFor: operation, from: fromViewController, to: toViewController, finalBlock: completion)
            if (floor(NSFoundationVersionNumber) >= 7.0) {
                var animator: UIViewControllerAnimatedTransitioning? = nil
                animator = delegate?.revealController?(self, animationControllerForTransitionFrom: fromViewController, to: toViewController, for: operation)
                if animator != nil {
                    let transitioningObject = PBContextTransitionObject(revealController: self, containerView: self.contentView!, fromViewController: fromViewController, toViewController: toViewController, completion: completion)
                    animator?.animateTransition(using: transitioningObject)
                    return
                }
            }
            if customBlock != nil {
                customBlock!()
            }
            else {
                UIView.transition(with: fromViewController.view, duration: duration, options: [.layoutSubviews, .transitionCrossDissolve], animations: {() -> Void in
                    fromViewController.view.isHidden = true
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                    fromViewController.view.isHidden = false
                })
            }
        }
    }

    private func _pushFromViewController(_ fromViewController: UIViewController, toViewController: UIViewController, operation: PBRevealControllerOperation, animated: Bool) {
        let duration: TimeInterval = animated ? (isLeftViewOpen ? leftToggleAnimationDuration : rightToggleAnimationDuration) : 0.0
        if fromViewController == toViewController {
            if operation == .pushMainControllerFromLeft {
                hideLeftView(animated: true)
            }
            if operation == .pushMainControllerFromRight {
                hideRightView(animated: true)
            }
            return
        }
        toViewController.view.frame = fromViewController.view.frame
        delegate?.revealController?(self, willAdd: toViewController, for: operation, animated: animated)
        
        let completion: (() -> Void) = {() -> Void in
            fromViewController.view.removeFromSuperview()
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
            if operation == .pushMainControllerFromLeft {
                self.hideLeftView(animated: true)
            }
            if operation == .pushMainControllerFromRight {
                self.hideRightView(animated: true)
            }
            #if os(iOS)
                self.contentView?.addGestureRecognizer(self.tapGestureRecognizer!)
                self.contentView?.addGestureRecognizer(self.panGestureRecognizer!)
            #endif
            self.delegate?.revealController?(self, didAdd: toViewController, for: operation, animated: animated)
        }
        self.contentView?.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        addChildViewController(toViewController)
        fromViewController.willMove(toParentViewController: nil)
        if self.toggleAnimationType == .none {
            completion()
        }
        else if self.toggleAnimationType == .crossDissolve {
            UIView.transition(with: fromViewController.view, duration: duration, options: [.layoutSubviews, .transitionCrossDissolve], animations: {() -> Void in
                fromViewController.view.isHidden = true
            }, completion: {(_ finished: Bool) -> Void in
                completion()
                fromViewController.view.isHidden = false
            })
        }
        else if self.toggleAnimationType == .pushSideView {
            var sideViewController: UIViewController?
            var mainFrame: CGRect
            var sideFrame: CGRect
            sideViewController = (self.isLeftViewOpen ? self.leftViewController : self.rightViewController)
            self.contentView?.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
            mainFrame = toViewController.view.frame
            mainFrame.origin.x = (isLeftViewOpen ? leftViewRevealWidth : -(rightViewRevealWidth))
            toViewController.view.frame = mainFrame
            mainFrame.origin.x = 0.0
            sideFrame = (sideViewController?.view?.frame)!
            sideFrame.origin.x = (self.isLeftViewOpen ? -(self.leftViewRevealWidth) : view.bounds.size.width)
            UIView.animate(withDuration: duration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                toViewController.view.frame = mainFrame
                sideViewController?.view?.frame = sideFrame
            }, completion: {(_ finished: Bool) -> Void in
                completion()
            })
        }
        else if self.toggleAnimationType == .spring {
            var sideViewController: UIViewController?
            var sidePresentViewOnTop: Bool
            var mainFrame: CGRect
            var sideFrame: CGRect
            sideViewController = (self.isLeftViewOpen ? self.leftViewController : self.rightViewController)
            self.contentView?.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
            sidePresentViewOnTop = (self.isLeftViewOpen ? self.isLeftPresentViewOnTop : self.isRightPresentViewOnTop)
            sideFrame = (sideViewController?.view?.frame)!
            sideFrame.origin.x += (self.isLeftViewOpen ? 0.0 : -(self.rightViewRevealOverdraw))
            sideFrame.size.width += (self.isLeftViewOpen ? self.leftViewRevealOverdraw : self.rightViewRevealOverdraw)
            mainFrame = toViewController.view.frame
            mainFrame.origin.x = (self.isLeftViewOpen ? self.leftViewRevealWidth + self.leftViewRevealOverdraw : -(self.rightViewRevealWidth) - self.rightViewRevealOverdraw)
            toViewController.view.isHidden = true
            UIView.animate(withDuration: duration / 2, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                sideViewController?.view?.frame = sideFrame
                if !sidePresentViewOnTop {
                    fromViewController.view.frame = mainFrame
                    toViewController.view.frame = mainFrame
                }
            }, completion: {(_ finished: Bool) -> Void in
                toViewController.view.frame = mainFrame
                mainFrame.origin.x = 0.0
                sideFrame.origin.x = (self.isLeftViewOpen ? -(self.leftViewRevealWidth) : self.view.bounds.size.width)
                sideFrame.size.width = (self.isLeftViewOpen ? self.leftViewRevealWidth : self.rightViewRevealWidth)
                toViewController.view.isHidden = false
                UIView.animate(withDuration: duration / 2, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                    sideViewController?.view?.frame = sideFrame
                    toViewController.view.frame = mainFrame
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                })
            })
        }
        else if self.toggleAnimationType == .custom {
            var customAnimation: (() -> Void)?
            customAnimation = delegate?.revealController?(self, animationBlockFor: operation, from: fromViewController, to: toViewController)
            var customCompletion: (() -> Void)?
            customCompletion = delegate?.revealController?(self, completionBlockFor: operation, from: fromViewController, to: toViewController)
            var customBlock: (() -> Void)?
            customBlock = delegate?.revealController?(self, blockFor: operation, from: fromViewController, to: toViewController, finalBlock: completion)
            if (floor(NSFoundationVersionNumber) >= 7.0) {
                var animator: UIViewControllerAnimatedTransitioning? = nil
                animator = delegate?.revealController?(self, animationControllerForTransitionFrom: fromViewController, to: toViewController, for: operation)
                if animator != nil {
                    let transitioningObject = PBContextTransitionObject(revealController: self, containerView: self.contentView!, fromViewController: fromViewController, toViewController: toViewController, completion: completion)
                    animator?.animateTransition(using: transitioningObject)
                    return
                }
            }
            if customBlock != nil {
                customBlock!()
            }
            else if customAnimation != nil {
                UIView.animate(withDuration: duration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                    customAnimation!()
                }, completion: {(_ finished: Bool) -> Void in
                    completion()
                    if (customCompletion != nil) {
                        customCompletion!()
                    }
                })
            }
        }
        
    }

// MARK: - Gesture Recognizer
    
#if os(tvOS)
    @objc open func _tvOSLeftRevealButton() -> UIButton {
        if self.tvOSLeftRevealButton == nil {
            self.tvOSLeftRevealButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: self.view.bounds.size.height))
            self.tvOSLeftRevealButton?.backgroundColor = UIColor.clear
            self.contentView?.addSubview(self.tvOSLeftRevealButton!)
        }
        return self.tvOSLeftRevealButton!
    }

    @objc open func _tvOSRightRevealButton() -> UIButton {
        if self.tvOSRightRevealButton == nil {
            self.tvOSRightRevealButton = UIButton(frame: CGRect(x: self.view.bounds.size.width - 10.0, y: 0.0, width: 10.0, height: self.view.bounds.size.height))
            self.tvOSRightRevealButton?.backgroundColor = UIColor.clear
            self.contentView?.addSubview(self.tvOSRightRevealButton!)
        }
        return self.tvOSRightRevealButton!
    }

    @objc open func _tvOSLeftSwipeGestureRecognizer() -> UISwipeGestureRecognizer {
        if self.tvOSLeftSwipeGestureRecognizer == nil {
            self.tvOSLeftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self._handleLeftSwipeGesture))
            self.tvOSLeftSwipeGestureRecognizer?.direction = .left
            self.contentView?.addGestureRecognizer(self.tvOSLeftSwipeGestureRecognizer!)
        }
        return self.tvOSLeftSwipeGestureRecognizer!
    }

    @objc open func _tvOSRightSwipeGestureRecognizer() -> UISwipeGestureRecognizer {
        if self.tvOSRightSwipeGestureRecognizer == nil {
            self.tvOSRightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self._handleRightSwipeGesture))
            self.tvOSRightSwipeGestureRecognizer?.direction = .right
            self.contentView?.addGestureRecognizer(self.tvOSRightSwipeGestureRecognizer!)
        }
        return self.tvOSRightSwipeGestureRecognizer!
    }

#endif
    private func _tapGestureRecognizer() -> UITapGestureRecognizer {
//#if os(iOS)
        if self.tapGestureRecognizer == nil {
            self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self._handleTapGesture(_:)))
            self.tapGestureRecognizer?.cancelsTouchesInView = false
            self.tapGestureRecognizer?.delegate = self
            self.contentView?.addGestureRecognizer(self.tapGestureRecognizer!)
        }
//#endif
        return self.tapGestureRecognizer!
    }

    private func _panGestureRecognizer() -> UIPanGestureRecognizer {
//#if os(iOS)
        if self.panGestureRecognizer == nil {
            self.panGestureRecognizer = PBRevealViewControllerPanGestureRecognizer(target: self, action: #selector(self._handlePanGesture(_:)))
            self.panGestureRecognizer?.delegate = self
            self.contentView?.addGestureRecognizer(self.panGestureRecognizer!)
            self.leftViewController?.willMove(toParentViewController: nil)
            self.leftViewController?.removeFromParentViewController()
            self.rightViewController?.willMove(toParentViewController: nil)
            self.rightViewController?.removeFromParentViewController()
        }
//#endif
        return self.panGestureRecognizer!
    }

    // MARK: - Gesture Delegate
    
    public func gestureRecognizerShouldBegin(_ recognizer: UIGestureRecognizer) -> Bool {
        if recognizer == self.tapGestureRecognizer {
            if delegate?.revealControllerTapGestureShouldBegin?(self) == false {
                return false
            }
        }
        if recognizer == self.panGestureRecognizer {
            let velocity: CGFloat = (self.panGestureRecognizer?.velocity(in: self.contentView).x)!
            if (delegate?.revealControllerPanGestureShouldBegin?(self, direction: velocity > 0.0 ? .right : .left)) == false {
                return false
            }
            /* Allow pan gesture for closing left or right view
             if (_isLeftViewOpen || _isRightViewOpen) {
             return NO;
             }
             */
            let point: CGPoint = recognizer.location(in: recognizer.view)
            
            if self.panFromLeftBorderWidth > 0.0 && !isLeftViewOpen && velocity > 0.0 && point.x > self.panFromLeftBorderWidth {
                return false
            }
            if self.panFromRightBorderWidth > 0.0 && !isRightViewOpen && velocity < 0.0 && point.x < ((recognizer.view?.bounds.size.width)! - self.panFromRightBorderWidth) {
                return false
            }
        }
        return true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            let velocity: CGFloat = (self.panGestureRecognizer?.velocity(in: self.contentView).x)!
            if delegate?.revealController?(self, panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer: otherGestureRecognizer, direction: velocity > 0.0 ? .right : .left) == true {
                return true
            }
        }
        if gestureRecognizer == self.tapGestureRecognizer {
            if delegate?.revealController?(self, tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer: otherGestureRecognizer) == true {
                return true
            }
        }
        return false
    }

    private func _moveLeftView(toPosition position: CGFloat) {
        if (self.leftViewController != nil) {
            if !self.childViewControllers.contains(self.leftViewController!) {
                var frame: CGRect = self.leftViewController!.view.frame
                if self.isLeftPresentViewOnTop {
                    frame.origin.x = -(self.leftViewRevealWidth)
                    frame.size.width = self.leftViewRevealWidth
                }
                else {
                    frame.origin.x = -(self.leftViewRevealDisplacement)
                    frame.size.width = self.leftViewRevealWidth
                }
                self.leftViewController?.view.frame = frame
                if self.isLeftPresentViewOnTop {
                    self.contentView?.addSubview((self.leftViewController?.view)!)
                }
                else {
                    self.contentView?.insertSubview((self.leftViewController?.view)!, belowSubview: (self.mainViewController?.view)!)
                }
                addChildViewController(self.leftViewController!)
                self.leftViewController?.didMove(toParentViewController: self)
            }
            var leftFrame: CGRect = self.leftViewController!.view.frame
            var mainFrame: CGRect = self.mainViewController!.view.frame
            if position <= 0 {
                hideLeftView(animated: true)
                self.panGestureRecognizer?.state = .cancelled
            }
            else if position < self.leftViewRevealWidth {
                if self.isLeftPresentViewOnTop {
                    leftFrame.origin.x = -(self.leftViewRevealWidth) + position
                }
                else {
                    leftFrame.origin.x = -(self.leftViewRevealDisplacement - (position * self.leftViewRevealDisplacement / self.leftViewRevealWidth))
                    mainFrame.origin.x = position
                    self.mainViewController?.view.frame = mainFrame
                }
                self.leftViewController?.view.frame = leftFrame
            }
            else {
                delegate?.revealController?(self, willShowLeft: self.leftViewController!)
                self.isLeftViewOpen = true
                #if os(iOS)
                    self.tapGestureRecognizer?.cancelsTouchesInView = true
                #endif
                leftFrame.origin.x = 0.0
                leftFrame.size.width = self.leftViewRevealWidth
                if !self.isLeftPresentViewOnTop {
                    mainFrame.origin.x = self.leftViewRevealWidth
                }
                let completion: (() -> Void) = {() -> Void in
                    self.delegate?.revealController?(self, didShowLeft: self.leftViewController!)
                }
                if (floor(NSFoundationVersionNumber) >= 7.0) {
                    self.leftViewController?.view.layoutIfNeeded()
                    UIView.animate(withDuration: leftToggleAnimationDuration, delay: 0.0, usingSpringWithDamping: leftToggleSpringDampingRatio, initialSpringVelocity: leftToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                        self.leftViewController?.view.layoutIfNeeded()
                        self.leftViewController?.view.frame = leftFrame
                        self.mainViewController?.view.frame = mainFrame
                    }, completion: {(_ finished: Bool) -> Void in
                        completion()
                    })
                }
                else {
                    self.leftViewController?.view.layoutIfNeeded()
                    UIView.animate(withDuration: leftToggleAnimationDuration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                        self.leftViewController?.view.layoutIfNeeded()
                        self.leftViewController?.view.frame = leftFrame
                        self.mainViewController?.view.frame = mainFrame
                    }, completion: {(_ finished: Bool) -> Void in
                        completion()
                    })
                }
            }
        }
    }

    private func _moveRightView(toPosition position: CGFloat) {
        if (self.rightViewController != nil) {
            if !self.childViewControllers.contains(self.rightViewController!) {
                var frame: CGRect = self.rightViewController!.view.frame
                if self.isRightPresentViewOnTop {
                    frame.origin.x = view.bounds.size.width
                    frame.size.width = self.rightViewRevealWidth
                }
                else {
                    frame.origin.x = view.bounds.size.width - self.rightViewRevealWidth + self.rightViewRevealDisplacement
                    frame.size.width = self.rightViewRevealWidth
                }
                self.rightViewController?.view.frame = frame
                if self.isRightPresentViewOnTop {
                    self.contentView?.addSubview((rightViewController?.view)!)
                }
                else {
                    self.contentView?.insertSubview((rightViewController?.view)!, belowSubview: (mainViewController?.view)!)
                }
                addChildViewController(self.rightViewController!)
                self.rightViewController?.didMove(toParentViewController: self)
            }
            var rightFrame: CGRect = self.rightViewController!.view.frame
            var mainFrame: CGRect = self.mainViewController!.view.frame
            if position >= 0 {
                hideRightView(animated: true)
                self.panGestureRecognizer?.state = .cancelled
            }
            else if abs(position) < self.rightViewRevealWidth {
                if self.isRightPresentViewOnTop {
                    rightFrame.origin.x = self.view.bounds.size.width - abs(position)
                }
                else {
                    let displacement: CGFloat = self.rightViewRevealDisplacement - (abs(position) * self.rightViewRevealDisplacement / self.rightViewRevealWidth)
                    rightFrame.origin.x = self.view.bounds.size.width - self.rightViewRevealWidth + displacement
                    mainFrame.origin.x = position
                    self.mainViewController?.view.frame = mainFrame
                }
                self.rightViewController?.view.frame = rightFrame
            }
            else {
                delegate?.revealController?(self, willShowRight: self.rightViewController!)
                self.isRightViewOpen = true
                #if os(iOS)
                    self.tapGestureRecognizer?.cancelsTouchesInView = true
                #endif
                rightFrame.origin.x = view.bounds.size.width - self.rightViewRevealWidth
                rightFrame.size.width = self.rightViewRevealWidth
                if !self.isRightPresentViewOnTop {
                    mainFrame.origin.x = -(self.rightViewRevealWidth)
                }
                let completion: (() -> Void) = {() -> Void in
                    self.delegate?.revealController?(self, didShowRight: self.rightViewController!)
                }
                if (floor(NSFoundationVersionNumber) >= 7.0) {
                    self.rightViewController?.view.layoutIfNeeded()
                    UIView.animate(withDuration: self.rightToggleAnimationDuration, delay: 0.0, usingSpringWithDamping: self.rightToggleSpringDampingRatio, initialSpringVelocity: self.rightToggleSpringVelocity, options: .layoutSubviews, animations: {() -> Void in
                        self.rightViewController?.view.layoutIfNeeded()
                        self.rightViewController?.view.frame = rightFrame
                        self.mainViewController?.view.frame = mainFrame
                    }, completion: {(_ finished: Bool) -> Void in
                        completion()
                    })
                }
                else {
                    self.rightViewController?.view.layoutIfNeeded()
                    UIView.animate(withDuration: self.rightToggleAnimationDuration, delay: 0.0, options: .layoutSubviews, animations: {() -> Void in
                        self.rightViewController?.view.layoutIfNeeded()
                        self.rightViewController?.view.frame = rightFrame
                        self.mainViewController?.view.frame = mainFrame
                    }, completion: {(_ finished: Bool) -> Void in
                        completion()
                    })
                }
            }
        }
    }

    // MARK: - UserInteractionEnabling
    
    private func disableUserInteraction() {
        self.contentView?.isUserInteractionEnabled = false
    }
    
    private func restoreUserInteraction() {
        // we use the stored userInteraction state just in case a developer decided to have our view interaction disabled before handle
        self.contentView?.isUserInteractionEnabled = isUserInteractionStore
    }

// MARK: - Presse button Handle (tvOS)
    
#if os(tvOS)
    override open func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item: UIPress in presses {
            if item.type == .menu {
                if !isPressTypeMenuAllowed {
                    super.pressesBegan(presses, with: event)
                    return
                }
                if isLeftViewOpen {
                    super.pressesBegan(presses, with: event)
                }
            }
            else if item.type == .playPause {
                if !isPressTypePlayPauseAllowed {
                    super.pressesBegan(presses, with: event)
                    return
                }
            }
            else {
                super.pressesBegan(presses, with: event)
            }
        }
    }

    override open func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item: UIPress in presses {
            if item.type == .menu {
                if !isPressTypeMenuAllowed {
                    super.pressesEnded(presses, with: event)
                    return
                }
                if isLeftViewOpen {
                    super.pressesEnded(presses, with: event)
                }
                else {
                    revealLeftView()
                }
            }
            else if item.type == .playPause {
                if !isPressTypePlayPauseAllowed {
                    super.pressesEnded(presses, with: event)
                    return
                }
                if isLeftViewOpen {
                    hideLeftView(animated: true)
                }
                else {
                    revealRightView()
                }
            }
            else {
                super.pressesEnded(presses, with: event)
            }
        }
    }

#endif
    
// MARK: - Focus environment protocol (tvOS)
    
#if os(tvOS)
    
    override open var preferredFocusEnvironments: [UIFocusEnvironment] {
        if self.isLeftViewOpen {
            if tvOSLeftPreferredFocusedView != nil {
                return [tvOSLeftPreferredFocusedView!]
            }
            return [leftViewController!.view]
        }
        if self.isRightViewOpen {
            if tvOSRightPreferredFocusedView != nil {
                return [tvOSRightPreferredFocusedView!]
            }
            return [rightViewController!.view]
        }
        if tvOSMainPreferredFocusedView != nil {
            return [tvOSMainPreferredFocusedView!]
        }
        return [];
    }

    override open func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        return super.shouldUpdateFocus(in: context)
    }

    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (tvOSLeftRevealButton != nil && context.nextFocusedView == tvOSLeftRevealButton) {
            tvOSMainPreferredFocusedView = context.previouslyFocusedView
            revealLeftView()
        }
        if (tvOSRightRevealButton != nil && context.nextFocusedView == tvOSRightRevealButton) {
            tvOSMainPreferredFocusedView = context.previouslyFocusedView
            revealRightView()
        }
        super.didUpdateFocus(in: context, with: coordinator)
    }

#endif
    
// MARK: - Gesture Handle
    
#if os(tvOS)
    @objc private func _handleLeftSwipeGesture(_ recognizer: UISwipeGestureRecognizer) {
        if isRightViewOpen {
            hideRightView(animated: true)
        }
    }

    @objc private func _handleRightSwipeGesture(_ recognizer: UISwipeGestureRecognizer) {
        if isLeftViewOpen {
            hideLeftView(animated: true)
        }
    }

#endif
    
    @objc private func _handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        if isLeftViewOpen {
            hideLeftView(animated: true)
        }
        if isRightViewOpen {
            hideRightView(animated: true)
        }
    }

    @objc private func _handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let position: CGFloat = recognizer.translation(in: self.contentView).x
        let velocity: CGFloat = recognizer.velocity(in: self.contentView).x
        switch recognizer.state {
        case .began:
            notifyPanGestureBegan(position)
            if velocity > 0 && self.isLeftViewOpen {
                self.panGestureRecognizer?.state = .cancelled
                return
            }
            if velocity < 0 && self.isRightViewOpen {
                self.panGestureRecognizer?.state = .cancelled
                return
            }
            if velocity > 0 {
                if self.isRightViewOpen {
                    self.isRightViewDragging = true
                }
                else {
                    self.isLeftViewDragging = true
                }
            }
            else if velocity < 0 {
                if self.isLeftViewOpen {
                    self.isLeftViewDragging = true
                }
                else {
                    self.isRightViewDragging = true
                }
            }
            
            if self.isLeftViewDragging {
                self.panBaseLocation = 0.0
                if self.isLeftViewOpen {
                    self.panBaseLocation = self.leftViewRevealWidth
                }
            }
            if self.isRightViewDragging {
                self.panBaseLocation = 0.0
                if self.isRightViewOpen {
                    self.panBaseLocation = -(self.rightViewRevealWidth)
                }
            }
            self.isLeftViewOpen = false
            self.isRightViewOpen = false
            disableUserInteraction()
            if abs(velocity) > self.swipeVelocity {
                if self.isLeftViewDragging {
                    _moveLeftView(toPosition: self.panBaseLocation > 0.0 ? 0.0 : self.leftViewRevealWidth)
                }
                else {
                    if self.isRightViewDragging {
                        _moveRightView(toPosition: self.panBaseLocation < 0.0 ? self.view.bounds.size.width : -(self.rightViewRevealWidth))
                    }
                }
            }
            break
            
        case .changed:
            notifyPanGestureMoved(position)
            if self.isLeftViewOpen || self.isRightViewOpen {
                self.panGestureRecognizer?.state = .cancelled
                break
            }
            if self.isLeftViewDragging {
                let xLocation: CGFloat = self.panBaseLocation + position
                _moveLeftView(toPosition: xLocation)
            }
            else {
                let xLocation: CGFloat = self.panBaseLocation + position
                _moveRightView(toPosition: xLocation)
            }
            break
            
        case .ended:
            if self.isLeftViewOpen || self.isRightViewOpen {
                notifyPanGestureEnded(position)
                break
            }
            let xLocation: CGFloat = self.panBaseLocation + position
            if self.isLeftViewDragging {
                if xLocation > (self.leftViewRevealWidth * 0.50) {
                    _moveLeftView(toPosition: self.leftViewRevealWidth)
                }
                else {
                    hideLeftView(animated: true)
                }
            }
            else {
                if abs(xLocation) > (self.rightViewRevealWidth * 0.50) {
                    _moveRightView(toPosition: -(self.rightViewRevealWidth))
                }
                else {
                    hideRightView(animated: true)
                }
            }
            notifyPanGestureEnded(position)
            break
            
        case .cancelled:
            notifyPanGestureEnded(position)
            break
            
        default:
            break
        }
        
    }

    // MARK: - Gesture Handle Delegate call methods
    
    private func notifyPanGestureBegan(_ position: CGFloat) {
        let velocity: CGFloat = (self.panGestureRecognizer?.velocity(in: self.contentView).x)!
        delegate?.revealControllerPanGestureBegan?(self, direction: velocity > 0.0 ? .right : .left)
    }

    private func notifyPanGestureMoved(_ position: CGFloat) {
        let velocity: CGFloat = (self.panGestureRecognizer?.velocity(in: self.contentView).x)!
        delegate?.revealControllerPanGestureMoved?(self, direction: velocity > 0.0 ? .right : .left)
    }

    private func notifyPanGestureEnded(_ position: CGFloat) {
        self.isLeftViewDragging = false
        self.isRightViewDragging = false
        restoreUserInteraction()
        let velocity: CGFloat = (panGestureRecognizer?.velocity(in: self.contentView).x)!
        delegate?.revealControllerPanGestureEnded?(self, direction: velocity > 0.0 ? .right : .left)
    }

    // MARK: - Adjusts frames
    
    private func adjustsFrameForController(_ sideViewController: UIViewController) -> CGRect {
        let barHeight = navigationBar.sizeThatFits(CGSize(width: CGFloat(100), height: CGFloat(100))).height
        var frame: CGRect = sideViewController.view.frame
        if (floor(NSFoundationVersionNumber) < 7.0) {
            frame.origin.y = barHeight
            frame.size.height = view.bounds.size.height - barHeight
        }
        else {
#if os(iOS)
            let statusBarIsHidden: Bool = UIApplication.shared.statusBarFrame.size.height == 0.0
#else
            let statusBarIsHidden: Bool = true
#endif
            frame.origin.y = barHeight + (statusBarIsHidden ? 0 : 20)
            frame.size.height = view.frame.size.height - barHeight - (statusBarIsHidden ? 0 : 20)
        }
        return frame
    }

    // MARK: - Override rotation
    
    private func viewWillTransitionToSize(_ size: CGSize) {
        
        var frame: CGRect
        
        if self.leftViewController != nil {
            if self.isLeftPresentViewHierarchically {
                frame = adjustsFrameForController(self.leftViewController!)
            }
            else {
                frame = (self.leftViewController?.view.frame)!
                frame.size.height = size.height
            }
            frame.size.width = leftViewRevealWidth
            self.leftViewController?.view.frame = frame
        }
        
        if self.rightViewController != nil {
            if self.isRightPresentViewHierarchically {
                frame = adjustsFrameForController(self.rightViewController!)
            }
            else {
                frame = (self.rightViewController?.view.frame)!
                frame.size.height = size.height
            }
            frame.origin.x = size.width
            if isRightViewOpen {
                frame.origin.x = size.width - rightViewRevealWidth
            }
            frame.size.width = rightViewRevealWidth
            self.rightViewController?.view.frame = frame
        }
    }

    // MARK: - Override rotation

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: {(_ context: UIViewControllerTransitionCoordinatorContext) -> Void in
            self.viewWillTransitionToSize(size)
        }, completion: {(_ context: UIViewControllerTransitionCoordinatorContext) -> Void in
        })
        super.viewWillTransition(to: size, with: coordinator)
    }

    // iOS < 8.0
    /*
    override func shouldAutorotate() -> Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }

    override func willAnimateRotation(toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        viewWillTransition(to: view.bounds.size)
    }
    */
    //

    // MARK: - Helpers
    
    private func tableViewInView(_ view: UIView) -> UITableView? {
        if (view is UITableView) {
            return (view as? UITableView)!
        }
        for subview: UIView in view.subviews {
            if (subview is UITableView) {
                return (subview as? UITableView)!
            }
            if subview.subviews.count > 0 {
                _ = tableViewInView(subview)
            }
        }
        return nil
    }
}

// MARK: - PBRevealViewControllerPanGestureRecognizer

private class PBRevealViewControllerPanGestureRecognizer: UIPanGestureRecognizer {
    private var dragging: Bool = false
    private var beginPoint = CGPoint.zero

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch? = touches.first
        self.beginPoint = (touch?.location(in: view))!
        self.dragging = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesMoved(touches, with: event)
        if self.dragging || state == .failed {
            return
        }
        let kDirectionPanThreshold: CGFloat = 5
        let touch: UITouch? = touches.first
        let nowPoint: CGPoint? = touch?.location(in: view)
        if abs((nowPoint?.x)! - beginPoint.x) > kDirectionPanThreshold {
            self.dragging = true
        }
        else if abs((nowPoint?.y)! - beginPoint.y) > kDirectionPanThreshold {
            self.state = .failed
        }
    }
}

// MARK: - PBContextTransitioningObject

private class PBContextTransitionObject: NSObject, UIViewControllerContextTransitioning {

    internal var containerView: UIView
    internal var presentationStyle: UIModalPresentationStyle = .none
    internal var transitionWasCancelled: Bool = false
    internal var targetTransform: CGAffineTransform = .identity
    internal var isAnimated: Bool = true
    internal var isInteractive: Bool = false

    weak internal var revealController: PBRevealViewController?
    internal var toViewController: UIViewController?
    internal var fromViewController: UIViewController?
    internal var completion: ((_: Void) -> Void)? = nil

    init(revealController: PBRevealViewController, containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController, completion: @escaping (_: Void) -> Void) {
        
        self.revealController = revealController
        self.containerView = containerView
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        self.completion = completion
    
    }
    
    func updateInteractiveTransition(_ percentComplete: CGFloat) {
        // not supported
    }

    func pauseInteractiveTransition() {
        // not supported
    }

    func finishInteractiveTransition() {
        // not supported
    }

    func cancelInteractiveTransition() {
        // not supported
    }

    func completeTransition(_ didComplete: Bool) {
        completion!()
    }

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        if (key == .from) {
            return fromViewController!
        }
        else if (key == .to) {
            return toViewController!
        }
        else {
            return nil
        }
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return nil;
    }

    func initialFrame(for vc: UIViewController) -> CGRect {
        return vc.view.frame
    }

    func finalFrame(for vc: UIViewController) -> CGRect {
        return vc.view.frame
    }
}

// MARK: - PBRevealView Class

private class PBRevealView: UIView {
     weak var revealController: PBRevealViewController?

    init(frame: CGRect, controller revealController: PBRevealViewController) {
        super.init(frame: frame)
        
        self.revealController = revealController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let isInside: Bool = super.point(inside: point, with: event)
        if isInside {
            revealController?.tapGestureRecognizer?.isEnabled = true
            if (revealController?.isLeftViewOpen)! && point.x < (revealController?.leftViewRevealWidth)! {
                revealController?.tapGestureRecognizer?.isEnabled = false
            }
            if (revealController?.isRightViewOpen)! && point.x > (bounds.size.width - (revealController?.rightViewRevealWidth)!) {
                revealController?.tapGestureRecognizer?.isEnabled = false
            }
            return true
        }
        return false
    }
}

// MARK: - UIViewController extension

private extension UIViewController {
    
    // An extension of UIViewController to check if a segue exist (TODO: Apple rejected?).
    func canPerformSegue(id: String) -> Bool {
        let segues = self.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        guard let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id })
        else {
            return false
        }
        return (filtered.count > 0)
    }
    
    // An extension of UIViewController to perform a segue if exist (TODO: Apple rejected?).
    func performSegue(id: String, sender: AnyObject?) {
        if canPerformSegue(id: id) {
            self.performSegue(withIdentifier: id, sender: sender)
        }
    }
}

public extension UIViewController {
    
    // An extension of UIViewController to let childViewControllers easily access their parent PBRevealViewController.
    func revealViewController() -> PBRevealViewController? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is PBRevealViewController {
            return viewController! as? PBRevealViewController
        }
        while (!(viewController is PBRevealViewController) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is PBRevealViewController {
            return viewController as? PBRevealViewController
        }
        return nil
    }
    
}
