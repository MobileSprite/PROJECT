//
//  remainCell.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-9-27.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SevenSwitch.h"

@class remainModel,remainCell,MusicModel;

@protocol remainCellDelegate <NSObject>

@optional

-(void)changedSwithInRemainCell:(remainCell *)cell;


@end

@interface remainCell : UITableViewCell
{
    
}

@property(strong,nonatomic)remainModel *models;

@property(strong,nonatomic)MusicModel *musicModels;


@property(weak,nonatomic)UIView *divider;

@property(copy,nonatomic)NSString *musicNo;

@property(assign,nonatomic)BOOL handleOff;

@property(weak,nonatomic)IBOutlet UILabel *dateLabel;

@property(weak,nonatomic)IBOutlet UILabel *textView;

@property(weak,nonatomic)IBOutlet UILabel *musicLabel;

@property(nonatomic,weak)IBOutlet UIButton *repeatButton;

@property(nonatomic,weak)SevenSwitch * rectSwitch;


@property(nonatomic,assign)id<remainCellDelegate> delegate;




+(remainCell *)remainCellToTableView:(UITableView *)tableView;


@end
