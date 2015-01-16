//
//  Car.m
//  OCDemo
//
//  Created by rendl on 15/1/4.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "Car.h"

@implementation Car
@synthesize  name = n, price = p, production;

-(void)printCarInfo
{
    NSLog(@"name:%@ price:%f production:%@", n, p, self.production);
}

-(void)gotoMall:(NSString *)mallName callback:(hasCigaretteCallback)callback
{
    NSLog(@"我到了%@, 这里没烟", mallName);
    NSString *msg = callback(NO);
    NSLog(@"%@", msg);
}


@end
