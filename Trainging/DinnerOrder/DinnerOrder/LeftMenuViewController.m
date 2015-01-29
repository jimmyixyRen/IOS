//
//  LeftMenuViewController.m
//  DinnerOrder
//
//  Created by rendl on 15/1/28.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "LeftMenuViewController.h"

@interface LeftMenuViewController ()
{
    NSMutableArray *titles;
}
@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Stars"]]];
    titles = [[NSMutableArray alloc] initWithObjects:@"登录",@"历史纪录", nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyHandle:) name:NOTIFY_LOGIN object:nil];
}

-(void)notifyHandle:(NSNotification *)notify
{
    [titles replaceObjectAtIndex:0 withObject:@"注销"];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            if (![Util SharedInstance].isLogined)
            {
                UINavigationController *contentNavigationController = (UINavigationController *)self.sideMenuViewController.contentViewController;
                UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [contentNavigationController pushViewController:vc animated:YES];
                [self.sideMenuViewController hideMenuViewController];
            }
            else
            {
                [Util SharedInstance].isLogined = NO;
                [Util SharedInstance].userid = nil;
                [Util SharedInstance].username = nil;
                [titles replaceObjectAtIndex:0 withObject:@"登录"];
                [tableView reloadData];
            }
            break;
        }
        default:
        {
            UINavigationController *contentNavigationController = (UINavigationController *)self.sideMenuViewController.contentViewController;
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderHistoryTableViewController"];
            [contentNavigationController pushViewController:vc animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
   
//    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    cell.textLabel.text = titles[indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

-(void)updateLoginInfo
{
     if ([Util SharedInstance].isLogined)
     {
         [titles replaceObjectAtIndex:0 withObject:@"注销"];
     }
    else
    {
        [titles replaceObjectAtIndex:0 withObject:@"登录"];
    }
    [self.tableView reloadData];
}

@end
