//
//  SecondViewController.m
//  PBRevealTVOS
//
//  Created by Patrick BODET on 12/02/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

#import "RevealViewController.h"
#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIButton *imageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_imageView setBackgroundImage:_image forState:UIControlStateNormal];
    self.revealViewController.tvOSMainPreferredFocusedView = _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [_imageView setBackgroundImage:_image forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
