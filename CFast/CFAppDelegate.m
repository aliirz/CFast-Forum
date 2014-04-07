//
//  CFAppDelegate.m
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFAppDelegate.h"
#import "CFLoginViewController.h"
#import "CFCategoryViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "CFHomeViewController.h"
#import "TestFlight.h"
@implementation CFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UINavigationController *nav = [[UINavigationController alloc]init];
    
    [TestFlight takeOff:@"7f320055-3ea4-40d3-a9de-40a22202a081"];
    
    [nav.navigationBar configureFlatNavigationBarWithColor:[UIColor pumpkinColor]];
    
    nav.navigationBar.barTintColor = [UIColor blackColor];
    nav.navigationBar.tintColor = [UIColor cloudsColor];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor cloudsColor]}];
    nav.navigationBar.translucent = NO;

//    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor wetAsphaltColor]
//                                  highlightedColor:[UIColor concreteColor]
//                                      cornerRadius:2];
    
//    CFLoginViewController *loginVC = [[CFLoginViewController alloc]init];
    CFHomeViewController  *homeVC = [[CFHomeViewController alloc]init];
//    CFCategoryViewController *categoryVC = [[CFCategoryViewController alloc] init];
    
    
//    NSUserDefaults *_preferences = [[NSUserDefaults alloc]init];
    NSString *userid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
//    if(userid != NULL)
//    {
////        [[LRResty client] get:@"http://192.168.100.100/Cfast.Api/api/post" withBlock:^(LRRestyResponse *r) {
////            NSData *responseData = [[r asString] dataUsingEncoding:NSUTF8StringEncoding];
////            NSError *theError = nil;
////            NSArray *responseArray = [[CJSONDeserializer deserializer] deserializeAsArray:responseData error:&theError];
////        }];
////        categoryVC.loggedIn = YES;
//        
//        [nav pushViewController:homeVC animated:NO];
//        
//    }
//    else
//    {
        [nav pushViewController:homeVC animated:NO];
//    }
    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
