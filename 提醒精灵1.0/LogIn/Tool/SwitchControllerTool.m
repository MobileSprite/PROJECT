//
//  SwitchControllerTool.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/2/12.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "SwitchControllerTool.h"
#import "ProgramTabBarController.h"

#import "CurrentToken.h"
#import "AccessTokenTool.h"

#import "ModelDataTool.h"
#import "DateModel.h"
#import "remainModel.h"
#import "EventDataTool.h"
#import "Define.h"

#define RemindTime -2.5*60*60

typedef enum timeInterval{
    onceTime = 1,
    everyday,
    everyweek
    
}TimeInterval;

@implementation SwitchControllerTool

+(void)chooseRootViewController
{
    CurrentToken *token = [AccessTokenTool getCurrentTokenFromFile];
    
    if (token)
    {
        NSLog(@"%@",token.current_access_token);
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        ProgramTabBarController *proVc = [story instantiateViewControllerWithIdentifier:@"mainController"];
        
        NSLog(@"%@",[UIApplication sharedApplication].keyWindow.rootViewController);
        NSLog(@"%@",[UIApplication sharedApplication].delegate.window.rootViewController);

        [UIApplication sharedApplication].delegate.window.rootViewController = proVc; /// 这句话在其他VC也可以用
        
#warning  根据表中的模型数据重新添加note-----
        [self setupDateCountNoteAddPart];
        
        [self setupEventRemindNoteAddPart];

    }
    
}

+(void)setupEventRemindNoteAddPart
{
    NSArray *eventModelArray = [EventDataTool allremainModel];
    if (eventModelArray.count)
    {
        for (remainModel *model in eventModelArray)
        {
            //add note;
//            [self addNoteWith:model];
            if (model.New == YES &&[UIApplication sharedApplication].scheduledLocalNotifications.count==0)
            {
                [self addEventNoteWith:model];

            }
        }
    }
}

+(void)addEventNoteWith:(remainModel *)model
{

        UILocalNotification *localNote = [[UILocalNotification alloc]init];
        
        localNote.timeZone = [NSTimeZone defaultTimeZone];
        
        localNote.soundName = model.music;

            localNote.alertAction = @"slideGo";
            localNote.alertBody = model.text;
            localNote.applicationIconBadgeNumber = 1;

        
#warning musicTime is unkown
//        localNote.fireDate = [NSDate dateWithTimeInterval:(musicTime+.5)*(no-1)+.5 sinceDate:model.date];
        localNote.fireDate = [NSDate dateWithTimeInterval:(6+.5)*(2-1)+.5 sinceDate:model.date];

        if (model.timesNum == everyday)
        {
            localNote.repeatInterval = NSCalendarUnitDay;
        }else if (model.timesNum == everyweek)
        {
            localNote.repeatInterval = NSCalendarUnitWeekday;
        }
        
        
//        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:inputDic];
    
        NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
        
        [userDic setValue:model.date forKey:@"date"];
        [userDic setValue:model.text forKey:@"text"];
        [userDic setValue:model.idenity forKey:@"idenity"];
        [userDic setValue:model.music forKey:@"music"];
        [userDic setValue:model.access_token forKeyPath:@"access_token"];
        [userDic setValue:[NSNumber numberWithBool:model.handOff] forKeyPath:@"handOff"];
        [userDic setValue:[NSNumber numberWithBool:model.New] forKeyPath:@"New"];
        [userDic setValue:[NSNumber numberWithInt:model.timesNum] forKeyPath:@"timesNum"];

        //                [userDic setObject:[NSNumber numberWithInt:musicTime] forKey:theMusicTime];
        [userDic setObject:[NSNumber numberWithInt:6] forKey:theMusicTime];
    
        [userDic setObject:@"message" forKey:RemaindIdenity];
        
        localNote.userInfo = userDic;
        
        [[UIApplication sharedApplication]scheduleLocalNotification:localNote];
        
    
}
/**
 *  @param 纪念日通知的添加
 */
+(void)setupDateCountNoteAddPart
{
    NSArray *timeModelArray = [ModelDataTool allDateModel];
    if (timeModelArray.count)
    {
        for (DateModel *model in timeModelArray)
        {
            //add note;
            [self addNoteWith:model];
        }
    }
}

+(void)addNoteWith:(DateModel*)model
{
    // string ==> data;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    NSDate *finalDate =[dateFormatter dateFromString:model.fireDate];
    
    UILocalNotification *localNote = [[UILocalNotification alloc]init];
    
    localNote.timeZone = [NSTimeZone defaultTimeZone];
    
    localNote.soundName = @"10000.caf";
    
    localNote.alertBody = [NSString stringWithFormat:@"明天%@,别忘喽,亲",model.dateText];
    
    localNote.alertAction = nil;
    
    localNote.applicationIconBadgeNumber = 1;
    
    localNote.repeatInterval = NSCalendarUnitYear;
    
    localNote.fireDate = [finalDate dateByAddingTimeInterval:RemindTime];
    
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    
    [userDic setValue:model.date forKey:@"date"];
    [userDic setValue:model.dateText forKey:@"dateText"];
    [userDic setValue:model.identity forKey:@"identity"];
    [userDic setValue:localNote.fireDate forKey:@"fireDate"];
    [userDic setValue:model.access_token forKeyPath:@"access_token"];
    
    [userDic setValue:@"dateCount" forKey:@"ID"];
    
    localNote.userInfo = userDic;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNote];
    
}

@end
