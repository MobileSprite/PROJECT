//
//  ModelDataTool.h
//  WRDate
//
//  Created by zjsruxxxy3 on 15/2/4.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DateModel;

@interface ModelDataTool : NSObject

/**
 *  根据模型数据，添加一条记录
 */
+(void)addTimeData:(DateModel *)dateModel;

/**
 *  根据模型数据，删除一条记录
 */
+(void)removeTimeData:(DateModel *)dateModel;


/**
 *  数值返回所有库里的模型
 */
+(NSArray *)allDateModel;




@end
