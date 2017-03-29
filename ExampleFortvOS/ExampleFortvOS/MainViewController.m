//
//  MainViewController.m
//  PBRevealTVOS
//
//  Created by Patrick BODET on 11/02/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

#import "RevealViewController.h"
#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *preferredFocusView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.revealViewController.tvOSMainPreferredFocusedView = _preferredFocusView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonsAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    NSString *message = [NSString stringWithFormat:@"%@ was tapped!", title];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.revealViewController.tvOSMainPreferredFocusedView = sender;
    }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
