//
//  RightMenuTableViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 02/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "RightMenuTableViewController.h"
#import "PresentViewController.h"
#import "PushViewController.h"

@interface RightMenuTableViewController ()

@end

@implementation RightMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // No separator where there aren't cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = tableView.backgroundColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (indexPath.row) {
        case 0:
        {
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeCrossDissolve;
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Third"]];
            controller = nc;
        }
            break;
            
        case 1:
        {
//            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypePushSideView;
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeSpring;
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Fourth"]];
            controller = nc;
        }
            break;
            
        case 2:
        {
            PresentViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"Present"];
            vc.text = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
            controller = nc;
        }
            break;
            
        case 3:
        {
            PushViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"Push"];
            vc.text = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
            controller = vc;
        }
            break;
            
        default:
            break;
    }
    switch (indexPath.row) {
        case 0:
        case 1:
            [self.revealViewController pushMainViewController:controller animated:YES];
            self.revealViewController.toggleAnimationType = PBRevealToggleAnimationTypeNone;
            break;
        
        case 2:
        {
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
            
        case 3:
        {
            
            [self.revealViewController hideRightViewAnimated:NO];
            UINavigationController *nc = (UINavigationController *)self.revealViewController.mainViewController;
            [nc pushViewController:controller animated:YES];
            
            // OR
            
            /* If iOS >= 7.0
            self.revealViewController.rightViewRevealWidth = [UIScreen mainScreen].bounds.size.width;
            self.navigationController.delegate = self;
            [self.navigationController pushViewController:controller animated:YES];
            */
        }
            break;
            
        default:
            break;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        toVC.revealViewController.rightViewRevealWidth = 160.;
    }
    return nil;
}

@end
