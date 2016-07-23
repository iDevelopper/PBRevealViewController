//
//  MenuTableViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 30/06/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuTableViewController.h"
#import "MainViewController.h"
#import "SecondViewController.h"
#import "MapViewController.h"

@interface MenuTableViewController ()

@property (strong, nonatomic) SecondViewController *secondViewController;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 1000, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = tableView.backgroundColor;
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    cell.textLabel.textColor = [UIColor whiteColor];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Main";
            break;
            
        case 1:
            cell.textLabel.text = @"Second";
            break;
            
        case 2:
            cell.textLabel.text = @"Third";
            break;
            
        case 3:
            cell.textLabel.text = @"Fourth";
            break;
            
        case 4:
            cell.textLabel.text = @"Map";
            break;
            
        case 5:
            cell.textLabel.text = @"Table";
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    switch (indexPath.row) {
        case 0:
        {
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeNone;
            controller = appDelegate.mainController;
        }
            break;
            
        case 1:
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeCrossDissolve;
            if (!_secondViewController) {
                self.secondViewController = [storyBoard instantiateViewControllerWithIdentifier:@"Second"];
            }
            controller = _secondViewController;
            break;
            
        case 2:
        {
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeCustom;
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Third"]];
            controller = nc;
        }
            break;
            
        case 3:
        {
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypePushSideView;
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Fourth"]];
            controller = nc;
        }
            break;
            
        case 4:
        {
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeCustom;
            controller = appDelegate.mapController;
        }
            break;
            
        case 5:
        {
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypePushSideView;
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Table"]];
            controller = nc;
        }
            break;
            
        default:
            break;
    }
    [self.revealViewController pushMainViewController:controller animated:YES];
    self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeNone;
}

@end
