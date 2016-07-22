//
//  PushViewController.m
//  PBRevealViewController
//
//  Created by Patrick BODET on 21/07/2016.
//  Copyright © 2016 iDevelopper. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label.text = _text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
