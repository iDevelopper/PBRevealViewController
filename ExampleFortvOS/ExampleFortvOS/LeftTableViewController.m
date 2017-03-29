//
//  LeftTableViewController.m
//  PBRevealTVOS
//
//  Created by Patrick BODET on 11/02/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

#import "PBRevealViewController.h"
#import "LeftTableViewController.h"
#import "MainViewController.h"
#import "SecondViewController.h"

@interface LeftTableViewController ()

@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) NSArray *images;

@end

@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.remembersLastFocusedIndexPath = YES;
    
    self.controllers = @[@"MainViewController", @"SecondViewController", @"SecondViewController", @"SecondViewController", @"SecondViewController"];
    self.images = @[@"", @"image-1", @"image-2", @"image-3", @"image-4"];
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
    return _controllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
    
    UIViewController *controller = nil;
    controller = [self.storyboard instantiateViewControllerWithIdentifier:_controllers[indexPath.row]];
    
    switch (indexPath.row) {
        case 0:
            break;
            
        default:
            ((SecondViewController *)controller).image = [UIImage imageNamed:_images[indexPath.row]];
            break;
    }
    [self.revealViewController pushMainViewController:controller animated:YES];
}

@end
