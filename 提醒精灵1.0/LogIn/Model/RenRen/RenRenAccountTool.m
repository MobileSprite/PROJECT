//
//  RenRenAccountTool.m
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "RenRenAccountTool.h"
#import "RenRenOAuth.h"

#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"renren_account.dat"]

@implementation RenRenAccountTool


+(void)acountSaveToFileWithOAuth:(RenRenOAuth *)oauth
{

    
    [NSKeyedArchiver archiveRootObject:oauth toFile:
     AccountFile];
    
}

+(RenRenOAuth *)getRenRenOAuthFromFile
{
    RenRenOAuth *oauth =[NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];

    return oauth;
    
}
@end
