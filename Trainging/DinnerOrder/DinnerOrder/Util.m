//
//  Util.m
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "Util.h"

@implementation Util
@synthesize httpManager;

static Util *Instance;
+(Util *)SharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//GCD
        Instance = [[Util alloc] init];
        Instance.httpManager = [AFHTTPRequestOperationManager manager];
        Instance.httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        Instance.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        Instance.isLogined = NO;
    });
    
    return Instance;
}

@end
