//
//  CFPasswordViewController.m
//  CFast
//
//  Created by Ali Raza on 23/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFPasswordViewController.h"

@interface CFPasswordViewController ()

@end

@implementation CFPasswordViewController

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
    self.passwordChangeBtn.buttonColor = [UIColor carrotColor];
    self.passwordChangeBtn.shadowColor = [UIColor pumpkinColor];
    self.passwordChangeBtn.shadowHeight = 3.0f;
    self.passwordChangeBtn.cornerRadius = 6.0f;
    self.passwordChangeBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.passwordChangeBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.passwordChangeBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePsswd:(id)sender {
}
@end
