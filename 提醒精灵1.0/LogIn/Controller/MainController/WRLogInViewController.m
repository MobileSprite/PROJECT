//
//  WRLogInViewController.m
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "WRLogInViewController.h"
#import "RootNavigationController.h"
#import "WeiBoViewController.h"
#import "RenRenController.h"
#import "ProgramTabBarController.h"
#import "WeiBoAcountTool.h"
#import "WeiBoOAuth.h"

#import "AnyoneOauth.h"
#include "AnyoneOauthTool.h"
#include "CurrentToken.h"
#include "AccessTokenTool.h"
#include "SwitchControllerTool.h"

@interface WRLogInViewController ()<WeiBoDismissControllerDeleagte>


- (IBAction)choosePlatformLogIn:(UIButton *)sender;

@end

@implementation WRLogInViewController

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
    
    [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor lightGrayColor];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 

}

-(void)dismissController:(WeiBoViewController *)controller
{
    
    [self dismissViewControllerAnimated:NO completion:^{

    }];
}

- (IBAction)choosePlatformLogIn:(UIButton *)sender
{
    NSString *title = [sender titleForState:UIControlStateNormal];
    
    if ([title isEqualToString:@"QQ"])
    {
        
    }else if ([title isEqualToString:@"人人登录"])
    {
        
        RenRenController *renRen = [[RenRenController alloc]init];
        
        RootNavigationController *navigationVC = [[RootNavigationController alloc]initWithRootViewController:renRen];
        
        navigationVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:navigationVC animated:YES completion:^{
            
            
        }];
        
    }else if ([title isEqualToString:@"微博登录"])
    {
        
        WeiBoViewController *weiBo = [[WeiBoViewController alloc]init];
        
        RootNavigationController *navigationVC = [[RootNavigationController alloc]initWithRootViewController:weiBo];
        
        navigationVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        weiBo.delegate = self;

        [self presentViewController:navigationVC animated:YES completion:^{
            
            
        }];
        
        
    }else if ([title isEqualToString:@"快速登录"])
    {
        
        AnyoneOauth *anyoneOauth = [[AnyoneOauth alloc]init];
        
        anyoneOauth.access_token = @"anyone";
        
        CurrentToken *currentToken = [CurrentToken new];
        
        currentToken.current_access_token = anyoneOauth.access_token;
        
        [AccessTokenTool saveToFileWithAccessToken:currentToken];
        
        [AnyoneOauthTool acountSaveToFileWithOAuth:anyoneOauth];
        
        [SwitchControllerTool chooseRootViewController];
        
    }
}
@end
