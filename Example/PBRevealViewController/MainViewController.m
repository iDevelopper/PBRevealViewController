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
     }
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    appDelegate.mainController = self.navigationController;
    
    appDelegate.mapController = [storyBoard instantiateViewControllerWithIdentifier:@"Map"];
        
    _leftButton.target = self.revealViewController;
    _leftButton.action = @selector(revealLeftView);
    
    _rightButton.target = self.revealViewController;
    _rightButton.action = @selector(revealRightView);

    self.revealViewController.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.revealViewController.leftViewRevealWidth = 160.;
    self.revealViewController.replaceViewAnimationDuration = 0.5;
    self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)resizeLeftView:(id)sender {
    if (self.revealViewController.leftViewRevealWidth == 160.) {
        self.revealViewController.leftViewRevealWidth = 300.;
    }
    else {
        self.revealViewController.leftViewRevealWidth = 160.;
    }
}

- (IBAction)replaceLeftView:(UIButton *)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = (UINavigationController *)self.revealViewController.leftViewController;
    if ([nc.topViewController isKindOfClass:[MenuTableViewController class]]) {
        [self.revealViewController setLeftViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Left2"] animated:YES];
    }
    else {
        [self.revealViewController setLeftViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Left"] animated:YES];
    }
}

- (IBAction)replaceMainView:(UIButton *)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *vc = appDelegate.mapController;
    [self.revealViewController setMainViewController:vc animated:YES];
}

- (IBAction)replaceRightView:(UIButton *)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = (UINavigationController *)self.revealViewController.rightViewController;
    if ([nc.topViewController isKindOfClass:[RightMenuTableViewController class]]) {
        [self.revealViewController setRightViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Left2"] animated:YES];
    }
    else {
        [self.revealViewController setRightViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Right"] animated:YES];
    }
}

- (IBAction)resizeRightView:(id)sender {
    if (self.revealViewController.rightViewRevealWidth == 160.) {
        self.revealViewController.rightViewRevealWidth = 300.;
    }
    else {
        self.revealViewController.rightViewRevealWidth = 160.;
    }
}

@end
