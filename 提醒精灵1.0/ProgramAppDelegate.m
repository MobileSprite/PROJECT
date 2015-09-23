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
#import "ProgramTabBarController.h"
#import "SwitchControllerTool.h"

#import "EventDataTool.h"
#import "remainModel.h"
#import "Reminder-Swift.h"

@interface ProgramAppDelegate ()<xAppDelegate>
{
    NSDate *date1;
    NSDate *date2;
    BOOL isAlert;
    
    NSUInteger noteCount;
    
}



@end

@implementation ProgramAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    BOOL hasLaunched = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunched2"];
    
    if (!hasLaunched) {
        
        NSString *version = [[UIDevice currentDevice] systemVersion];
        if ([version doubleValue] >= 9.0) {
            NSUserActivity *activity = [[NSUserActivity alloc]initWithActivityType:@"com.wrcj12138"];
            
            activity.keywords =[[NSSet alloc]initWithArray:@[@"纪念日",@"事项提醒",@"倒计时",@"事务提醒"]];
            activity.eligibleForSearch = YES;
            activity.title = @"你的生活提醒助手";
            
            
            self.userActivity = activity;
            activity.eligibleForHandoff = NO;
            
            [activity becomeCurrent];
            
        }
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        PageViewController *pageViewController = (PageViewController *)[story instantiateViewControllerWithIdentifier:@"PageViewController"];
        
        [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        
        [UIApplication sharedApplication].delegate.window.rootViewController = pageViewController; /// 这句话在其他VC也可以用

    }
    
    xViewController *controller =[[xViewController alloc]init];
        controller.delegate =self;
        
    [SwitchControllerTool chooseRootViewController];
    
    
    
     UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:40/255.0 green:155/255.0 blue:232/255.0 alpha:1.0]}];

    
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
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        /*
         UIUserNotificationTypeNone    = 0,      不发出通知
         UIUserNotificationTypeBadge   = 1 << 0, 改变应用程序图标右上角的数字
         UIUserNotificationTypeSound   = 1 << 1, 播放音效
         UIUserNotificationTypeAlert   = 1 << 2, 是否运行显示横幅
         */
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
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
    
    if (isAlert) {
        [self SetController];
    }
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
//        UITabBarController *tabViewC = (UITabBarController *)self.window.rootViewController;
//        UINavigationController *navigationC = (UINavigationController *) tabViewC.viewControllers[1];
        
#warning ----dateCount update----------
        
        NSLog(@"------------1002----------");
        
    }
    
    if (alertView.tag == 1003)
    {
        
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
}
-(void)SetController
{
    isAlert =YES;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ProgramTabBarController *proVc = [story instantiateViewControllerWithIdentifier:@"countcontroller"];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = proVc; /// 这句话在其他VC也可以用
}



@end
