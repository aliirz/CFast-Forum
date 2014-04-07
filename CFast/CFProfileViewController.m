//
//  CFProfileViewController.m
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFProfileViewController.h"
#import "CFPasswordViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

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
    
    self.logoutBtn.buttonColor = [UIColor carrotColor];
    self.logoutBtn.shadowColor = [UIColor pumpkinColor];
    self.logoutBtn.shadowHeight = 2.0f;
    self.logoutBtn.cornerRadius = 6.0f;
    self.logoutBtn.titleLabel.font = [UIFont boldFlatFontOfSize:14];
    [self.logoutBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDetails:(id)sender {
    
    if(self.nameField.text.length == 0 && self.emailField.text.length == 0)
    {
        FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"The fields cannot be empty"
                                                             delegate:nil cancelButtonTitle:@"Ok"
                                                    otherButtonTitles:nil, nil];
        alertView.titleLabel.textColor = [UIColor cloudsColor];
        alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        alertView.messageLabel.textColor = [UIColor cloudsColor];
        alertView.messageLabel.font = [UIFont flatFontOfSize:14];
        alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
        alertView.alertContainer.backgroundColor = [UIColor pumpkinColor];
        alertView.defaultButtonColor = [UIColor cloudsColor];
        alertView.defaultButtonShadowColor = [UIColor asbestosColor];
        alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
        alertView.defaultButtonTitleColor = [UIColor asbestosColor];
        [alertView show];
    }
    else{
        NSError *error = NULL;
        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
        [data setObject:self.nameField.text forKey:@"NAME"];
        [data setObject:self.emailField.text forKey:@"EMAIL"];
        [data setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"] forKey:@"USER_ID"];
        RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:[UIColor cloudsColor]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.labelText = NSLocalizedString(@"Please Wait...", @"Please Wait...");
    
    [spinner startAnimating];

    NSData *jsonData = [[CJSONSerializer serializer] serializeObject:data error:&error];
    
    NSDictionary *requestHeaders = [NSDictionary
                                    dictionaryWithObject:@"application/json" forKey:@"Content-Type"];
     [[LRResty client] post:@"http://cfast-api.fireflycommunicator.com/api/profile" payload:jsonData headers:requestHeaders withBlock:^(LRRestyResponse *response){
         
         if([[response asString] isEqualToString:@"\"Profile Updated, Thank you for your time.\""])
         {
             [spinner stopAnimating];
             [hud hide:YES];
             [self.navigationController popViewControllerAnimated:YES];
         }
         
     }];
    }
}

//- (IBAction)showPWChangeView:(id)sender {
//    CFPasswordViewController *changePWView = [[CFPasswordViewController alloc]init];
//    [self.navigationController pushViewController:changePWView animated:YES];
//}
- (IBAction)logout:(id)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
