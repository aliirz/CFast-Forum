//
//  CFProfileViewController.h
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *topLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;

//@property (strong, nonatomic) IBOutlet FUIButton *updatePasswordBtn;

@property (strong, nonatomic) IBOutlet FUIButton *updateDetailsBtn;
- (IBAction)updateDetails:(id)sender;
@property (strong, nonatomic) IBOutlet FUIButton *logoutBtn;
- (IBAction)logout:(id)sender;

//- (IBAction)showPWChangeView:(id)sender;

@end
