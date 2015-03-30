//
//  RenRenAccountTool.h
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RenRenOAuth;

@interface RenRenAccountTool : NSObject

+(void)acountSaveToFileWithOAuth:(RenRenOAuth *)oauth;

+(RenRenOAuth *)getRenRenOAuthFromFile;

@end
