//
//  SettingItem.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+(instancetype)setupWithIcon:(NSString *)icon Title:(NSString *)title DestineClass:(Class)destineClass
{
    SettingItem *item = [[SettingItem alloc]init];

    item.icon = icon;
    item.title = title;
    item.controllerClass = destineClass;
    
    return item;
    
}

+(instancetype)setupWithIcon:(NSString *)icon Title:(NSString *)title
{
    return [self setupWithIcon:icon Title:title DestineClass:nil];
    
}

+(instancetype)setupWithTitleName:(NSString *)title
{
    return [self setupWithIcon:nil Title:title DestineClass:nil];
    
}


@end
