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


int add(int val1, int val2)
{
    return val1 + val2;
}

-(NSNumber *)oc_add:(NSNumber * )val1 val2:(NSNumber * )val2
{
    return @(val1.intValue + val2.intValue);
}
-(void)testSelector
{
    //C的函数指针
    int (* c_func)(int, int);
    c_func = add;
    NSLog(@"add result:%d", c_func(1, 2));
    
    //@selector
    SEL addSel = @selector(oc_add:val2:);
    NSNumber *result = [self performSelector:addSel withObject:@(1) withObject:@(2)];
    NSLog(@"oc add result:%d", result.intValue);
}

@end
