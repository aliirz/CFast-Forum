//
//  CFCategoryViewController.m
//  CFast
//
//  Created by Ali Raza on 04/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFCategoryViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "CFForumsViewController.h"

@interface CFCategoryViewController ()

@end

@implementation CFCategoryViewController

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
    self.title = @"Categories";
    

    if(self.loggedIn)
    {
        RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:[UIColor cloudsColor]];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.square = YES;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = spinner;
        hud.labelText = NSLocalizedString(@"Please Wait...", @"Please Wait...");
        
        [spinner startAnimating];
        
        [[LRResty client] get:@"http://cfast-api.fireflycommunicator.com/api/post" withBlock:^(LRRestyResponse *r)
        {
            NSData *responseData = [[r asString] dataUsingEncoding:NSUTF8StringEncoding];
            NSError *theError = nil;
            self.categories = [[CJSONDeserializer deserializer] deserializeAsArray:responseData error:&theError];
            [self.tableView reloadData];
            [spinner stopAnimating];
            [hud hide:YES];
//            [hud removeFromSuperview];

        }
         ];
        
        self.tableView.backgroundColor = [UIColor cloudsColor];
    }
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
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    [cell configureFlatCellWithColor:[UIColor cloudsColor] selectedColor:[UIColor pumpkinColor]];
    cell.textLabel.textColor = [UIColor pumpkinColor];
    cell.backgroundColor = [UIColor cloudsColor];
    
    NSDictionary *category = [self.categories objectAtIndex:[indexPath row]];
    cell.textLabel.text = [category objectForKey:@"TITLE"];
    
    switch ([indexPath row]) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"File_Profile.png"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"Box_Closed.png"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"Venn_Diagram.png"];
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"Pic_iOS.png"];
            break;
        default:
            break;
    }
    
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
    CFForumsViewController *posts = [[CFForumsViewController alloc]init];
    NSDictionary *category = [self.categories objectAtIndex:[indexPath row]];
    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:[UIColor cloudsColor]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.labelText = NSLocalizedString(@"Please Wait...", @"Please Wait...");
    
    [spinner startAnimating];

    [[LRResty client] get:[NSString stringWithFormat:@"http://cfast-api.fireflycommunicator.com/api/post/%@",[category objectForKey:@"ID"]] withBlock:^(LRRestyResponse *r)
    {
        
        NSData *responseData = [[r asString] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *theError = nil;
        [spinner stopAnimating];
        [hud hide:YES];
        posts.topics = [[CJSONDeserializer deserializer] deserializeAsArray:responseData error:&theError];
        [self.navigationController pushViewController:posts animated:YES];

     }
     ];
}
 
 

@end
