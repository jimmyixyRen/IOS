//
//  FoodListViewController.m
//  DinnerOrder
//
//  Created by rendl on 15/1/22.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "FoodListViewController.h"
#import "Util.h"

@interface FoodListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *foodList;
    
    //右边选择栏
    UIScrollView *selectFoodScrollView;
    NSMutableArray *selectFoodList;
    
    UIView *selectTotalView;
    UILabel *totalCastLabel;//合计
    int totcalCast;
    NSMutableArray *selectViewArray;
    BOOL hideSideBar;
}

@property (strong, nonatomic) IBOutlet UITableView *tvFood;

@end

@implementation FoodListViewController
@synthesize tvFood;

#define SCROOLL_WIDTH   100
#define TOTAL_CAST_HEIGHT 60

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return foodList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#define FOOD_CELL_ID    @"food_cell_id"
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FOOD_CELL_ID];
    if (cell == nil)
    {
        cell = [[FoodTableviewCell alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 30)];
    }
    [(FoodTableviewCell *)cell updateFoodInfo:[foodList objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)removeClick:(UIGestureRecognizer *)gesture
{
    UIView *view = [gesture view];
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect rect = view.frame;
                         rect.origin.x -= rect.size.width;
                         [view setFrame:rect];
                     }
                     completion:^(BOOL finished) {
                         [view removeFromSuperview];
                         for (int i = [selectViewArray indexOfObject:view] + 1; i < selectViewArray.count; i++)
                         {
                             UIView *item = [selectViewArray objectAtIndex:i];
                             CGRect rect = item.frame;
                             rect.origin.y -= rect.size.height;
                             [item setFrame:rect];
                         }
                         Food *removeFood = [selectFoodList objectAtIndex:[selectViewArray indexOfObject:view]];
                         totcalCast -= removeFood.price.integerValue;
                         [totalCastLabel setText:[NSString stringWithFormat:@"合计:%d元", totcalCast]];
                         [selectFoodList removeObjectAtIndex:[selectViewArray indexOfObject:view]];
                         [selectViewArray removeObject:view];
                         [view removeFromSuperview];
    }];
}

-(void)addFood:(UITableView *)tableView selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = [self.view convertRect:[tableView cellForRowAtIndexPath:indexPath].frame  toView:self.view];
    UIView *selectFoodView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, 100, 30)];
    UILabel *selectFoodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, 20)];
    UILabel *selectFoodPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 30, 20)];
    
    selectFoodNameLabel.text = ((Food *)[foodList objectAtIndex:indexPath.row]).name;
    selectFoodPriceLabel.text = [NSString stringWithFormat:@"%@￥",((Food *)[foodList objectAtIndex:indexPath.row]).price];
    [selectFoodNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10.0f]];
    [selectFoodPriceLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10.0f]];
    [selectFoodView addSubview:selectFoodNameLabel];
    [selectFoodView addSubview:selectFoodPriceLabel];
    [selectFoodView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeClick:)]];
    [self.view addSubview:selectFoodView];
    [selectViewArray addObject:selectFoodView];
    [UIView animateWithDuration:0.4
                     animations:^{
                         CGRect rc = selectFoodView.frame;
                         CGRect rc2 = [self.view convertRect:CGRectMake(5, selectFoodList.count * 30, 100, 30) fromView:selectFoodScrollView];
                         rc.origin.x =rc2.origin.x;
                         rc.origin.y = rc2.origin.y;
                         [selectFoodView setFrame:rc];
                     }
                     completion:^(BOOL finished) {
                         [selectFoodView removeFromSuperview];
                         [selectFoodView setFrame:CGRectMake(5, selectFoodList.count* 30, 100, 30)];
                         [selectFoodScrollView addSubview:selectFoodView];
                         selectFoodScrollView.contentSize = CGSizeMake(selectFoodView.frame.size.width, selectFoodList.count * 30);
                         CGFloat offsetHeight = selectFoodScrollView.frame.size.height > selectFoodScrollView.contentSize.height?0:selectFoodScrollView.contentSize.height - selectFoodScrollView.frame.size.height;
                         [selectFoodScrollView setContentOffset:CGPointMake(0, offsetHeight)  animated:YES];
                         
                     }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    totcalCast += ((Food *)[foodList objectAtIndex:indexPath.row]).price.integerValue;
    [totalCastLabel setText:[NSString stringWithFormat:@"合计:%d元", totcalCast]];
    [selectFoodList addObject:[foodList objectAtIndex:indexPath.row]];
    if (hideSideBar)
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             CGRect rect = selectFoodScrollView.frame;
                             rect.origin.x -= SCROOLL_WIDTH;
                             [selectFoodScrollView setFrame:rect];
                             CGRect rect2 = selectTotalView.frame;
                             rect2.origin.x -= SCROOLL_WIDTH;
                             [selectTotalView setFrame:rect2];
                         }
                         completion:^(BOOL finished) {
                             [self addFood:tableView selectRowAtIndexPath:indexPath];
                             hideSideBar = NO;
        }];
    }
    else
    {
        [self addFood:tableView selectRowAtIndexPath:indexPath];
    }
    
    for (UITableViewCell *cell in tableView.visibleCells)
    {
        if (cell == [tableView cellForRowAtIndexPath:indexPath])
        {
            [cell  setBackgroundColor:[UIColor colorWithRed:0.512 green:0.853 blue:1.000 alpha:1.000]];
        }
        else
        {
            [cell setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
}

-(void)okClick:(id)sender
{
    [Util SharedInstance].foodList = selectFoodList;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [selectViewArray removeAllObjects];
    selectViewArray = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tvFood.delegate = self;
    tvFood.dataSource = self;
    foodList = [[NSMutableArray alloc] initWithCapacity:0];
    selectFoodList = [Util SharedInstance].foodList;
    selectViewArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"select food count:%d", selectFoodList.count);
    
    
    
    CGFloat topHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    selectFoodScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH, topHeight, SCROOLL_WIDTH, MAIN_SCREEN_HTIGHT - topHeight - TOTAL_CAST_HEIGHT)];
    [selectFoodScrollView setScrollEnabled:YES];
    [selectFoodScrollView setShowsVerticalScrollIndicator:YES];
    [selectFoodScrollView setShowsHorizontalScrollIndicator:NO];
    [selectFoodScrollView setBackgroundColor:[UIColor colorWithRed:0.756 green:0.932 blue:0.683 alpha:1.000]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 90, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [titleLabel setText:@"已选菜单"];
    [selectFoodScrollView addSubview:titleLabel];
    
    selectTotalView = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH, MAIN_SCREEN_HTIGHT - TOTAL_CAST_HEIGHT, SCROOLL_WIDTH, TOTAL_CAST_HEIGHT)];
    totalCastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCROOLL_WIDTH, TOTAL_CAST_HEIGHT/2)];
    totalCastLabel.textAlignment = NSTextAlignmentCenter;
    totalCastLabel.font = [UIFont boldSystemFontOfSize:13];
    [totalCastLabel setText:@"合计:100元"];
    [totalCastLabel setBackgroundColor:[UIColor colorWithRed:0.756 green:0.932 blue:0.683 alpha:1.000]];
    [selectTotalView addSubview:totalCastLabel];
    UIButton *okBt = [[UIButton alloc] initWithFrame:CGRectMake(0, TOTAL_CAST_HEIGHT/2, SCROOLL_WIDTH, TOTAL_CAST_HEIGHT/2)];
    [okBt setTitle:@"确认菜单" forState:UIControlStateNormal];
    okBt.titleLabel.textAlignment =NSTextAlignmentCenter;
    okBt.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [okBt setBackgroundColor:[UIColor colorWithRed:0.137 green:0.764 blue:0.066 alpha:1.000]];
    [okBt addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectTotalView addSubview:okBt];
    [self.view addSubview:selectFoodScrollView];
    [self.view addSubview:selectTotalView];
    
    totcalCast = 0;
    
    [[Util SharedInstance].httpManager POST:@"http://192.168.99.215:8080/servers/foodlist"
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *dict = responseObject;
                  NSLog(@"response:%@", dict);
                  NSString *status = [dict objectForKey:@"status"];
                  if ([status isEqualToString:@"0"])
                  {
                      NSArray *array = [dict objectForKey:@"foodlist"];
                      for (NSDictionary *item in array)
                      {
                          Food *f = [[Food alloc] init];
                          f.name = [item objectForKey:@"name"];
                          f.price = [item objectForKey:@"price"];
                          f.fid = [item objectForKey:@"id"];
                          f.remark = [item objectForKey:@"remark"];
                          [foodList addObject:f];
                      }
                      
                      [tvFood reloadData];
                      
                      
                      for (int i = 0; i < selectFoodList.count; i++)
                      {
                          UIView *selectFoodView = [[UIView alloc] initWithFrame:CGRectMake(5, (i + 1)* 30, SCROOLL_WIDTH, 30)];
                          UILabel *selectFoodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, 20)];
                          UILabel *selectFoodPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 30, 20)];
                          
                          selectFoodNameLabel.text = ((Food *)[selectFoodList objectAtIndex:i]).name;
                          selectFoodPriceLabel.text = [NSString stringWithFormat:@"%@￥",((Food *)[selectFoodList objectAtIndex:i]).price];
                          [selectFoodNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10.0f]];
                          [selectFoodPriceLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10.0f]];
                          [selectFoodView addSubview:selectFoodNameLabel];
                          [selectFoodView addSubview:selectFoodPriceLabel];
                          [selectFoodView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeClick:)]];
                          [self.view addSubview:selectFoodView];
                          [selectViewArray addObject:selectFoodView];
                          [selectFoodScrollView addSubview:selectFoodView];
                          totcalCast += ((Food *)[selectFoodList objectAtIndex:i]).price.integerValue;
                      }
                        [totalCastLabel setText:[NSString stringWithFormat:@"合计:%d元", totcalCast]];
                       selectFoodScrollView.contentSize = CGSizeMake(SCROOLL_WIDTH, (selectFoodList.count + 1) * 30);
                  }
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"%@", error.localizedDescription);
                  [foodList removeAllObjects];
              }];
    
    hideSideBar = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation FoodTableviewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    lbFoodName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    [lbFoodName setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    
    lbFoodPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 10)];
    [lbFoodPrice setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [lbFoodPrice setTextColor:[UIColor grayColor]];
    
    lbRemark = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, 100, 10)];
    [lbRemark setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [lbRemark setTextColor:[UIColor grayColor]];
    
    [self addSubview:lbFoodName];
    [self addSubview:lbFoodPrice];
    [self addSubview:lbRemark];
    
    
    return self;
}

-(void)updateFoodInfo:(Food *)food
{
    lbFoodName.text = food.name;
    lbFoodPrice.text = [NSString stringWithFormat:@"￥%@", food.price];
    lbRemark.text = [NSString stringWithFormat:@"备注:%@", food.remark];
}

@end
