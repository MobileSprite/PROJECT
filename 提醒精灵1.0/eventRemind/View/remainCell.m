//
//  remainCell.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-9-27.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "remainCell.h"
#import "remainModel.h"

@class remainCell;

@implementation remainCell



+(remainCell *)remainCellToTableView:(UITableView *)tableView
{
    static NSString *string = @"cell2";
    
    remainCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell)
    {
        
        cell = [[NSBundle mainBundle]loadNibNamed:@"remainCell" owner:self options:nil][1]; // nsarray
        
    }
    
    return cell;
}




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"111111111");
    }
    return self;
}

- (void)awakeFromNib
{
    
    [self addSwitchButton];
    
    [self addDividerLineInCell];

}

-(void)addSwitchButton
{
    SevenSwitch * mySwitch2 = [[SevenSwitch alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    mySwitch2.onImage = [UIImage imageNamed:@"check.png"];
    
    //    mySwitch2.onColor= [UIColor colorWithRed:27/255.0 green:131/255.0 blue:231/255.0 alpha:1];
    mySwitch2.onColor = [UIColor colorWithRed:94/255.0 green:166/255.0 blue:220/255.0 alpha:1];
    //    mySwitch2.onColor = [UIColor colorWithHue:0.08f saturation:0.74f brightness:1.00f alpha:1.00f];
    
    mySwitch2.isRounded = NO;
    
    [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.rectSwitch = mySwitch2;
    
    [self.contentView addSubview:mySwitch2];
    
}
/**
 *  frame 设置  最准确
 */

-(void)layoutSubviews
{
    [super layoutSubviews];
    


    self.rectSwitch.center = CGPointMake(20+15,33);
    

    /**
     *  addDividerLineFrame
     */
    
    CGFloat x = 4;
    CGFloat y = self.frame.size.height-2;
    CGFloat h = 2;
    CGFloat w = self.frame.size.width-8;
    
    [self addDividerLineFrame:CGRectMake(x, y, w, h)];
    
}

- (void)switchChanged:(SevenSwitch *)sender
{
    NSLog(@"%d",sender.on);
    
    if ([self.delegate respondsToSelector:@selector(changedSwithInRemainCell:)])
    {
        [self.delegate changedSwithInRemainCell:self];
    }
//    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
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
