//
//  TimesModle.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-18.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "TimesModle.h"

@implementation TimesModle

+(instancetype)timesModelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
    
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
}


@end
