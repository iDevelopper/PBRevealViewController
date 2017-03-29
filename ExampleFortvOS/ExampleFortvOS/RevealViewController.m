//
//  RevealViewController.m
//  PBRevealTVOS
//
//  Created by Patrick BODET on 12/02/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

#import "RevealViewController.h"

@interface RevealViewController () <PBRevealViewControllerDelegate>

@property (strong, nonatomic) UIFocusGuide *focusGuide;
@property (strong, nonatomic) UIView *focusView;

@end

@implementation RevealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.rightViewRevealWidth = 302.;
    
    [self tvOSLeftRevealButton];
    [self tvOSRightRevealButton];
    
    [self tvOSRightSwipeGestureRecognizer];
    [self tvOSLeftSwipeGestureRecognizer];
    
    self.isPressTypeMenuAllowed = YES;
    self.isPressTypePlayPauseAllowed = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<id<UIFocusEnvironment>> *)preferredFocusEnvironments {
    return [super preferredFocusEnvironments];
}

#pragma mark - PBRevealViewController delegate

- (void)revealController:(PBRevealViewController *)revealController didShowLeftViewController:(UIViewController *)controller {
    NSLog(@"didShowLeftViewController");
}

- (void)revealController:(PBRevealViewController *)revealController didHideLeftViewController:(UIViewController *)controller {
    NSLog(@"didHideLeftViewController");    
}

- (void)revealController:(PBRevealViewController *)revealController didShowRightViewController:(UIViewController *)controller {
    NSLog(@"didShowRightViewController");
}

- (void)revealController:(PBRevealViewController *)revealController didHideRightViewController:(UIViewController *)controller {
    NSLog(@"didHideRightViewController");
}

@end
