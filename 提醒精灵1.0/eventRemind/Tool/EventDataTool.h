//
//  EventDataTool.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/3/1.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class remainModel;

@interface EventDataTool : NSObject

/**
 *  根据模型数据，添加一条记录
 */
+(void)addDBModel:(remainModel *)model;

/**
 *  根据模型数据，删除一条记录
 */
+(void)removeDBModel:(remainModel *)model;

/**
 *  根据模型数据，修改一条记录
 */
+(void)modifyDBModel:(remainModel *)model;

/**
 *  数值返回所有库里的模型
 */
+(NSArray *)allremainModel;

@end
