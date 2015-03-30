//
//  DateCell.h
//  纪念日提醒
//
//  Created by zjsruxxxy3 on 14-11-1.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateModel.h"

@interface DateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *MainLabel;

@property (weak, nonatomic) IBOutlet UILabel *tinyLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property(weak,nonatomic)UIView *divider;


@property(strong,nonatomic)DateModel *model;



+(instancetype)dateCellWithTable:(UITableView *)table;

@end
