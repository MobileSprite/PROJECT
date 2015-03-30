//
//  RenRenOAuth.m
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "RenRenOAuth.h"

@interface RenRenOAuth ()<NSCoding>


@end

@implementation RenRenOAuth


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        
        self.refresh_token = [aDecoder decodeObjectForKey:@"refresh_token"];
        
        self.token_type = [aDecoder decodeObjectForKey:@"token_type"];
        
        self.user = [aDecoder decodeObjectForKey:@"user"];
        
        self.logState = [aDecoder decodeBoolForKey:@"logState"];
        

    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    
    [aCoder encodeObject:self.refresh_token forKey:@"refresh_token"];
    
    [aCoder encodeObject:self.token_type forKey:@"token_type"];

    [aCoder encodeObject:self.user forKey:@"user"];

    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    
    [aCoder encodeBool:self.logState forKey:@"logState"];
}
@end
