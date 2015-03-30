//
//  AnyoneOauth.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/3/30.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "AnyoneOauth.h"

@implementation AnyoneOauth

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.access_token = [aDecoder decodeObjectForKey:@"access_token"];

    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];

}

@end
