//
//  WeiBoViewController.h
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiBoViewController;

@protocol WeiBoDismissControllerDeleagte <NSObject>

@optional
-(void)dismissController:(WeiBoViewController *)controller;


@end
@interface WeiBoViewController : UIViewController

@property(nonatomic,assign)id<WeiBoDismissControllerDeleagte> delegate;

@end
