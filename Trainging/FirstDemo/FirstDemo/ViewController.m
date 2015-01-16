//
//  ViewController.m
//  FirstDemo
//
//  Created by rendl on 15/1/4.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "ActionProtocol.h"

@interface ViewController ()<ActionProtocol>//实现某个协议逗号分割

@property (strong, nonatomic) IBOutlet UILabel *lb_hello;


@end


@implementation ViewController

#pragma mark - 代理实现
-(void)doSomeAction
{
    NSLog(@"给我买包双喜!");
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *desetViewController = segue.destinationViewController;
    NSLog(@"Get deset view controller.");
    [desetViewController setValue:@"Hello from view1 by setValueForKey" forKey:@"message"];
}

- (IBAction)btClick:(id)sender
{
    NSLog(@"clicked.");
    
    //手动添加控件
//    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 50, 20)];
//    [bt setTitle:@"走起" forState:UIControlStateNormal];
//    [bt setBackgroundColor:[UIColor colorWithRed:1.000 green:0.716 blue:0.305 alpha:1.000]];
//    [bt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bt];
    
    //三行代码的动画
//    UIButton *button = sender;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:3.0];
//    [button setFrame:CGRectMake(50, 100, button.frame.size.width, button.frame.size.height)];
//    [UIView commitAnimations];
    
    //跳转
    [self performSegueWithIdentifier:@"GotoSecondView" sender:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PASS_ARGUMENTS" object:@"Hello from view1 by send notiy"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //内存管理
    NSString *mStr = [[NSString alloc] initWithFormat:@"Good"];
    __weak NSString *str = mStr;//weak相当于assign 这里并不会触发对象的引用计数 它只能指向已存在的对象不能作为对象拥有者 也就是不能给weak对象alloc,但可以修改它指向的内容
    NSLog(@"%@ %@", mStr, str);
    
    str = nil;
    //str = [[NSString alloc] initWithFormat:@"shit"]; //警告
    NSLog(@"%@ %@", mStr, str);
    
    //__strong NSString *copyStr = mStr; //字符串重新定义拥有者
    mStr = nil;
    NSLog(@"%@ %@", mStr, str);
    
    //代理
    Car *mCar = [[Car alloc] init];
    mCar.delegate = self;//设置好代理
    [mCar gotoSomePlace:@"家家悦超市 "];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
