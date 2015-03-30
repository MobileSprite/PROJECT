//
//  AccessTokenTool.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/2/13.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentToken.h"

typedef enum : NSUInteger {
    kWeiBoAccount = 101,
    kRenRenAccount,
    kQQAcount,
    kAnyOne
} AccountFlag;

@interface AccessTokenTool : NSObject

+(NSString *)returnCurrentAccess_tokenWithAccountFlag:(AccountFlag)flag;

+(void)saveToFileWithAccessToken:(CurrentToken *)token;

+(CurrentToken *)getCurrentTokenFromFile;
@end
