//
//  TimesModle.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-18.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimesModle : NSObject


@property(nonatomic,copy)NSString *times;

@property(nonatomic,assign)int num;



+(instancetype)timesModelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
