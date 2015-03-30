//
//  CurrentToken.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/2/13.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "CurrentToken.h"

@implementation CurrentToken

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.current_access_token = [aDecoder decodeObjectForKey:@"current_access_token"];
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.current_access_token forKey:@"current_access_token"];
    
}
@end
