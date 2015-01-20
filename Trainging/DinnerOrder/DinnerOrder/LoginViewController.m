//
//  LoginViewController.m
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "LoginViewController.h"
#import "Util.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *tf_name;
@property (strong, nonatomic) IBOutlet UITextField *tf_pwd;

@end

@implementation LoginViewController
@synthesize tf_pwd,tf_name;
- (IBAction)hideKeyboard:(id)sender
{
    UITextField *tf = sender;
    [tf resignFirstResponder];
}

- (IBAction)btClick:(id)sender
{
    UIButton *bt = sender;
    if (bt.tag == 0)
    {
        [[Util SharedInstance].httpManager POST:@"http://192.168.99.215:8080/servers/login"
               parameters:@{@"name":tf_name.text, @"password":tf_pwd.text}
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSDictionary *dict = responseObject;
                      [Util SharedInstance].isLogined = YES;
                      [Util SharedInstance].userid = [dict objectForKey:@"id"];
                      [Util SharedInstance].username = tf_name.text;
                      [self.navigationController popViewControllerAnimated:YES];
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"%@", [error localizedDescription]);
                  }];

    }
    else
    {
    
    }
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
