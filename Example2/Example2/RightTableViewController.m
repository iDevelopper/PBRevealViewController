//
//  RightTableViewController.m
//  TestPBReveal
//
//  Created by Patrick BODET on 28/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "RightTableViewController.h"
#import "MainViewController.h"

@interface RightTableViewController ()

@end

@implementation RightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"RightToMain"]) {
        UINavigationController *nc = segue.destinationViewController;
        MainViewController *vc = (MainViewController *)nc.topViewController;
        UITableViewCell *cell = (UITableViewCell *)sender;
        vc.title = cell.textLabel.text;
    }
}

@end
