//
//  NSDate+DateCount.h
//  CountDate
//
//  Created by zjsruxxxy3 on 14-11-1.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateCount)


+(double)dateCountWithTheDate:(NSDate *)aDate;

+(NSDate *)dateTheYearWithTheDate:(NSDate *)aDate;

+(NSString *)dateWeekInTheDate:(NSDate *)aDate;

+(NSDate *)setFireDateWithTheDate:(NSDate *)aDate;

@end
