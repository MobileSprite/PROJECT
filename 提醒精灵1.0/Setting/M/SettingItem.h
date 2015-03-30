//
//  SettingItem.h
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SettingItemOption) ();

@interface SettingItem : NSObject

@property(copy,nonatomic)NSString *icon;

@property(copy,nonatomic)NSString *title;

@property(assign,nonatomic)Class controllerClass;

@property(nonatomic,copy)SettingItemOption option;

+(instancetype)setupWithIcon:(NSString *)icon Title:(NSString *)title;

+(instancetype)setupWithTitleName:(NSString *)title;

+(instancetype)setupWithIcon:(NSString *)icon Title:(NSString *)title DestineClass:(Class) destineClass;


@end
