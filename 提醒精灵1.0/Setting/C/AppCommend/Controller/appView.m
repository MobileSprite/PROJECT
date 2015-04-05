//
//  appView.m
//  提醒精灵1.0
//
//  Created by Dee on 15/3/30.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "appView.h"
@interface appView ()
@property (weak, nonatomic) IBOutlet UIButton *appView;

@property (weak, nonatomic) IBOutlet UILabel *labelView;



@end



@implementation appView




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(instancetype)appViewWithAppModel:(appModel*)appModel
{
    NSBundle *bundle =[NSBundle mainBundle];
    NSArray *objs =[bundle loadNibNamed:@"appView" owner:nil options:nil];
    appView *appView =[objs lastObject];
    appView.app=appModel;
    
    
    return appView;
}
-(void)setApp:(appModel *)app
{
    _app =app;
    [self.appView setImage:[UIImage imageNamed:app.icon] forState:UIControlStateNormal];
    self.labelView.text=app.name;
    
}
+ (instancetype)appView
{
    return [self appViewWithAppModel:nil];
}

@end
