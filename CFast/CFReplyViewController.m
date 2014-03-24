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
    NSMutableDictionary *newReply = [[NSMutableDictionary alloc]initWithDictionary:self.replyTo];
    [newReply setValue:@"0" forKey:@"ID"];
    [newReply setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"] forKey:@"USERNAME"];
    [newReply setValue:self.replyTextView.text forKey:@"MESSAGE"];
    NSLog(@"%@",newReply);
}
@end
