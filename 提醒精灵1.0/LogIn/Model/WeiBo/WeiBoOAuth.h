//
//  WeiBoOAuth.h
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiBoOAuth : NSObject

@property(nonatomic,copy)NSString *access_token;

@property(assign,nonatomic)long long expires_in ;

@property(nonatomic,assign)long long remind_in;

@property(nonatomic,assign)long long uid;

@property(strong,nonatomic)NSDate *expires_time;

@property(nonatomic,assign)BOOL logState;

@end
