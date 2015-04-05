//
//  appModel.m
//  提醒精灵1.0
//
//  Created by Dee on 15/3/30.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "appModel.h"

@implementation appModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self =[super init]) {
        self.name=dic[@"name"];
        self.icon=dic[@"icon"];
    }
    return  self;
}
+(instancetype)appWithDic:(NSDictionary *)dic
{
    return  [[self alloc]initWithDic:dic];
}


@end
