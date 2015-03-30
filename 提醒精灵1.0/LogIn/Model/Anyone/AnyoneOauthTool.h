//
//  AnyoneOauthTool.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/3/30.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnyoneOauth;

@interface AnyoneOauthTool : NSObject


+(void)acountSaveToFileWithOAuth:(AnyoneOauth *)oauth;

+(AnyoneOauth *)getAnyoneOAuthFromFile;

@end
