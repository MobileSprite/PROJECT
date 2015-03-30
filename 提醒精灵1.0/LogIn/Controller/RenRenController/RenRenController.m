//
//  RenRenController.m
//  LogInPart
//
//  Created by zjsruxxxy3 on 15/2/8.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "RenRenController.h"
#import "RenRenUser.h"
#import "RenRenOAuth.h"
#import "RenRenAccountTool.h"

#import "CurrentToken.h"
#import "AccessTokenTool.h"

#import "MJExtension.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

#import "SwitchControllerTool.h"


@interface RenRenController ()<UIWebViewDelegate,UIAlertViewDelegate>
{
    
}

@end

@implementation RenRenController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"人人登陆";
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backToDismiss)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupRenRenLogView];
    
}

- (void)setupRenRenLogView
{
    UIWebView *logView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    logView.delegate = self;
    

        [MBProgressHUD showMessage:@"loading"];

        [logView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://graph.renren.com/oauth/authorize?client_id=352cb66d2adc429485c06ccda14c1912&redirect_uri=http://www.baidu.com&response_type=code&display=touch"]]];
        
        [self.view addSubview:logView];

    

}

-(void)backToDismiss
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
}

#pragma webViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    NSLog(@"%@",request.URL.absoluteString);
    
    /**
     *  截取url，获取code的值，用于获取access_token。
     */
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = request.URL.absoluteString;
    
    NSRange range = [urlString rangeOfString:@"code="];
    
    if (range.location != NSNotFound)
    {
        webView.hidden = YES;

        NSString *code = [urlString substringFromIndex:(range.location + range.length)];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        NSLog(@"%@",code);
        
        [parameters setObject:@"352cb66d2adc429485c06ccda14c1912" forKey:@"client_id"];
        
        [parameters setObject:@"ddd0df6c1923406c9e43ac5713b310f4"
                       forKey:@"client_secret"];
        
        [parameters setObject:@"authorization_code" forKey:@"grant_type"];
        
        [parameters setObject:@"http://www.baidu.com" forKey:@"redirect_uri"];
        
        [parameters setObject:code forKey:@"code"];
        
        [requestManager POST:@"https://graph.renren.com/oauth/token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"%@",responseObject);
             
             [MBProgressHUD showSuccess:@"success"];

             RenRenOAuth *oauth = [RenRenOAuth objectWithKeyValues:responseObject];

             /**
              *  设置登陆状态为yes
              */

             oauth.logState = YES;
             
             CurrentToken *currentToken = [CurrentToken new];
             currentToken.current_access_token = oauth.access_token;
             [AccessTokenTool saveToFileWithAccessToken:currentToken];
             
             [RenRenAccountTool acountSaveToFileWithOAuth:oauth];
             
             [SwitchControllerTool chooseRootViewController];
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [MBProgressHUD showError:@"account error"];
             
             [self backToDismiss];


             
         }];
        
        
    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%@",webView.request.URL);
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [MBProgressHUD hideHUD];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"无网络信号" message:@"请开启网络谢谢" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
    
    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self backToDismiss];
    
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
