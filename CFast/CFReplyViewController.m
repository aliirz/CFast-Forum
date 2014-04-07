//
//  CFReplyViewController.m
//  CFast
//
//  Created by Ali Raza on 19/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFReplyViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@interface CFReplyViewController ()

@end

@implementation CFReplyViewController

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
    self.replyBtn.buttonColor = [UIColor carrotColor];
    self.replyBtn.shadowColor = [UIColor pumpkinColor];
    self.replyBtn.shadowHeight = 3.0f;
    self.replyBtn.cornerRadius = 6.0f;
    self.replyBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.replyBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.replyBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.title = @"Compose Reply";
    self.view.backgroundColor = [UIColor cloudsColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reply:(id)sender {
    
    NSMutableDictionary *newReply = [[NSMutableDictionary alloc]init];
    [newReply setObject:@"0" forKey:@"ID"];
    [newReply setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"] forKey:@"NAME"];
    [newReply setObject:self.replyTextView.text forKey:@"MESSAGE"];
    [newReply setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"] forKey:@"USERID"];
    [newReply setObject:[self.replyTo objectForKey:@"THREAD"] forKey:@"THREAD"];
    [newReply setObject:[self.replyTo objectForKey:@"CATID"] forKey:@"CATID"];
    
    
    NSData *jsonData = [[CJSONSerializer serializer] serializeObject:newReply error:nil];
    
    NSDictionary *requestHeaders = [NSDictionary
                                    dictionaryWithObject:@"application/json" forKey:@"Content-Type"];

    
    [[LRResty client] post:@"http://cfast-api.fireflycommunicator.com/api/conversation" payload:jsonData headers:requestHeaders withBlock:^(LRRestyResponse *response){
        NSString *msg = [response asString];
        //            NSLog(@"%@",msg);
//        NSData *responseData = [msg dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *theError = nil;
//        NSDictionary *responseDictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseData error:&theError];
//        //        NSDictionary *firstDict = [responseArray objectAtIndex:0];      //to get the user and pass and too nsuerdefaults.
        if([msg isEqual:@"\"Comment Inserted\""])
        {
//            self.navigationController po
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Could not post this reply." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        //save the details in nsuserdefaults
        
    }];
    
    NSLog(@"%@",newReply);
}
@end
