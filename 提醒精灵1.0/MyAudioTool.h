//
//  MyAudioTool.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-12.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAudioTool : NSObject


+(void)playSound:(NSString *)soundName;

+(void)removeSound:(NSString *)soundName;

//+(void)initialize;

@end
