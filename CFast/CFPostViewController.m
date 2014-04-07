//
//  CFPostViewController.m
//  CFast
//
//  Created by Ali Raza on 19/03/2014.
//  Copyright (c) 2014 Welltime Ltd. All rights reserved.
//

#import "CFPostViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "CFReplyViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@interface CFPostViewController ()

@end

@implementation CFPostViewController

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
    self.title = @"Posts";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    if(self.reFetch)
    {
        RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:[UIColor cloudsColor]];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.square = YES;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = spinner;
        hud.labelText = NSLocalizedString(@"Please Wait...", @"Please Wait...");
        
        [spinner startAnimating];

        
        [[LRResty client] get:[NSString stringWithFormat:@"http://cfast-api.fireflycommunicator.com/api/conversation/%@",self.postID] withBlock:^(LRRestyResponse *r)
         {
             NSData *responseData = [[r asString] dataUsingEncoding:NSUTF8StringEncoding];
             NSError *theError = nil;
             self.posts = [[CJSONDeserializer deserializer] deserializeAsArray:responseData error:&theError];
             [self.tableView reloadData];
             [spinner stopAnimating];
             [hud hide:YES];

         }];
    }
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
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;

    }
    
    
    
    // Configure the cell...
    NSDictionary *thepost = [self.posts objectAtIndex:[indexPath row]];
    NSTimeInterval seconds = [[thepost objectForKey:@"DATETIME"] doubleValue];
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSString *msg = [NSString stringWithFormat:@"%@ \n\n %@ on %@ \n\n\n %@",[thepost objectForKey:@"MESSAGE"],[thepost objectForKey:@"NAME"],epochNSDate, @"Click to Reply"];
    cell.textLabel.text = msg;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    
    
//    NSLog (@"Epoch time %@ equates to UTC %@", epochTime, epochNSDate);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSString *detail =[NSString stringWithFormat:@"%@ on %@",[thepost objectForKey:@"NAME"],epochNSDate];
//    cell.detailTextLabel.text = detail;
    
    [cell configureFlatCellWithColor:[UIColor cloudsColor] selectedColor:[UIColor pumpkinColor]];
    cell.textLabel.textColor = [UIColor carrotColor];
    cell.detailTextLabel.textColor = [UIColor pumpkinColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *thepost = [self.posts objectAtIndex:[indexPath row]];
    NSTimeInterval seconds = [[thepost objectForKey:@"DATETIME"] doubleValue];
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSString *cellText = [NSString stringWithFormat:@"%@ \n\n %@ on %@ \n\n\n %@",[thepost objectForKey:@"MESSAGE"],[thepost objectForKey:@"NAME"],epochNSDate,@"Click to Reply"];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 20;
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
    CFReplyViewController *replyVC = [[CFReplyViewController alloc]init];
    replyVC.replyTo = [self.posts objectAtIndex:[indexPath row]];
    self.reFetch = YES;
//    self.postID = (int)[[self.posts objectAtIndex:[indexPath row]] objectForKey:@"THREAD"];
    [self.navigationController pushViewController:replyVC animated:YES];
}
 


@end
