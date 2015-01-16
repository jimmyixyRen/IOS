//
//  Car.h
//  OCDemo
//
//  Created by rendl on 15/1/4.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionProtocol.h"

@interface Car : NSObject
{
    @public//变量范围,继承相关
    NSString *n;
    float     p;

}

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) float      price;
@property (nonatomic, strong) NSString * production;

@property (nonatomic, assign) id<ActionProtocol> delegate;//delegate就是代理 这个玩意在控件或者cocoa api中大量存在 比较重要

-(void)printCarInfo;

-(void)gotoSomePlace:(NSString *)placeName;
@end
