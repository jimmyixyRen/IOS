//
//  Util.h
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Room.h"

#define MAIN_SCREEN_WIDTH           [[UIScreen mainScreen] bounds].size.width
#define MAIN_SCREEN_HTIGHT          [[UIScreen mainScreen] bounds].size.height
#define DEFAULT_LOGIN_NAME          @"default_login_name"
#define DEFAULT_LOGIN_PWD           @"default_lgoin_pwd"

@interface Util : NSObject

-(void)saveValueToProfile:(id)value key:(id)key;
-(id)getValueFromProfileByKey:(id)key;

@property(nonatomic, strong)AFHTTPRequestOperationManager *httpManager;
@property(nonatomic, copy) NSString *userid;
@property(nonatomic, copy)NSString *username;
@property(nonatomic, assign)BOOL  isLogined;
@property(nonatomic, strong)Room *selectRoom;
@property(nonatomic, strong) NSMutableArray *foodList;
@property(nonatomic, copy)NSString *orderUUID;
@property(nonatomic, assign)int orderLeftMinutes;
@property(nonatomic, assign)int orderPreCount;
+(Util *)SharedInstance;

@end
