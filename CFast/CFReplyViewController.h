//
//  CFReplyViewController.h
//  CFast
//
//  Created by Ali Raza on 19/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFReplyViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *replyTextView;
- (IBAction)reply:(id)sender;
@property (nonatomic, strong) NSDictionary *replyTo;
@property (strong, nonatomic) IBOutlet FUIButton *replyBtn;

@end
