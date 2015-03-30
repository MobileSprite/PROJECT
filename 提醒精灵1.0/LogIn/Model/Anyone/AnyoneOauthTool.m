//
//  AnyoneOauthTool.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/3/30.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "AnyoneOauthTool.h"

#import "AnyoneOauth.h"

#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"anyone_account.dat"]
@implementation AnyoneOauthTool
+(void)acountSaveToFileWithOAuth:(AnyoneOauth *)oauth
{
    
    [NSKeyedArchiver archiveRootObject:oauth toFile:
     AccountFile];
    
}

+(AnyoneOauth *)getAnyoneOAuthFromFile
{
    AnyoneOauth *oauth =[NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];

    return oauth;
    
}

@end
