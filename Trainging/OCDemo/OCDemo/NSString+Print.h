//
//  NSString+Print.h
//  FirstDemo
//
//  Created by rendl on 15/1/5.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <Foundation/Foundation.h>

//类目种只能加方法 不能加属性或成员变量 可以覆盖旧方法但会非常危险!不到必要的时候不用覆盖已存在的方法
@interface NSString (Print)

-(void)print;

@end
