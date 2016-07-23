//
//  FrontTableViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 23/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "FrontTableViewController.h"
#import "PushViewController.h"

@interface FrontTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;

@end

@implementation FrontTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftButton.target = self.revealViewController;
    _leftButton.action = @selector(revealLeftView);
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
    cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PushViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"Push"];
    vc.text = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
