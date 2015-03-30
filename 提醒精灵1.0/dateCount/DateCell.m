//
//  DateCell.m
//  纪念日提醒
//
//  Created by zjsruxxxy3 on 14-11-1.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "DateCell.h"
#import "NSDate+DateCount.h"


#define aYear 31536000.0
#define aDay 86400.0

@implementation DateCell


+(instancetype)dateCellWithTable:(UITableView *)table
{
    static NSString *cellID = @"myCell";
    
    DateCell *cell = [table dequeueReusableCellWithIdentifier:cellID];

    return cell;
    
}

-(void)setModel:(DateModel *)model
{
    self.MainLabel.text = [NSString stringWithFormat:@"%@,还有",model.dateText];
    self.MainLabel.textColor=[UIColor blackColor];
//    self.MainLabel.superview.backgroundColor =[UIColor redColor];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",(int)([NSDate dateCountWithTheDate:[dateFormatter dateFromString:model.date]]+1)];
//    self.countLabel.font =[UIFont systemFontOfSize:12];
    self.countLabel.textColor=[UIColor whiteColor];
    
    self.tinyLabel.text = [NSString stringWithFormat:@"%@天",self.countLabel.text];
    self.tinyLabel.textColor= [UIColor blackColor];
    int days = ([NSDate dateCountWithTheDate:[dateFormatter dateFromString:model.date]]+1);
    
    
    int width = 320*days/365;
    if (width >=320)
    {
        width = 320;
    }
    
    CGRect temp = self.bgView.frame;
    
    temp.size.width = width;
    
    self.bgView.frame = temp;
    

}


- (void)awakeFromNib
{
    // Initialization code
    
    [self addDividerLineInCell];
    
    
}

-(void)layoutSubviews
{
    
    
    [super layoutSubviews];
    
    CGFloat x = 2;
    CGFloat y = self.frame.size.height-2;
    CGFloat h = 2;
    CGFloat w = self.frame.size.width-4;
    
    [self addDividerLineFrame:CGRectMake(x, y, w, h)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - addDivderCode

-(void)addDividerLineInCell
{
    UIView *divider = [[UIView alloc]init];
    
    divider.backgroundColor = [UIColor colorWithRed:94/255.0 green:166/255.0 blue:220/255.0 alpha:1];
    
    divider.alpha = .618;
    
    [self.contentView addSubview:divider];
    
    self.divider = divider;  // 获得分割线;
}

-(void)addDividerLineFrame:(CGRect)frame;
{
    
    
    self.divider.frame = frame;
    
}


@end
