//
//  FeatureController.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/4/9.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeatureControllerDelegate <NSObject>

@optional

-(void)featureControllerViewDismissBackToSourceController;


@end

@interface FeatureController : UIViewController

@property(nonatomic,assign)id<FeatureControllerDelegate> delegate;

@end
