//
//  AccessTokenTool.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/2/13.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "AccessTokenTool.h"

#import "WeiBoOAuth.h"
#import "WeiBoAcountTool.h"

#import "RenRenAccountTool.h"
#import "RenRenOAuth.h"

#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"current_access_token.dat"]

@implementation AccessTokenTool

+(NSString *)returnCurrentAccess_tokenWithAccountFlag:(AccountFlag)flag
{
    NSString *currentAccess_token;
    
    switch (flag)
    {
        case kWeiBoAccount:
            
            currentAccess_token = [WeiBoAcountTool getWeiBoOAuthFromFile].access_token;
            
            break;
            
        case kRenRenAccount:
            
            currentAccess_token = [RenRenAccountTool getRenRenOAuthFromFile].access_token;

            break;
            
        case kQQAcount:
            
            break;
            
        case kAnyOne:
        default:
            
            break;
    }
    
    return currentAccess_token;
    
}

+(void)saveToFileWithAccessToken:(CurrentToken *)token
{
    [NSKeyedArchiver archiveRootObject:token toFile:
     AccountFile];
}

+(CurrentToken *)getCurrentTokenFromFile
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];
    
}


@end
