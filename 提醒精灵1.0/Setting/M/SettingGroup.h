//
//  SettingGroup.h
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject

@property(copy,nonatomic)NSString *headerTitle;

@property(copy,nonatomic)NSString *footerTitle;

@property(strong,nonatomic)NSArray *items;


@end
