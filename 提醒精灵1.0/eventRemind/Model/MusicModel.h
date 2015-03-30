//
//  MusicModel.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-11.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property(copy,nonatomic)NSString *music;

@property(assign,nonatomic)int time;

@property(copy,nonatomic)NSString *no;


+(instancetype)musicModelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end
