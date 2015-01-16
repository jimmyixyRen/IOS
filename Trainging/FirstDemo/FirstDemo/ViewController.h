//
//  ViewController.h
//  FirstDemo
//
//  Created by rendl on 15/1/4.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionProtocol.h"


@interface ViewController : UIViewController


@property(nonatomic, assign) id<ActionProtocol> delegate;//代理模式 用assign的原因是 delegate并不是对象拥有者它只是简单的指向对象, 这种模式会在界面开发中大量用到

@end

