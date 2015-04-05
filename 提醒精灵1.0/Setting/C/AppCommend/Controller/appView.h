//
//  appView.h
//  提醒精灵1.0
//
//  Created by Dee on 15/3/30.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "appModel.h"
@interface appView : UIView
@property(nonatomic,weak)appModel *app;

//+ (instancetype)appView;

+(instancetype)appViewWithAppModel:(appModel*)app;



@end
