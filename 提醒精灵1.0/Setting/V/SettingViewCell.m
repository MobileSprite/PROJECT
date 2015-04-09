//
//  SettingViewCell.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "SettingViewCell.h"

@implementation SettingViewCell

+(instancetype)setupCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    SettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[SettingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(SettingItem *)item
{
    _item = item;
    
    /**
     *  add others;
     */
    
    [self setUpLeftView];
    
    [self setUpRightView];
    
    if (item.controllerClass)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    
    frame.size.width -= 10;
    
    [super setFrame:frame];
    

}

-(void)setUpLeftView
{
    self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    
    [self.textLabel setTextColor:[UIColor blackColor]];
    

    self.textLabel.text = self.item.title;
    
    if (self.item.icon)
    {
        self.imageView.image = [UIImage imageNamed:self.item.icon];

    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLog(@"%@",NSStringFromCGRect(self.frame));
}

-(void)setUpRightView
{
    
}
@end
