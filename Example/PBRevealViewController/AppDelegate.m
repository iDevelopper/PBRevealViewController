//
//  AppDelegate.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 29/06/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Without storyboard
    /*
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *leftController = [sb instantiateViewControllerWithIdentifier:@"pb_menu"];
    UIViewController *mainController = [sb instantiateViewControllerWithIdentifier:@"pb_main"];
    UIViewController *rightController = [sb instantiateViewControllerWithIdentifier:@"pb_right"];
    
    PBRevealViewController *revealController = [[PBRevealViewController alloc]initWithLeftViewController:leftController mainViewController:mainController rightViewController:rightController];
    
    revealController.leftViewRevealWidth = 150;
    
    self.window.rootViewController = revealController;
    */    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - PBRevealViewController Delegate

- (BOOL)revealController:(PBRevealViewController *)revealController shouldShowLeftViewController:(UIViewController *)controller
{
    NSLog(@"shouldShowLeftViewController: %@", controller);
    return YES;
}

- (void)revealController:(PBRevealViewController *)revealController willShowLeftViewController:(UIViewController *)controller
{
    NSLog(@"willShowLeftViewController: %@", controller);
}

- (void)revealController:(PBRevealViewController *)revealController didShowLeftViewController:(UIViewController *)controller
{
    NSLog(@"didShowLeftViewController: %@", controller);
}

- (BOOL)revealController:(PBRevealViewController *)revealController shouldShowRightViewController:(UIViewController *)controller
{
    NSLog(@"shouldShowRightViewController: %@", controller);
    return YES;
}

- (void)revealController:(PBRevealViewController *)revealController willShowRightViewController:(UIViewController *)controller
{
    NSLog(@"willShowRightViewController: %@", controller);
}

- (void)revealController:(PBRevealViewController *)revealController didShowRightViewController:(UIViewController *)controller
{
    NSLog(@"didShowRightViewController: %@", controller);
}

- (BOOL)revealControllerTapGestureShouldBegin:(PBRevealViewController *)revealController
{
    NSLog(@"revealControllerTapGestureShouldBegin");
    return YES;
}

- (BOOL)revealControllerPanGestureShouldBegin:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction
{
    NSLog(@"revealControllerPanGestureShouldBegin");
    if ([revealController.mainViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)revealController.mainViewController;
        if ([nc.topViewController isKindOfClass:[MapViewController class]]) {
            if (direction ==  PBRevealControllerPanDirectionRight) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)revealControllerPanGestureBegan:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction
{
    NSLog(@"revealControllerPanGestureBegan");
}

- (void)revealControllerPanGestureMoved:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction
{
    NSLog(@"revealControllerPanGestureMoved");
}

- (void)revealControllerPanGestureEnded:(PBRevealViewController *)revealController direction:(PBRevealControllerPanDirection)direction
{
    NSLog(@"revealControllerPanGestureEnded");
}

- (void)revealController:(PBRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(PBRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog(@"willAddViewController");
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)viewController;
        if ([nc.topViewController isKindOfClass:[MapViewController class]]) {
            if (operation == PBRevealControllerOperationPushMainControllerFromLeft) {
                CGRect frame = viewController.view.frame;
                frame.origin.x = revealController.leftViewRevealWidth;
                viewController.view.frame = frame;
            }
        }
    }
}

- (void)revealController:(PBRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(PBRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog(@"didAddViewController");
}

- (BOOL)revealController:(PBRevealViewController *)revealController tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer");
    return NO;
}

- (BOOL)revealController:(PBRevealViewController *)revealController panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer");
    return NO;
}

- (void (^)(void))revealController:(PBRevealViewController *)revealController animationBlockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSLog(@"animationBlockForOperation");

    // See willAddViewController above
    
    void (^animation)();
    
    if ([toViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)toViewController;
        if ([nc.topViewController isKindOfClass:[MapViewController class]]) {
            if (operation == PBRevealControllerOperationPushMainControllerFromLeft) {
                CGRect mainFrame = toViewController.view.frame;
                mainFrame.origin.x = 0.;
                CGRect leftFrame = revealController.leftViewController.view.frame;
                leftFrame.origin.x = -(revealController.leftViewRevealWidth);
                leftFrame.size.width = revealController.leftViewRevealWidth;
                /*
                void (^animation)() = ^{
                    toViewController.view.frame = mainFrame;
                    revealController.leftViewController.view.frame = leftFrame;
                };
                */
                animation = ^{
                    toViewController.view.frame = mainFrame;
                    revealController.leftViewController.view.frame = leftFrame;
                };
                
                return animation;
            }
        }
        else {
            toViewController.view.alpha = 0.6;
            animation = ^{ toViewController.view.alpha = 1.; };
            return animation;
        }
    }
    
    return nil;
}

- (void (^)(void))revealController:(PBRevealViewController *)revealController completionBlockForOperation:(PBRevealControllerOperation)operation fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSLog(@"completionBlockForOperation");
    void (^completion)() = ^{ NSLog(@"Completion"); };
    return completion;
}

@end
