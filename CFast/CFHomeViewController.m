//
//  CFHomeViewController.m
//  CFast
//
//  Created by Ali Raza on 14/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFHomeViewController.h"
#import "CFCategoryViewController.h"
#import "CFProfileViewController.h"
#import "CFLoginViewController.h"

@interface CFHomeViewController ()

@end

@implementation CFHomeViewController

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
    self.forumButton.buttonColor = [UIColor carrotColor];
    self.forumButton.shadowColor = [UIColor pumpkinColor];
    self.forumButton.shadowHeight = 3.0f;
    self.forumButton.cornerRadius = 6.0f;
    self.forumButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.forumButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.forumButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.settingsButton.buttonColor = [UIColor carrotColor];
    self.settingsButton.shadowColor = [UIColor pumpkinColor];
    self.settingsButton.shadowHeight = 3.0f;
    self.settingsButton.cornerRadius = 6.0f;
    self.settingsButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.settingsButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.settingsButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.view.backgroundColor = [UIColor cloudsColor];
  
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated{
    NSString *userid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
    if(userid == NULL){
        CFLoginViewController *login = [[CFLoginViewController alloc]init];
        [self presentViewController:login animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shoForum:(id)sender {
    CFCategoryViewController *categories = [[CFCategoryViewController alloc]init];
    categories.loggedIn = YES;
    [self.navigationController pushViewController:categories animated:YES];
}

- (IBAction)showProfile:(id)sender {
    CFProfileViewController *profileVC = [[CFProfileViewController alloc]init];
    [self.navigationController pushViewController:profileVC animated:YES];
}
@end
