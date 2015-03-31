//
//  ProgramAppDelegate.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-9-24.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "ProgramAppDelegate.h"
#import "ProgramViewController.h"
#import "xViewController.h"
#import "Define.h"
#import "MyAudioTool.h"
#import "MusicModel.h"

#import "SwitchControllerTool.h"

#import "EventDataTool.h"
#import "remainModel.h"

@interface ProgramAppDelegate ()
{
    NSDate *date1;
    NSDate *date2;
    
    NSUInteger noteCount;
    
}



@end

@implementation ProgramAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [self.window makeKeyAndVisible];
//    self.window.rootViewController = logViewController;
    
    
    [SwitchControllerTool chooseRootViewController];
    
    noteCount = [application scheduledLocalNotifications].count;
    
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey])
    {
        UILocalNotification *localNote = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
        
        NSDictionary *noteDic = localNote.userInfo;
        
        [MyAudioTool playSound:noteDic[theMusic]];
        
        if ([noteDic[RemaindIdenity] isEqualToString:@"message"])
        {
            UITabBarController *tabViewC = (UITabBarController *)self.window.rootViewController;
            
            UINavigationController *navigationC = (UINavigationController *) tabViewC.viewControllers[0];
            
            ProgramViewController *rootVc =(ProgramViewController *)navigationC.topViewController;
            
            rootVc.canReload = YES;
            
            [rootVc.tabelView reloadData];
            
            NSString *string = [NSString stringWithFormat:@"%@",noteDic[theText]];
            
            UIAlertView *alertNote = [[UIAlertView alloc]initWithTitle:@"提醒" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            alertNote.tag = 1111;
            
            [alertNote show];
            
        }
        
    }else
    {
#pragma mark - 解决未去处理的事件事件，修改其值
        
        if ([[NSFileManager defaultManager]fileExistsAtPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"current_access_token.dat"]])
        {
            NSArray *array = [EventDataTool allremainModel];
            
            for (remainModel *model in array)
            {
                if ([model.date compare:[NSDate dateWithTimeIntervalSinceNow:10]]<0 && model.timesNum == 1)
                {
                    model.New = 0;
                    model.handOff = YES;
                    
                    [EventDataTool modifyDBModel:model];
                    
                }
            }
        }
    }
    
    

    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UITabBarController *tabViewC = (UITabBarController *)self.window.rootViewController;

 
    NSDictionary *noteDic = notification.userInfo;
    
    
    musicName = [NSString stringWithFormat:@"%@",notification.soundName];
    
    [MyAudioTool removeSound:musicName];
    
#warning messageNote---------
    
    if ([noteDic[RemaindIdenity] isEqualToString:@"message"])
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

        NSString *string = [NSString stringWithFormat:@"%@",noteDic[theText]];
        
        UIAlertView *alertNote = [[UIAlertView alloc]initWithTitle:@"提醒" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        switch ([noteDic[theTimesNum] intValue])
        {
            case 1:
                alertNote.tag = 1011; //1
                break;
                
            case 2:
                alertNote.tag = 1021;//2
                break;
                
            case 3:
                alertNote.tag = 1031;//3
                break;
            default:
                break;
        }
        
        [alertNote show];
        
        [MyAudioTool playSound:musicName];
        
        for (UILocalNotification * oldNote in [UIApplication sharedApplication].scheduledLocalNotifications)
        {
            NSDictionary * oldDic = oldNote.userInfo;
            
            if ([noteDic[theIdenity]isEqualToString:oldDic[theIdenity]])
            {
                if ([oldDic[theTimesNum]intValue] == 0)
                {
                    [[UIApplication sharedApplication] cancelLocalNotification:oldNote];
                }
                
            }
        }

    }
    
#warning dateCount-----------
    
    if ([noteDic[RemaindIdenity] isEqualToString:@"dateCount"])
    {
        // selecte DateCountController
        
        [tabViewC setSelectedIndex:1];
        
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        NSString *string = [NSString stringWithFormat:@"%@",noteDic[@"dateText"]];
        
        UIAlertView *alertNote = [[UIAlertView alloc]initWithTitle:@"提醒" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertNote show];
        
        [MyAudioTool playSound:musicName];
        
    }
    
#warning timeCount------------
    
    if ([noteDic[RemaindIdenity] isEqualToString:@"timeCount"])
    {
        // selecte DateCountController
        
        [tabViewC setSelectedIndex:2];
        
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        
        [MyAudioTool playSound:musicName];
        
    }
    
   
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
 
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    


#pragma mark countTime
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"current_access_token.dat"]])
    {
        UITabBarController *tabViewC = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *navigationC = (UINavigationController *) tabViewC.viewControllers[2];
        
        xViewController *xVController =(xViewController *)navigationC.topViewController;
        
        //    NSLog(@"%@",rootVc.notification.fireDate);
        
        //不关闭进入后台
        
        if (xVController.timer!=nil)
        {
            [xVController.timer invalidate];
            xVController.timer=nil;
            
            date1 =[NSDate date];
            
        }
    }

     
    

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
#pragma mark 只通过点击app图标启动-
    if (application.scheduledLocalNotifications.count != noteCount)
    {
        NSArray *array = [EventDataTool allremainModel];
        
        for (remainModel *model in array)
        {
            if ([model.date compare:[NSDate dateWithTimeIntervalSinceNow:10]]<0 && model.timesNum == 1)
            {
                model.New = 0;
                model.handOff = YES;
                
                [EventDataTool modifyDBModel:model];
                
            }
        }
    }

    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{


    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"current_access_token.dat"]])
    {
        
#pragma mark countTime
        
        UITabBarController *tabViewC = (UITabBarController *)self.window.rootViewController;

        UINavigationController *navigationC2 = (UINavigationController *) tabViewC.viewControllers[2];
        
        xViewController *xVController =(xViewController *)navigationC2.topViewController;
        
        
        if (date1 !=nil) {
            
            
            NSTimeInterval  interval =[[NSDate date] timeIntervalSinceDate:date1];
            NSLog(@"%f间隔",interval);
            
            
            xVController.totlaTime =xVController.totlaTime - interval;
            xVController.timerLable.tag  =xVController.totlaTime;
            
            [xVController  reStart];
            
            date1=nil;
            
            if (xVController.arcBgView.layer.sublayers.count>=2) {
                
                [[xVController.arcBgView.layer.sublayers lastObject]removeFromSuperlayer];
                
            }
            
            [xVController drawRound];
            
            xVController.arcBgView.alpha =1;
        }
        
        UINavigationController *navigationC = (UINavigationController *) tabViewC.viewControllers[0];
        
        ProgramViewController *rootVc =(ProgramViewController *)navigationC.topViewController;
        
        rootVc.canReload = YES;
        
        [rootVc.tabelView reloadData];
        
    }


     
   

    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{


    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    
    
    [MyAudioTool removeSound:musicName];

    if (alertView.tag >1010)
    {
        //可能window的rootViewController错误
        
        UITabBarController *tabViewC = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *navigationC = (UINavigationController *) tabViewC.viewControllers[0];
        
        ProgramViewController *rootVc =(ProgramViewController *)navigationC.topViewController;
        
        if (alertView.tag == 1011)
        {
            rootVc.canReload = YES;
            
            [rootVc.tabelView reloadData];
            
        }

    }
    
    
    if (alertView.tag == 1002)
    {
        UITabBarController *tabViewC = (UITabBarController *)self.window.rootViewController;

        UINavigationController *navigationC = (UINavigationController *) tabViewC.viewControllers[1];
        
#warning ----dateCount update----------
        
        NSLog(@"------------1002----------");
        
    }
    
    if (alertView.tag == 1003)
    {
        
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
}



@end
