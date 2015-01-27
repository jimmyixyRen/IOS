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

-(void)saveValueToProfile:(id)value key:(id)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
}

-(id)getValueFromProfileByKey:(id)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return  [defaults valueForKey:key];
}

static Util *Instance;
+(Util *)SharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//GCD
        Instance = [[Util alloc] init];
        Instance.foodList = [[NSMutableArray alloc] initWithCapacity:0];
        Instance.httpManager = [AFHTTPRequestOperationManager manager];
        Instance.httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        Instance.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        Instance.isLogined = NO;
    });
    return Instance;
}

@end
