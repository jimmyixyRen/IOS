//
//  OrderHistoryTableViewController.m
//  DinnerOrder
//
//  Created by rendl on 15/1/29.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "OrderHistoryTableViewController.h"

@interface OrderHistoryTableViewController ()
{
    NSMutableArray *orderList;
}

@end

@implementation OrderHistoryTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    orderList = [[Util SharedInstance] getAllOrder];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return orderList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"order_cell"];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 50)];
    }
    
    NSDictionary *orderDict = [orderList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [orderDict objectForKey:@"order_room_name"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSDictionary *dict = [orderList objectAtIndex:indexPath.row];
        [[Util SharedInstance] deleteOneOrderByOrderID:[dict objectForKey:@"order_id"]];
        [orderList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
