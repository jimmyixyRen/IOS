//
//  FoodListViewController.h
//  DinnerOrder
//
//  Created by rendl on 15/1/22.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface FoodListViewController : UIViewController

@end

@interface FoodTableviewCell: UITableViewCell
{
    UILabel *lbFoodName;
    UILabel *lbFoodPrice;
    UILabel *lbRemark;
}
-(void)updateFoodInfo:(Food *) food;
@end