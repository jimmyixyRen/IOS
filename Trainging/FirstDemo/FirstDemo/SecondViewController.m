//
//  SecondViewController.m
//  FirstDemo
//
//  Created by rendl on 15/1/7.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize message;

- (IBAction)backClick1:(id)sender
{
    UIButton *bt = sender;
    if (bt.tag == 0)//回退1
    {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"页面2消失");
        }];
    }
    else//回退2
    {
        //pop动画
//        CATransition *transition = [CATransition animation];
//        transition.duration =0.4;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionReveal;
//        //transition.subtype = kCATransitionFromBottom;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)handleNotify:(id)obj
{
    NSNotification *notify = obj;
    NSLog(@"Receive notify : %@", notify.object);
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Message:%@", message);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PASS_ARGUMENTS" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotify:) name:@"PASS_ARGUMENTS" object:nil];
    NSLog(@"view2 did load.");
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
