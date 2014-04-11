//
//  CFViewPostController.h
//  CFast
//
//  Created by Ali Raza on 08/04/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFViewPostController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *postedByLabel;
@property (strong, nonatomic) IBOutlet UILabel *postedOnLabel;
@property (strong, nonatomic) IBOutlet FUIButton *attachmentsBtn;
@property (strong, nonatomic) IBOutlet FUIButton *replyBtn;

@property (nonatomic, strong) NSDictionary *message;
- (IBAction)replyMsg:(id)sender;
- (IBAction)viewAttachments:(id)sender;

@end
