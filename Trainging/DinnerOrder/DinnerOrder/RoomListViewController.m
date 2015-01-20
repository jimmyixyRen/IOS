//
//  RoomListViewController.m
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "RoomListViewController.h"
#import "Util.h"

@interface RoomListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *roomList;
}
@property (strong, nonatomic) IBOutlet UITableView *tv_room;

@end

@implementation RoomListViewController
@synthesize tv_room;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  roomList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#define CELL_ID @"cell_id"
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (cell == nil)
    {
        cell = [[RoomTableCell alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 50)];
    }
    [(RoomTableCell *)cell setRoomInfo:[roomList objectAtIndex:indexPath.row]];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tv_room.delegate = self;
    tv_room.dataSource = self;
    roomList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [[Util SharedInstance].httpManager POST:@"http://192.168.99.215:8080/servers/roomlist"
           parameters:@{@"name":@"rendl", @"password":@"1234"}
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"%@------->%@", [responseObject class], responseObject);
                  NSDictionary *retDict = responseObject;
                  NSArray *roomArray = [retDict objectForKey:@"rooms"];
                  
                  for (NSDictionary *item in roomArray)
                  {
                      Room *room = [[Room alloc] init];
                      room.tid = ((NSNumber *)[item objectForKey:@"id"]).integerValue;
                      room.name = [item objectForKey:@"name"];
                      room.peroncount = [item objectForKey:@"personcount"];
                      room.tablecount = [item objectForKey:@"tablecount"];
                      room.remark = [item objectForKey:@"mark"];
                      [roomList addObject:room];
                  }
                  [tv_room reloadData];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"%@", [error localizedDescription]);
              }];
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

@implementation RoomTableCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    lbName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    [lbName setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    
    lbPersonCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 10)];
    [lbPersonCount setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [lbPersonCount setTextColor:[UIColor grayColor]];
    
    lbDeskCount = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, 100, 10)];
    [lbDeskCount setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [lbDeskCount setTextColor:[UIColor grayColor]];
    
    lbRemark = [[UILabel alloc] initWithFrame:CGRectMake(180, 30, 100, 10)];
    [lbRemark setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [lbRemark setTextColor:[UIColor grayColor]];
    
    [self addSubview:lbName];
    [self addSubview:lbPersonCount];
    [self addSubview:lbDeskCount];
    [self addSubview:lbRemark];
    
    return self;
}

-(void)setRoomInfo:(Room *)room
{
    lbName.text = room.name;
    lbPersonCount.text = [NSString stringWithFormat:@"容纳人数:%@", room.peroncount];
    lbDeskCount.text = [NSString stringWithFormat:@"桌子数:%@", room.tablecount];
    lbRemark.text = [NSString stringWithFormat:@"备注:%@" ,room.remark];
}

@end
