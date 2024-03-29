//
//  CFForumsViewController.m
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFForumsViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "CFPostViewController.h"

@interface CFForumsViewController ()

@end

@implementation CFForumsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Topics";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *topic = [self.topics objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [topic objectForKey:@"TITLE"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Created By %@",[topic objectForKey:@"CREATED_BY"]];
    
    
    [cell configureFlatCellWithColor:[UIColor cloudsColor] selectedColor:[UIColor pumpkinColor]];
    cell.textLabel.textColor = [UIColor carrotColor];
    cell.detailTextLabel.textColor = [UIColor pumpkinColor];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *topic = [self.topics objectAtIndex:[indexPath row]];
    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:[UIColor cloudsColor]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.labelText = NSLocalizedString(@"Please Wait...", @"Please Wait...");
    
    [spinner startAnimating];
    
    [[LRResty client] get:[NSString stringWithFormat:@"http://cfast-api.fireflycommunicator.com/api/conversation/%@",[topic objectForKey:@"ID"]] withBlock:^(LRRestyResponse *r)
     {
      
         CFPostViewController *thread = [[CFPostViewController alloc]init];
         thread.postID = [topic objectForKey:@"ID"];
         NSLog(@"%@",[r asString]);
         NSData *responseData = [[r asString] dataUsingEncoding:NSUTF8StringEncoding];
         NSError *theError = nil;
         thread.posts = [[CJSONDeserializer deserializer] deserializeAsArray:responseData error:&theError];
         [spinner stopAnimating];
         [hud hide:YES];
         [self.navigationController pushViewController:thread animated:YES];
         
     }
     ];
    
}
 


@end
