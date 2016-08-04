//
//  MainViewController.m
//  TestPBReveal
//
//  Created by Patrick BODET on 28/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "PBRevealViewController.h"
#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _leftButton.target = self.revealViewController;
    _leftButton.action = @selector(revealLeftView);
    
    _rightButton.target = self.revealViewController;
    _rightButton.action = @selector(revealRightView);

    self.revealViewController.leftPresentViewHierarchically = YES;
    self.revealViewController.rightPresentViewHierarchically = YES;
    
    self.revealViewController.leftToggleAnimationDuration = 0.8;
    self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeSpring;

    // Set a random -not too dark- background color.
    CGFloat r = 0.001f*(250+arc4random_uniform(750));
    CGFloat g = 0.001f*(250+arc4random_uniform(750));
    CGFloat b = 0.001f*(250+arc4random_uniform(750));
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)replaceMe:(UIButton *)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Main"]];
    [self.revealViewController setMainViewController:nc animated:YES];
}

@end
