//
//  NSDate+DateCount.m
//  CountDate
//
//  Created by zjsruxxxy3 on 14-11-1.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "NSDate+DateCount.h"
#define aYear 31536000
#define aDay 86400

@implementation NSDate (DateCount)

+(double)dateCountWithTheDate:(NSDate *)aDate
{
    
    NSDate *nowT = [NSDate date];
    
    
    NSDateFormatter *yearF = [[NSDateFormatter alloc]init];
    yearF.dateFormat = @"yyyy";
    
    NSDateFormatter *monthDayF = [[NSDateFormatter alloc]init];
    
    monthDayF.dateFormat = @"MMdd";
    
    
    NSString *oldYear = [yearF stringFromDate:aDate];
    
    NSString *newYear = [yearF stringFromDate:[NSDate date]];
    
    
    int distance = [newYear intValue] - [oldYear intValue];
    
    int time = [[monthDayF stringFromDate:aDate]intValue];
    int nowTime = [[monthDayF stringFromDate:[NSDate date]]intValue];
    
    NSDate *newDate;
    NSTimeInterval interval;
    
    int tag = 0;
    
    for (int a= [oldYear intValue]; a<= [newYear intValue]; a++)
    {
        if (((a)%4 == 0 && (a)%100 != 0) || (a)%400 == 0)
        {
            tag ++;
        }
    }

    if (distance >= 0)
    {
        if (time > nowTime)
        {
            newDate = [aDate dateByAddingTimeInterval:(distance*aYear)+tag*aDay];
  
        }else
        {
            newDate = [aDate dateByAddingTimeInterval:((1+distance)*aYear)+tag*aDay];
  
        }
        
        interval = [newDate timeIntervalSinceDate:nowT];

    }else
    {
        
        interval = [aDate timeIntervalSinceDate:nowT];
    }
    
    return fabs(round(interval/aDay));
}

+(NSDate *)setFireDateWithTheDate:(NSDate *)aDate
{
    NSDate *nowDate = [NSDate date];
    
    NSDate *fireDate = nil;
    
    NSDateFormatter *yearF = [[NSDateFormatter alloc]init];
    yearF.dateFormat = @"yyyy";
    
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    newDateFormatter.dateFormat = @"yyyyMMdd";
    NSString *nowDay = [newDateFormatter stringFromDate:nowDate];
    
    NSDateFormatter *oldDateFormatter = [[NSDateFormatter alloc]init];
    oldDateFormatter.dateFormat = @"MMdd";
    NSString *oldDay = [oldDateFormatter stringFromDate:aDate];
    
    NSRange range = NSMakeRange(4, 4);
//    NSLog(@"%@",[nowDay substringWithRange:range]);
    
    NSString *fireDay =[nowDay stringByReplacingCharactersInRange:range withString:oldDay];
    
    fireDate = [newDateFormatter dateFromString:fireDay];
    
    
    NSComparisonResult result =[aDate compare:nowDate];
    switch (result)
    {
        case NSOrderedAscending:
        case NSOrderedSame:
            
            
            break;
            
        default:
            
            fireDate = aDate;
            break;
    }
    
    
    
    return fireDate;
}

+(NSDate *)dateTheYearWithTheDate:(NSDate *)aDate
{
    
    NSDate *nowT = [NSDate date];
    
    NSDateFormatter *yearF = [[NSDateFormatter alloc]init];
    yearF.dateFormat = @"yyyy";
    
    NSDateFormatter *monthDayF = [[NSDateFormatter alloc]init];
    
    monthDayF.dateFormat = @"MMdd";
    
    
    NSString *oldYear = [yearF stringFromDate:aDate];
    
    NSString *newYear = [yearF stringFromDate:nowT];
    
    
    int distance = [newYear intValue] - [oldYear intValue];
    
    int time = [[monthDayF stringFromDate:aDate]intValue];
    
    int nowTime = [[monthDayF stringFromDate:[NSDate date]]intValue];
    
    NSDate *newDate;

    if (distance > 0)
    {
        int tag = 0;
        
        for (int a= [oldYear intValue]; a<= [newYear intValue]; a++)
        {
            if (((a)%4 == 0 && (a)%100 != 0) || (a)%400 == 0)
            {
                tag ++;
            }
        }
        
        if (time > nowTime)
        {
            newDate = [aDate dateByAddingTimeInterval:(distance*aYear)+tag*aDay];
            
        }else
        {
            newDate = [aDate dateByAddingTimeInterval:((1+distance)*aYear)+tag*aDay];
            
        }
        
    }else if (distance < 0)
    {
        newDate = aDate;
        
    }else
    {
        if (time > nowTime)
        {
            newDate = [aDate dateByAddingTimeInterval:distance*aYear];
            
        }else
        {
            newDate = [aDate dateByAddingTimeInterval:(1+distance)*aYear];
        }
    }
    
    return newDate;
    
}

+(NSString *)dateWeekInTheDate:(NSDate *)aDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [dateFormatter stringFromDate:aDate];
    
    
    NSArray *a = [dateString componentsSeparatedByString:@"-"];
    
    NSString *year = a[0];
    NSString *month = a[1];
    NSString *day = a[2];
    
    int m,y,d,w;
    
    if ([month intValue] == 1 || [month intValue] == 2)
    {
        m =[month intValue]+12;
        y = [year intValue]-1;
        
    }else
    {
        m = [month intValue];
        y = [year intValue];
        
    }
    
    d = [day intValue];
    
    w = (d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7;
    
    NSString *week = [NSString string];
    
    
    switch (w+1)
    {
            
        case 1:
            week = @"星期一";
            break;
        case 2:
            week = @"星期二";
            break;
        case 3:
            week = @"星期三";
            break;
        case 4:
            week = @"星期四";
            break;
        case 5:
            week = @"星期五";
            break;
        case 6:
            week = @"星期六";
            break;
        case 7:
            week = @"星期天";
            break;
            
        default:
            break;
    }
    
    return week;
    
}

@end
