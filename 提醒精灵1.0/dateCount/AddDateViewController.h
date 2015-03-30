//
//  AddDateViewController.h
//  纪念日提醒
//
//  Created by zjsruxxxy3 on 14-11-1.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateModel.h"
#import "ModelDataTool.h"

@class AddDateViewController;

@protocol AddDateViewControllerDelegate <NSObject>

@optional

-(void)addDateViewControllerClick:(AddDateViewController *) addVc AndTheModel:(DateModel *)model;

@end

@interface AddDateViewController : UIViewController


@property(nonatomic,weak)id<AddDateViewControllerDelegate> delegate;

@property(nonatomic,strong)DateModel *model;

@property(nonatomic,strong)NSMutableArray *dateModels;


@end
