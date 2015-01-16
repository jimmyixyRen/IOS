//
//  Car.h
//  OCDemo
//
//  Created by rendl on 15/1/4.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString* (^hasCigaretteCallback)(BOOL hasCigartte);

@interface Car : NSObject
{
    @public//变量范围,继承相关
    NSString *n;
    float     p;

}

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) float      price;
@property (nonatomic, strong) NSString * production;

-(void)printCarInfo;

-(void)gotoMall:(NSString *)mallName callback:(hasCigaretteCallback)callback;

@end
