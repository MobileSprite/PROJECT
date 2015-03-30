//
//  SettingViewCell.h
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"

@interface SettingViewCell : UITableViewCell

@property(strong,nonatomic)SettingItem *item;

+(instancetype)setupCellWithTableView:(UITableView *)tableView;

@end
