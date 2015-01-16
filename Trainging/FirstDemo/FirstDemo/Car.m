//
//  Car.m
//  OCDemo
//
//  Created by rendl on 15/1/4.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import "Car.h"

@implementation Car
@synthesize  name = n, price = p, production, delegate;

-(void)printCarInfo
{
    NSLog(@"name:%@ price:%f production:%@", n, p, self.production);
}

-(void)gotoSomePlace:(NSString *)placeName
{
    NSLog(@"I arrive %@ and what can i do for you?", placeName);
    if ([delegate respondsToSelector:@selector(doSomeAction)])
    {
        [delegate doSomeAction];
    }
    
    if ([delegate respondsToSelector:@selector(doAntherAction)])
    {
        [delegate doAntherAction];
    }
}

@end
