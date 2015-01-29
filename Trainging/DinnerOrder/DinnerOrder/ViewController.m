//
//  ViewController.m
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "ViewController.h"
#import "Util.h"
#import <ZXingObjC.h>

@interface ViewController ()<ZXCaptureDelegate, UIAlertViewDelegate>
{
    UIView *orderInfoView;
    UILabel *orderPerCountLabel;
    UILabel *orderLeftTimeLabel;
    UIButton *orderCancelButton;
    BOOL isScaned;
    NSTimer *timer;
}
@property (strong, nonatomic) IBOutlet UIView *scanRectView;
@property (nonatomic, strong)ZXCapture *capture;
@end


@implementation ViewController
@synthesize  scanRectView;
- (IBAction)scanOK:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderOptionViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.capture.delegate = nil;
    isScaned = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if ([Util SharedInstance].orderUUID != nil)
    {
        orderInfoView.hidden = NO;
        orderPerCountLabel.text = [NSString stringWithFormat:@"在你前面还有%d位", [Util SharedInstance].orderPreCount];
        orderLeftTimeLabel.text = [NSString stringWithFormat:@"预计你的排队时间还剩%d秒", [Util SharedInstance].orderLeftMinutes];
        self.capture.delegate = nil;
        self.scanRectView.hidden = YES;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(timerHandle:)
                                               userInfo:nil
                                                repeats:YES];
    }
    else
    {
        orderInfoView.hidden = YES;
        self.capture.camera = self.capture.back;
        self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        self.capture.rotation = 90.0;
        self.capture.layer.frame = self.scanRectView.bounds;
        [self.scanRectView.layer addSublayer:self.capture.layer];
        self.capture.delegate = self;
        isScaned = NO;
    }
    
    
}

-(void)timerHandle:(id)obj
{
    [Util SharedInstance].orderLeftMinutes -= 1;
    orderLeftTimeLabel.text = [NSString stringWithFormat:@"预计你的排队时间还剩%d秒", [Util SharedInstance].orderLeftMinutes];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[Util SharedInstance].httpManager POST:@"http://192.168.99.215:8080/servers/cancelorder"
                                     parameters:@{@"orderid":[Util SharedInstance].orderUUID}
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            NSDictionary *retDict = responseObject;
                                            NSString *status = [retDict objectForKey:@"status"];
                                            if ([status isEqualToString:@"0"])
                                            {
                                                [UIView animateWithDuration:0.2
                                                                 animations:^{
                                                                     CGRect rect = orderInfoView.frame;
                                                                     rect.origin.y -= rect.size.height;
                                                                     orderInfoView.frame = rect;
                                                                     orderInfoView.alpha = 0;
                                                                 }
                                                                 completion:^(BOOL finished) {
                                                                     CGRect rect = orderInfoView.frame;
                                                                     rect.origin.y += rect.size.height;
                                                                     orderInfoView.frame = rect;
                                                                     orderInfoView.alpha = 1.0;
                                                                     orderInfoView.hidden = YES;
                                                                     self.scanRectView.hidden = NO;
                                                                     self.capture.camera = self.capture.back;
                                                                     self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
                                                                     self.capture.rotation = 90.0;
                                                                     self.capture.layer.frame = self.scanRectView.bounds;
                                                                     [self.scanRectView.layer addSublayer:self.capture.layer];
                                                                     self.capture.delegate = self;
                                                                     isScaned = NO;
                                                                     [[Util SharedInstance].foodList removeAllObjects];
                                                                     
                                                                     [[Util SharedInstance] updateOneOrderByOrderID:[Util SharedInstance].orderUUID deal:@"-1"];
                                                                     
                                                                     [Util SharedInstance].orderUUID = nil;
                                                                     [Util SharedInstance].selectRoom = nil;
                                                                     
                                                                     
                                                                 }];
                                            }
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            
                                        }];
        
    }
}

-(void)cancelOrderClick:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消排队" message:@"确认取消排队吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    orderInfoView = [[UIView alloc] initWithFrame:CGRectMake(10, 140, MAIN_SCREEN_WIDTH - 20, 220)];
    orderPerCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    orderLeftTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, MAIN_SCREEN_WIDTH - 20, 30)];
    orderCancelButton = [[UIButton alloc] initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH - 20 - 100)/2, 120, 100, 40)];
    [orderCancelButton setTitle:@"放弃排队" forState:UIControlStateNormal];
    [orderCancelButton setBackgroundColor:[UIColor colorWithRed:0.051 green:0.373 blue:1.000 alpha:1.000]];
    [orderCancelButton addTarget:self action:@selector(cancelOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [orderInfoView addSubview:orderPerCountLabel];
    [orderInfoView addSubview:orderLeftTimeLabel];
    [orderInfoView addSubview:orderCancelButton];
    [self.view addSubview:orderInfoView];
    orderInfoView.hidden = YES;
    
    self.capture = [[ZXCapture alloc] init];
    
}

-(void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
    if (!result)
    {
        return;
    }
    
    NSLog(@"QR decord! %@", result.text);
    AudioServicesPlaySystemSound(1106);
    
    if (!isScaned)
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderOptionViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        self.navigationController.navigationBar.hidden = NO;
        self.capture.delegate = nil;
        isScaned = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
