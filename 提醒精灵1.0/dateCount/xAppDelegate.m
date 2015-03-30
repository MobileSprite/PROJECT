//
//  xAppDelegate.m
//  倒数计时2.0
//
//  Created by Dee on 14-12-9.
//  Copyright (c) 2014年 zjsruxxxy7. All rights reserved.
//

#import "xAppDelegate.h"
#import "xViewController.h"


@interface xAppDelegate ()
{
    
    
    xViewController *  rootVc;
    
//    NSInteger  record;
    
    NSDate *date1;
    NSDate *date2;
    
}


@end

@implementation xAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
   rootVc =(xViewController *)self.window.rootViewController;
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
   
   // [rootVc pauseLayer:rootVc.arcLayer];
    NSLog(@"%@",rootVc.notification.fireDate);
    //不关闭进入后台
    if (rootVc.timer!=nil) {
        [rootVc.timer invalidate];
        rootVc.timer=nil;
        
       date1 =[NSDate date];
    
    
    }
   // rootVc.arcLayer.lineWidth =5;
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //date2 =[NSDate date];
    
    //
    if (date1 !=nil) {
    
        
        NSTimeInterval  interval =[[NSDate date] timeIntervalSinceDate:date1];
        NSLog(@"%f间隔",interval);
     
        
        rootVc.totlaTime =rootVc.totlaTime - interval;
        rootVc.timerLable.tag  =rootVc.totlaTime;
        
        [rootVc  reStart];
        
          date1=nil;
        
        
    
        if (rootVc.arcBgView.layer.sublayers.count>=2) {
            
            [[rootVc.arcBgView.layer.sublayers lastObject]removeFromSuperlayer];
            
        }
    
        
       [rootVc drawRound];
        
        rootVc.arcBgView.alpha =1;
    }
/*
 NSLog(@"beginTime 1== %f",rootVc.arcLayer.beginTime);
  [rootVc pauseLayer:rootVc.arcLayer];
            CFTimeInterval time =[rootVc.arcLayer convertTime:CACurrentMediaTime() fromLayer:nil];
            
           
            rootVc.arcLayer.beginTime =time;
 rootVc.arcLayer.timeOffset =20;
NSLog(@"beginTime == %f",rootVc.arcLayer.beginTime);
 [rootVc resumeLayer:rootVc.arcLayer interval:10];

*/
//    else if(date1==nil&&rootVc.timerLable.tag!=0) {
//
//[rootVc resumeLayer:rootVc.arcLayer interval:0];
    
    
        
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
