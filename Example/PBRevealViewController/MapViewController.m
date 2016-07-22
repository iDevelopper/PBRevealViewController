//
//  MapViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 06/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MapViewController.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButton;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _revealButton.target = self.revealViewController;
    _revealButton.action = @selector(revealLeftView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
