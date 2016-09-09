//
//  MenuTableViewController2.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 03/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuTableViewController2.h"
#import "MenuTableViewController.h"

@interface MenuTableViewController2 ()

@end

@implementation MenuTableViewController2

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
    return 2;
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    switch (indexPath.row) {
        case 0:
        {
            controller = appDelegate.mainController;
        }
            break;
            
        case 1:
            controller = [storyBoard instantiateViewControllerWithIdentifier:@"Second"];
            break;
            
        default:
            break;
    }
    [self.revealViewController setMainViewController:controller animated:YES];
}

@end
