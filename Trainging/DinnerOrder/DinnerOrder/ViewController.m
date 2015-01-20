//
//  ViewController.m
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "ViewController.h"
#import "Util.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lb_welcome;
@property (strong, nonatomic) IBOutlet UIButton *bt_login;

@end

@implementation ViewController
@synthesize lb_welcome, bt_login;
- (IBAction)testClick:(id)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RoomListViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)loginClick:(id)sender
{
    if (bt_login.tag == 0)
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        self.navigationController.navigationBar.hidden = NO;
    }
    else
    {
        [bt_login setTitle:@"登录" forState:UIControlStateNormal];
        bt_login.tag = 0;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    if ([Util SharedInstance].isLogined)
    {
        lb_welcome.text = [NSString stringWithFormat:@"%@ 欢迎你", [Util SharedInstance].username];
        [bt_login setTitle:@"注销" forState:UIControlStateNormal];
        bt_login.tag = 1;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
