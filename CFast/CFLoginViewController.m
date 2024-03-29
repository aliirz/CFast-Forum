//
//  CFLoginViewController.m
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFLoginViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
//#import "CFCategoryViewController.h"
#import "CFHomeViewController.h"

@interface CFLoginViewController ()

@end

@implementation CFLoginViewController

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
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    _preferences = [NSUserDefaults  standardUserDefaults];
    self.loginBtn.buttonColor = [UIColor carrotColor];
    self.loginBtn.shadowColor = [UIColor pumpkinColor];
    self.loginBtn.shadowHeight = 3.0f;
    self.loginBtn.cornerRadius = 6.0f;
    self.loginBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.loginBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logIn:(id)sender {
    NSError *error = NULL;
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setObject:self.usernameField.text forKey:@"Username"];
    [data setObject:self.passwordField.text forKey:@"Password"];
    
    
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
    
    [[LRResty client] post:@"http://cfast-api.fireflycommunicator.com/api/user" payload:jsonData headers:requestHeaders withBlock:^(LRRestyResponse *response){
        NSString *msg = [response asString];
//            NSLog(@"%@",msg);
        NSData *responseData = [msg dataUsingEncoding:NSUTF8StringEncoding];
        NSError *theError = nil;
        NSDictionary *responseDictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseData error:&theError];
        NSLog(@"%@",responseDictionary);
//        NSDictionary *firstDict = [responseArray objectAtIndex:0];      //to get the user and pass and too nsuerdefaults.
        if([[responseDictionary valueForKey:@"Status"] isEqual:[NSNumber numberWithBool:YES]])
        {
            [[NSUserDefaults standardUserDefaults] setObject:self.usernameField.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordField.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]  setObject:[responseDictionary objectForKey:@"User_ID"] forKey:@"userid"];
            [[NSUserDefaults standardUserDefaults] setObject:[responseDictionary objectForKey:@"Email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:[responseDictionary objectForKey:@"Name"] forKey:@"name"];
            
            //ok cool let show the category view then
//            CFHomeViewController *homeVC = [[CFHomeViewController alloc]init];
        
//            NSArray *categoriesArray =
//            int countofObjs = [categoriesArray count];
//            NSMutableArray *categoriesFromResponse = [[NSMutableArray alloc]init];
//            for(int i =0; i< countofObjs; i++)
//            {
//                NSDictionary *dict = [categoriesArray objectAtIndex:i];
//                [categoriesFromResponse addObject:[dict objectForKey:@"TITLE"]];
//                
//            }
//            categoryVC.categories = [responseDictionary objectForKey:@"categories"];
            [spinner stopAnimating];
            [hud hide:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
//            [self.navigationController pushViewController:homeVC animated:YES];
            
            
        }
        else
        {
            [spinner stopAnimating];
            [hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Invalid username or password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
      
        
        //save the details in nsuserdefaults
        
    }];
    
    
}

#pragma mark UITextFieldDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
