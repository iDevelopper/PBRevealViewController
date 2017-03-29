//
//  RightViewController.m
//  PBRevealTVOS
//
//  Created by Patrick BODET on 15/02/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

#import "RevealViewController.h"
#import "SecondViewController.h"
#import "RightViewController.h"

@interface RightViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsCollection;

@property (strong, nonatomic) SecondViewController *controller;
@property (strong, nonatomic) UIButton *currentButton;
//@property (strong, nonatomic) UIView *preferredPreviousView;

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.preferredPreviousView = self.revealViewController.tvOSPreferredFocusedView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    self.revealViewController.tvOSPreferredFocusedView = _preferredPreviousView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray<id<UIFocusEnvironment>> *)preferredFocusEnvironments {
    if (_currentButton) {
        return @[_currentButton];
    }
    return nil;
}


- (IBAction)buttonsAction:(UIButton *)sender {
    _controller.image = sender.currentBackgroundImage;
    [self.revealViewController pushMainViewController:_controller animated:YES];
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    NSLog(@"Right view - didUpdateFocusInContext");
    
    //[super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    UIButton *button = (UIButton *)context.nextFocusedView;
    if ([_buttonsCollection containsObject:button]) {
        self.currentButton = button;
        self.revealViewController.tvOSRightPreferredFocusedView = button;
        _controller.image = button.currentBackgroundImage;
        [self.revealViewController setMainViewController:_controller animated:YES];
    }
}

@end
