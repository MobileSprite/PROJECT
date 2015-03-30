//
//  RenRenOAuth.h
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RenRenUser.h"

@interface RenRenOAuth : NSObject

@property(copy,nonatomic)NSString *access_token;

@property(copy,nonatomic)NSString *refresh_token;

@property(nonatomic,assign)long long expires_in;

@property(copy,nonatomic)NSString *token_type;

@property(strong,nonatomic)RenRenUser *user;

@property(nonatomic,assign)BOOL logState;

@end
