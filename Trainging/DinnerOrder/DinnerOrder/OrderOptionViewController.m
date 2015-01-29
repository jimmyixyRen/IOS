//
//  OrderOptionViewController.m
//  DinnerOrder
//
//  Created by  on 15/1/22.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "OrderOptionViewController.h"
#import "Food.h"
#import <FMDB.h>

@interface OrderOptionViewController ()
@property (strong, nonatomic) IBOutlet UITextField *tf_order_name;

@property (strong, nonatomic) IBOutlet UITextField *tf_order_count;
@property (strong, nonatomic) IBOutlet UITextField *tf_order_remark;
@property (strong, nonatomic) IBOutlet UILabel *lb_room;
@property (strong, nonatomic) IBOutlet UILabel *lb_food;
@end

@implementation OrderOptionViewController
@synthesize lb_room, lb_food;

-(void)viewDidAppear:(BOOL)animated
{
    if ([Util SharedInstance].selectRoom != nil)
    {
        [lb_room setText:[Util SharedInstance].selectRoom.name];
    }
    
    if ([Util SharedInstance].foodList.count != 0)
    {
        NSMutableString *foodName = [[NSMutableString alloc] initWithFormat:@""];
        for (Food *item in [Util SharedInstance].foodList)
        {
            [foodName appendFormat:@"%@,", item.name];
        }
        lb_food.text = [foodName substringToIndex:foodName.length - 1];
        
    }
}

- (IBAction)btClick:(id)sender
{
    UIButton *bt = sender;
    switch (bt.tag)
    {
        case 0://选择房间
        {
            [Util SharedInstance].selectRoom = nil;
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RoomListViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            self.navigationController.navigationBar.hidden = NO;
            break;
        }
        case 1://选择菜品
        {
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FoodListViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            self.navigationController.navigationBar.hidden = NO;
            break;
        }
        default://确认排队
        {
            NSMutableArray *foodIdArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableString *foodNameStr = [[NSMutableString alloc] initWithCapacity:0];
            for (Food *item in [Util SharedInstance].foodList)
            {
                [foodIdArray addObject:[NSString stringWithFormat:@"%@", item.fid]];
                [foodNameStr appendFormat:@"%@,", item.name];
            }
            [foodNameStr deleteCharactersInRange:NSMakeRange(foodNameStr.length - 1, 1)];
            
            [[Util SharedInstance].httpManager POST:@"http://192.168.99.215:8080/servers/orderroom"
                                         parameters:@{@"orderroomid":[NSString stringWithFormat:@"%d",[Util SharedInstance].selectRoom.tid],
                                                      @"ordername":_tf_order_name.text,
                                                      @"orderremark":_tf_order_remark.text,
                                                      @"orderfoodids":foodIdArray,
                                                      @"orderpersoncount":_tf_order_count.text}
                                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                NSDictionary *retDict = responseObject;
                                                NSString *status = [retDict objectForKey:@"status"];
                                                if ([status isEqualToString:@"1"])
                                                {
                                                    [Util SharedInstance].orderUUID = [retDict objectForKey:@"orderid"];
                                                    [Util SharedInstance].orderPreCount =((NSString *)[retDict objectForKey:@"precount"]).intValue;
                                                    [Util SharedInstance].orderLeftMinutes = ((NSString *)[retDict objectForKey:@"lefttime"]).intValue;
                                                    retDict = nil;
                                                    
                                                    [[Util SharedInstance] insertOneOrder:@""
                                                                                 roomName:_tf_order_name.text
                                                                              personCount:_tf_order_count.text];
                                                    
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                }
                                                
                                            }
                                            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                NSLog(@"Server error:%@", error.localizedDescription);
            }];
            break;
        }
    }
}

- (IBAction)hideKeyboard:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
