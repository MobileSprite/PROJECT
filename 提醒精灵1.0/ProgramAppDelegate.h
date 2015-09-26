//
//  ProgramAppDelegate.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-9-24.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramAppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{
    NSString * musicName ;
    
    UILocalNotification * Appnote;

    
}



@property (strong, nonatomic) UIWindow *window;

@property(assign,nonatomic)int noteNumber;

@end
