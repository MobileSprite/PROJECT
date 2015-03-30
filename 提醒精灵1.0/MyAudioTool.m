//
//  MyAudioTool.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-12.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "MyAudioTool.h"
#import <AVFoundation/AVFoundation.h>

static NSMutableDictionary *_soundDic;




@implementation MyAudioTool

+(void)initialize
{
    _soundDic = [NSMutableDictionary dictionary];
    
}

+(void)playSound:(NSString *)soundName
{
    if (!soundName)
    {
        return;
    }
    
    SystemSoundID soundID = [_soundDic[soundName] unsignedIntValue];
    
    
    
    if (!soundID)
    {
        NSURL *url = [[NSBundle mainBundle]URLForResource:soundName withExtension:nil];

        if (!url) return;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        // 字典
        
        _soundDic[soundName] = @(soundID);
        
    }
    
    
    AudioServicesPlaySystemSound(soundID);
        
    
}

+(void)removeSound:(NSString *)soundName
{
    if (!soundName) return;
    
    SystemSoundID soundID = [_soundDic[soundName] unsignedIntValue];

    if (soundID)
    {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [_soundDic removeObjectForKey:soundName];
        
    }
    

    
}
@end
