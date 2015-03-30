//
//  WeiBoAcountTool.h
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeiBoOAuth;

@interface WeiBoAcountTool : NSObject

+(void)acountSaveToFileWithOAuth:(WeiBoOAuth *)oauth;

+(WeiBoOAuth *)getWeiBoOAuthFromFile;


@end
