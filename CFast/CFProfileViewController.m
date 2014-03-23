//
//  CFProfileViewController.m
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFProfileViewController.h"

@interface CFProfileViewController ()

@end

@implementation CFProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.updateDetailsBtn.buttonColor = [UIColor carrotColor];
    self.updateDetailsBtn.shadowColor = [UIColor pumpkinColor];
    self.updateDetailsBtn.shadowHeight = 3.0f;
    self.updateDetailsBtn.cornerRadius = 6.0f;
    self.updateDetailsBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.updateDetailsBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.updateDetailsBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.updatePasswordBtn.buttonColor = [UIColor carrotColor];
    self.updatePasswordBtn.shadowColor = [UIColor pumpkinColor];
    self.updatePasswordBtn.shadowHeight = 3.0f;
    self.updatePasswordBtn.cornerRadius = 6.0f;
    self.updatePasswordBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.updatePasswordBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.updatePasswordBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
