//
//  MenuTableViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 30/06/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "MenuTableViewController.h"

@interface MenuTableViewController ()

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
    return 3;
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
            cell.textLabel.text = @"Map";
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
    switch (indexPath.row) {
        case 0:
            controller = [storyBoard instantiateViewControllerWithIdentifier:@"Main"];
            break;
            
        case 1:
            controller = [storyBoard instantiateViewControllerWithIdentifier:@"Second"];
            break;
            
        case 2:
        {
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[storyBoard instantiateViewControllerWithIdentifier:@"Map"]];
            controller = nc;
        }
            break;
            
        default:
            break;
    }
    [self.revealViewController pushMainViewController:controller animated:YES];
}

@end
