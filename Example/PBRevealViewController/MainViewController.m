//
//  MainViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 30/06/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MenuTableViewController.h"
#import "MenuTableViewController2.h"
#import "RightMenuTableViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;

@end

@implementation MainViewController

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftButton.target = self.revealViewController;
    _leftButton.action = @selector(revealLeftView);
    
    _rightButton.target = self.revealViewController;
    _rightButton.action = @selector(revealRightView);

    self.revealViewController.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.revealViewController.leftViewRevealWidth = 160.;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Actions

- (IBAction)replaceLeftMenu:(UIButton *)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = (UINavigationController *)self.revealViewController.leftViewController;
    if ([nc.topViewController isKindOfClass:[MenuTableViewController class]]) {
        [self.revealViewController setLeftViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Left2"] animated:YES];
    }
    else {
        [self.revealViewController setLeftViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Left"] animated:YES];
    }
}

- (IBAction)replaceRightMenu:(UIButton *)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = (UINavigationController *)self.revealViewController.rightViewController;
    if ([nc.topViewController isKindOfClass:[RightMenuTableViewController class]]) {
        [self.revealViewController setRightViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Left2"] animated:YES];
    }
    else {
        [self.revealViewController setRightViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Right"] animated:YES];
    }
}

- (IBAction)replaceMainView:(UIButton *)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Map"]];
    [self.revealViewController setMainViewController:nc animated:YES];
}

@end
