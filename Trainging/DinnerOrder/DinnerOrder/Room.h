//
//  Room.h
//  Test
//
//  Created by rendl on 15/1/19.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject
@property(nonatomic, assign) int tid;
@property (nonatomic, strong)NSString *name;
@property(nonatomic, strong) NSString *peroncount;
@property(nonatomic, strong) NSString *tablecount;
@property(nonatomic, strong) NSString *remark;
@end
