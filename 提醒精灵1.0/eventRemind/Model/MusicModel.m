//
//  MusicModel.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-11.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

+(instancetype)musicModelWithDic:(NSDictionary *)dic
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
