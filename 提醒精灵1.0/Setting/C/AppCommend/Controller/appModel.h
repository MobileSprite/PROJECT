//
//  appModel.h
//  提醒精灵1.0
//
//  Created by Dee on 15/3/30.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;


-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)appWithDic:(NSDictionary *)dic;

@end
