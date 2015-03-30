//
//  WeiBoAcountTool.m
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "WeiBoAcountTool.h"
#import "WeiBoOAuth.h"

#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weibo_account.dat"]

@implementation WeiBoAcountTool

+(void)acountSaveToFileWithOAuth:(WeiBoOAuth *)oauth
{
    NSDate *now = [NSDate date];
    
    oauth.expires_time = [now dateByAddingTimeInterval:oauth.expires_in];
     
    [NSKeyedArchiver archiveRootObject:oauth toFile:
     AccountFile];
    
}

+(WeiBoOAuth *)getWeiBoOAuthFromFile
{
    WeiBoOAuth *oauth =[NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];
    
    NSDate *now = [NSDate date];
    
    if ([now compare:oauth.expires_time] == NSOrderedDescending || oauth.logState == 0)
    {
        
        return nil;
        
    }
    
    return oauth;
    
}

@end
