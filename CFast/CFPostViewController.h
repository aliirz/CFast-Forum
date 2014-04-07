//
//  CFPostViewController.h
//  CFast
//
//  Created by Ali Raza on 19/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPostViewController : UITableViewController

@property (nonatomic, strong) NSArray *posts;
@property BOOL reFetch;
@property (nonatomic, strong) NSString *postID;

@end
