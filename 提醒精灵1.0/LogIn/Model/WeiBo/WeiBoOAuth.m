//
//  WeiBoOAuth.m
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "WeiBoOAuth.h"
@interface WeiBoOAuth()<NSCoding>
{
    
}

@end

@implementation WeiBoOAuth


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        
        self.logState = [aDecoder decodeBoolForKey:@"logState"];
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    
    [aCoder encodeBool:self.logState forKey:@"logState"];

}
@end
