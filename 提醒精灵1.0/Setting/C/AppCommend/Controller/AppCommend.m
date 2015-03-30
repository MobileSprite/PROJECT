//
//  AppCommend.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/15.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "AppCommend.h"

@interface AppCommend ()

@end

@implementation AppCommend

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    /**
     *  AppStore open App
     */
    
    /*
     
     NSString *stringURL =
     @"itms://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=467566074&mt=8";
     NSURL *url = [NSURL
     URLWithString:stringURL];
     ［UIApplication sharedApplication] openURL:url];
     
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
