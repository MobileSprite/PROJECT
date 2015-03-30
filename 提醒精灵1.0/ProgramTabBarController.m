//
//  ProgramTabBarController.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-12-5.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "ProgramTabBarController.h"

@interface ProgramTabBarController ()

@end

@implementation ProgramTabBarController

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
    
    self.tabBar.alpha = 1;
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    

    
//    self.tabBar.hidden = YES;
    
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
