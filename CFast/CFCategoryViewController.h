//
//  CFCategoryViewController.h
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFCategoryViewController : UITableViewController <LRRestyClientDelegate>

@property (nonatomic, strong) NSArray *categories;
@property BOOL loggedIn;

@end
