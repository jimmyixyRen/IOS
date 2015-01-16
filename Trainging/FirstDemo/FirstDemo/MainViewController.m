//
//  MainViewController.m
//  FirstDemo
//
//  Created by rendl on 15/1/8.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "MainViewController.h"
#import <WebKit/WebKit.h>
#import "Car.h"
#import <objc/runtime.h>

@interface MainViewController ()
{
    Car *mCar;
}

@end

@implementation MainViewController

- (IBAction)changeClick:(id)sender {
    mCar.name = @"abc";
}


- (IBAction)goClick:(id)sender
{
    UIViewController *desetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SenconViewController"];
    if (desetViewController != nil)
    {
        [self.navigationController pushViewController:desetViewController animated:YES];
    }
    
    
    //push动画
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromTop;
//    transition.delegate = self;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    self.navigationController.navigationBarHidden = NO;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"key:%@ object:%@ change:%@", keyPath, object, change);
}

-(void)testSelector:(NSString *)arg1   arg2:(int)arg2
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mCar = [[Car alloc] init];
    [mCar addObserver:self forKeyPath:@"name" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    SEL myFunc = @selector(testSelector:arg2:);
    
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
