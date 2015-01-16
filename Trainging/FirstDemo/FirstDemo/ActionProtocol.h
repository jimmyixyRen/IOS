//
//  ActionProtocol.h
//  OCDemo
//
//  Created by rendl on 15/1/5.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActionProtocol <NSObject>

@required//必须实现的
-(void)doSomeAction;

@optional//可选实现
-(void)doAntherAction;

@end
