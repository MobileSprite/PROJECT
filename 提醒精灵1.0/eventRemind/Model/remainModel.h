//
//  remainModel.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-9-26.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface remainModel : NSObject

@property(copy,nonatomic)NSString *text;

@property(strong,nonatomic)NSDate *date;

@property(copy,nonatomic)NSString *music;

@property(nonatomic,copy)NSString *idenity;

@property (nonatomic,copy)NSString *groupInfo;

@property(nonatomic,assign,getter = isNew)BOOL New;

@property(nonatomic,assign,getter = isHandleOff)BOOL handOff;

@property(nonatomic,assign)int timesNum;

@property(nonatomic,copy)NSString *access_token;

@property(copy,nonatomic)NSString *uniqueID;



+(instancetype)remainModelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end
