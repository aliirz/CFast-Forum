//
//  CFHomeViewController.h
//  CFast
//
//  Created by Ali Raza on 14/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFHomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet FUIButton *forumButton;
@property (strong, nonatomic) IBOutlet FUIButton *settingsButton;
- (IBAction)shoForum:(id)sender;

- (IBAction)showProfile:(id)sender;

@end
