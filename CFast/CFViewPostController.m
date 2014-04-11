//
//  CFViewPostController.m
//  CFast
//
//  Created by Ali Raza on 08/04/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFViewPostController.h"
#import "CFReplyViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "CFAttachmentViewController.h"

@interface CFViewPostController ()

@end

@implementation CFViewPostController

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
    NSLog(@"%@",self.message);
    self.textView.text = [self.message objectForKey:@"MESSAGE"];
    self.postedByLabel.text = [NSString stringWithFormat:@"By: %@",[self.message objectForKey:@"NAME"]];
    NSTimeInterval seconds = [[self.message objectForKey:@"DATETIME"] doubleValue];
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    self.postedOnLabel.text = [epochNSDate formattedDateWithFormat:@"dd/MM/YY HH:mm"];
    
    
    self.attachmentsBtn.buttonColor = [UIColor carrotColor];
    self.attachmentsBtn.shadowColor = [UIColor pumpkinColor];
    self.attachmentsBtn.shadowHeight = 3.0f;
    self.attachmentsBtn.cornerRadius = 6.0f;
    self.attachmentsBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.attachmentsBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.attachmentsBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.replyBtn.buttonColor = [UIColor carrotColor];
    self.replyBtn.shadowColor = [UIColor pumpkinColor];
    self.replyBtn.shadowHeight = 3.0f;
    self.replyBtn.cornerRadius = 6.0f;
    self.replyBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.replyBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.replyBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.textView.textColor = [UIColor pumpkinColor];
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.postedOnLabel.textColor = [UIColor pumpkinColor];
    self.postedByLabel.textColor = [UIColor pumpkinColor];
    
//    self.postedOnLabel.text = [self.message objectForKey:@"DATETIME"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)replyMsg:(id)sender {
    CFReplyViewController *replyVC = [[CFReplyViewController alloc]init];
    replyVC.replyTo = self.message;
    [self.navigationController pushViewController:replyVC animated:YES];
}

- (IBAction)viewAttachments:(id)sender {
    
    
    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:[UIColor cloudsColor]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.labelText = NSLocalizedString(@"Please Wait...", @"Please Wait...");
    
    [spinner startAnimating];

    
    [[LRResty client] get:[NSString stringWithFormat:@"http://cfast-api.fireflycommunicator.com/api/attachment/%@",[self.message objectForKey:@"ID"]] withBlock:^(LRRestyResponse *r)
     {
         NSLog(@"%@",[r asString]);
         NSError *theError = nil;
         NSData *responseData = [[r asString] dataUsingEncoding:NSUTF8StringEncoding];
         NSArray *allAttachments = [[CJSONDeserializer deserializer] deserializeAsArray:responseData error:&theError];
         if([allAttachments count] == 0)
         {
             [spinner stopAnimating];
             [hud hide:YES];
             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"This message has no attachments." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [alertView show];
         }
         else
         {
         
             CFAttachmentViewController *attachmentsVC = [[CFAttachmentViewController alloc]init];
//         thread.postID = [topic objectForKey:@"ID"];
             attachmentsVC.attachments = allAttachments;
             [spinner stopAnimating];
             [hud hide:YES];
             [self.navigationController pushViewController:attachmentsVC animated:YES];
         }
         
     }
     ];
}
@end
