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
    
    UIView *orderInfoView;
    UILabel *lbSelectRoom;
    Room *selectRoom;
    
    UIActivityIndicatorView *waitView;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [(RoomTableCell *)cell setRoomInfo:[roomList objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (selectRoom == nil)
    {
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDelay:0.3];
        CGRect rect = orderInfoView.frame;
        rect.origin.y = MAIN_SCREEN_HTIGHT - rect.size.height;
        [orderInfoView setFrame:rect];
        [UIView commitAnimations];
    }
    
    for (UITableViewCell *cell in tableView.visibleCells)
    {
        if (cell == [tableView cellForRowAtIndexPath:indexPath])
        {
             [cell  setBackgroundColor:[UIColor colorWithRed:0.512 green:0.853 blue:1.000 alpha:1.000]];
        }
        else
        {
            [cell setBackgroundColor: [UIColor whiteColor]];
        }
    }
    
    selectRoom = [roomList objectAtIndex:indexPath.row];
    [lbSelectRoom setText:selectRoom.name];
}

-(void)okClick:(id)sender
{
    [Util SharedInstance].selectRoom = selectRoom;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    waitView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [waitView setCenter:CGPointMake(MAIN_SCREEN_WIDTH / 2, MAIN_SCREEN_HTIGHT / 2)];
    [waitView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [waitView startAnimating];
    waitView.hidesWhenStopped = YES;
    [self.view addSubview:waitView];
    
    tv_room.delegate = self;
    tv_room.dataSource = self;
    roomList = [[NSMutableArray alloc] initWithCapacity:0];
    
    orderInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HTIGHT, MAIN_SCREEN_WIDTH, 50)];
    lbSelectRoom = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 20)];
    UIButton *ensureButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 15, 50, 20)];
    [ensureButton addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    [ensureButton setTitle:@"确定" forState:UIControlStateNormal];
    [ensureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ensureButton setBackgroundColor:[UIColor colorWithRed:0.726 green:0.446 blue:0.882 alpha:1.000]];
    [orderInfoView addSubview:ensureButton];
    [orderInfoView addSubview:lbSelectRoom];
    [self.view addSubview:orderInfoView];
    [orderInfoView setBackgroundColor:[UIColor colorWithRed:0.512 green:0.853 blue:1.000 alpha:1.000]];
    
    [[Util SharedInstance].httpManager POST:@"http://192.168.99.215:8080/servers/roomlist"
           parameters:@{@"name":@"rendl", @"password":@"1234"}
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"%@------->%@", [responseObject class], responseObject);
                  NSDictionary *retDict = responseObject;
                  NSArray *roomArray = [retDict objectForKey:@"rooms"];
                  
                  for (NSDictionary *item in roomArray)
                  {
                      Room *room = [[Room alloc] init];
                      room.tid = ((NSNumber *)[item objectForKey:@"id"]).intValue;
                      room.name = [item objectForKey:@"name"];
                      room.peroncount = [item objectForKey:@"personcount"];
                      room.tablecount = [item objectForKey:@"tablecount"];
                      room.remark = [item objectForKey:@"mark"];
                      [roomList addObject:room];
                  }
                  [waitView stopAnimating];
                  [tv_room reloadData];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"%@", [error localizedDescription]);
                  [waitView stopAnimating];
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
