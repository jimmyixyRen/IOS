//
//  RoomListViewController.h
//  DinnerOrder
//
//  Created by rendl on 15/1/20.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface RoomListViewController : UIViewController

@end

@interface RoomTableCell : UITableViewCell
{
    UILabel *lbName;
    UILabel *lbRemark;
    UILabel *lbPersonCount;
    UILabel *lbDeskCount;
}

-(void)setRoomInfo:(Room *)room;

@end
