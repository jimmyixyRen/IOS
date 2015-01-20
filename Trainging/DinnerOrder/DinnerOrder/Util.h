//
//  Util.h
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define MAIN_SCREEN_WIDTH           [[UIScreen mainScreen] applicationFrame].size.width

#define MAIN_SCREEN_HTIGHT          [[UIScreen mainScreen] applicationFrame].size.height

@interface Util : NSObject

@property(nonatomic, strong)AFHTTPRequestOperationManager *httpManager;
@property(nonatomic, copy) NSString *userid;
@property(nonatomic, copy)NSString *username;
@property(nonatomic, assign)BOOL  isLogined;


+(Util *)SharedInstance;

@end
