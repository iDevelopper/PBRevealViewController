//
//  PresentViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 22/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label.text = _text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
