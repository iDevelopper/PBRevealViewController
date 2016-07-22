//
//  AppDelegate.h
//  PBRevealViewController
//
///  Created by Patrick BODET on 29/06/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, PBRevealViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *mainController;
@property (strong, nonatomic) UIViewController *mapController;

@end

