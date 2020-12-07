# CHANGELOG

## 1.3.4

#### SPM Support.

## 1.3.3

#### SPM Support.

## 1.3.2

#### Fix some issues when used with transformed views.
#### Update to recommanded settings.

## 1.3.1

#### Fix an issue when panFromLeftBorderWidth and panFromRightBorderWidth properties are used.

## 1.3.0

#### iOS 12 compatibility.

## 1.2.9

#### Update targets version to Swift 4.0.

## 1.2.8

#### Fix [issue 34](https://github.com/iDevelopper/PBRevealViewController/issues/34). Add Main/Left/Right View Controller to parentViewController at first call of setXXXXViewController, if initWithLeftViewController:mainViewController:rightViewController: not used.

## 1.2.7

#### Fix device rotation for ObjC Library and iOS < 8.0.

## 1.2.6

#### Swift 4 ans iOS 11 compatibility. Fix some warnings.

## 1.2.5

#### Swift 4 ans iOS 11 compatibility.

## 1.2.4

#### Fix [Issue 32](https://github.com/iDevelopper/PBRevealViewController/issues/32).

## 1.2.3

#### Add Swift 3 version of the library.

## 1.2.2

#### Add some properties for pan gesture.

```
/**
*  The default border width allowing pan gesture from left. If > 0.0, this is the acceptable starting width for the gesture.
*/
@property (nonatomic) CGFloat panFromLeftBorderWidth;

/**
*  The default border width allowing pan gesture from right. If > 0.0, this is the acceptable starting width for the gesture.
*/
@property (nonatomic) CGFloat panFromRightBorderWidth;
```

## 1.2.1

#### tvOS support.

## 1.1.3

#### Allow pan gesture to close left or right view.
#### Change the visual effect when the left or right view is revealed.
#### Thanks to Alain L. for his suggestions for improvement.

## 1.1.2

#### Fix a bug when pan gesture is used first.

## 1.1.1

#### Bug fixes. Add child view controllers (left, main, right) to revealViewController early.

## 1.1.0

#### Compatibility fixes for Xcode 8, iOS 10 and Swift 3.

## 1.0.6

#### Compatibility fixes for iOS < 8.0 and >= 6.0.

## 1.0.5

#### Allow tap gesture recognizer to be enabled on main view when userInteractionEnabled is false.

## 1.0.4

#### Update README.md

Add some credit to [Joan Lluch](joan.lluch@sweetwilliamsl.com) for her class [SWRevealViewController](https://github.com/John-Lluch/SWRevealViewController).

## 1.0.3

#### Add some properties:

```
/**
*  Defines the left view's blur effect style, default is PBRevealBlurEffectStyleNone.
*/
@property (nonatomic) PBRevealBlurEffectStyle leftViewBlurEffectStyle;

/**
*  Defines the right view's blur effect style, default is PBRevealBlurEffectStyleNone.
*/
@property (nonatomic) PBRevealBlurEffectStyle rightViewBlurEffectStyle;
```
##### Fixe a bug when PBRevealToggleAnimationTypeSpring or PBRevealToggleAnimationPushSideView animation is used when the side view is not presented on top

## 1.0.2

#### Add some delegate methods:

```
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
```

## 1.0.1

#### Bug fixe when PBRevealViewController is embedded in a navigation controller.

## 1.0.0

#### Add a new delegate method for asking a custom transition animations controller while replacing/pushing child view controllers. If implemented, it will be fired in response to calls setXXXViewController or pushXXXViewController child view controller.

```
- (id <UIViewControllerAnimatedTransitioning>)revealController:(PBRevealViewController *)revealController animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController forOperation:(PBRevealControllerOperation)operation;
```

#### Update Example4Swift with some custom animations.

## 0.4.0

#### PBRevealViewController now can present the side views (left/right) below or above (default) the main view.

For this, some properties have been added:

If NO (default is YES) the left view controller will be presented below the main view controller.

```
@property (nonatomic) BOOL              leftPresentViewOnTop;
```

Defines how much displacement is applied to the left view when animating or dragging the main view, default is 40.0f.

```
@property (nonatomic) CGFloat           leftViewRevealDisplacement;
```
If NO (default is YES) the right view controller will be presented below the main view controller.

```
@property (nonatomic) BOOL              rightPresentViewOnTop;
```

Defines how much displacement is applied to the right view when animating or dragging the main view, default is 40.0f.

```
@property (nonatomic) CGFloat           rightViewRevealDisplacement;
```

Defines the radius of the main view's shadow, default is 5.0f.

```
@property (nonatomic) CGFloat           mainViewShadowRadius;
```

Defines the main view's shadow offset, default is {0.0f,5.0f}.

```
@property (nonatomic) CGSize            mainViewShadowOffset;
```

Defines the main view's shadow opacity, default is 1.0f.

```
@property (nonatomic) CGFloat           mainViewShadowOpacity;
```

Defines the main view's shadow color, default is blackColor

```
@property (nonatomic) UIColor           *mainViewShadowColor;
```

#### Add an example written in Swift.

## 0.3.8

* Add an example written in swift showing all animations plus a simple custom one (see AppDelegate).
* Minor changes in behavior. For animations toViewController is added below fromViewController instead below side view controller.

## 0.3.7

* Git update.
* Bug fixes.

## 0.3.6

* Git update and add a example.
* Bug fixes.

## 0.3.5

* Git update

## 0.3.4

* Add a toggle animation type: PBRevealToggleAnimationTypeSpring.

A transition that the side view move a little to right or left by the value of leftViewRevealOverdraw or rightViewRevealOverdraw before the main view push the left/right view until it is hidden.

## 0.3.3

* Bug fixes when resizing left/right view when leftPresentViewHierarchically and/or rightPresentViewHierarchically are set to YES. Rview handling of rotations.

## 0.3.2

* Bug fixes

* Add some properties:

If YES (default is NO) the left view controller will be ofsseted vertically by the height of a navigation bar plus the height of status bar.

```
@property (nonatomic) BOOL              leftPresentViewHierarchically;
```

If YES (default is NO) the right view controller will be ofsseted vertically by the height of a navigation bar plus the height of status bar.

```
@property (nonatomic) BOOL              rightPresentViewHierarchically;
```

## 0.3.1

Add documentation

## 0.3.0

The fisrt stable version.
