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
#import "CFCategoryViewController.h"

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
    
    NSData *jsonData = [[CJSONSerializer serializer] serializeObject:data error:&error];
    
    NSDictionary *requestHeaders = [NSDictionary
                                    dictionaryWithObject:@"application/json" forKey:@"Content-Type"];
    
    [[LRResty client] post:@"http://192.168.100.100/Cfast.Api/api/user" payload:jsonData headers:requestHeaders withBlock:^(LRRestyResponse *response){
        NSString *msg = [response asString];
//            NSLog(@"%@",msg);
        NSData *responseData = [msg dataUsingEncoding:NSUTF8StringEncoding];
        NSError *theError = nil;
        NSDictionary *responseDictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseData error:&theError];
//        NSDictionary *firstDict = [responseArray objectAtIndex:0];      //to get the user and pass and too nsuerdefaults.
        if([[responseDictionary valueForKey:@"Status"] isEqual:[NSNumber numberWithBool:YES]])
        {
            [[NSUserDefaults standardUserDefaults] setObject:self.usernameField.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordField.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]  setObject:[responseDictionary objectForKey:@"User_ID"] forKey:@"userid"];
            
            //ok cool let show the category view then
            CFCategoryViewController *categoryVC = [[CFCategoryViewController alloc]init];
            
//            NSArray *categoriesArray =
//            int countofObjs = [categoriesArray count];
//            NSMutableArray *categoriesFromResponse = [[NSMutableArray alloc]init];
//            for(int i =0; i< countofObjs; i++)
//            {
//                NSDictionary *dict = [categoriesArray objectAtIndex:i];
//                [categoriesFromResponse addObject:[dict objectForKey:@"TITLE"]];
//                
//            }
            categoryVC.categories = [responseDictionary objectForKey:@"categories"];
            [self.navigationController pushViewController:categoryVC animated:YES];
            
            
        }
        else
        {
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
