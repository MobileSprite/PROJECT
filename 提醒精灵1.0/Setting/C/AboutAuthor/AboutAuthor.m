//
//  AboutAuthor.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "AboutAuthor.h"
#import "WebViewController.h"
#include "Define.h"
@interface AboutAuthor ()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UIButton *button;

-(void)addInformation;

@end

@implementation AboutAuthor

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self addInformation];
    [self loadImageView];

    [self loadButtonToWeb];
    
}

- (void) loadImageView {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconView"]];
    CGRect tempFrame = imageView.bounds;
    tempFrame.size = CGSizeMake(220, 220);
    imageView.bounds = tempFrame;
    
    imageView.center = self.view.center;
    
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
}

- (void) loadButtonToWeb {
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 140, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 140, 44);
    button.center = CGPointMake(self.imageView.center.x, self.imageView.center.y + 150);
    self.button = button;
    [self.view addSubview:button];
    [button setTitle:@"访问网站" forState: UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button setBackgroundColor:[UIColor colorWithRed:40/255.0 green:155/255.0 blue:232/255.0 alpha:1.0]];
    [button addTarget:self action:@selector(openWebsize) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void) openWebsize {
    
//    UIViewController * webViewController = (WebViewController *) [UINib nibWithNibName:@"WebViewController" bundle:nil];
    
    WebViewController *webViewController = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    
    [self.navigationController pushViewController:webViewController animated:true];
    

}

-(BOOL)hidesBottomBarWhenPushed
{
    
    return YES;
}

-(void)addInformation{
    
 
    
    UILabel *AuthorName =[[UILabel alloc]initWithFrame:CGRectMake(20, WinSize.height/2-60, 300, 40)];
    AuthorName.text=@"作者：何林狄，闻人超杰";
    AuthorName.textColor=[UIColor grayColor];
    AuthorName.font=[UIFont systemFontOfSize:16];
    AuthorName.adjustsFontSizeToFitWidth=YES;
    AuthorName.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:AuthorName];
//    AuthorName.backgroundColor=[UIColor redColor];
//    UILabel *Contract=]
    UILabel *Contract =[[UILabel alloc]initWithFrame:CGRectMake(20, WinSize.height/2-40, 290, 40)];
    Contract.text=@"邮箱: dee_code@163.com/wrcj12138@163.com";
    Contract.textColor=[UIColor grayColor];
    Contract.font=[UIFont systemFontOfSize:16];
    Contract.adjustsFontSizeToFitWidth=YES;
    Contract.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Contract];
    
    
    UILabel *AboutCode=[[UILabel alloc]initWithFrame:CGRectMake(20, WinSize.height/2-10, 290, 30)];
    AboutCode.textAlignment=NSTextAlignmentLeft;
    AboutCode.numberOfLines=3;
    AboutCode.adjustsFontSizeToFitWidth=YES;
    AboutCode.font=[UIFont systemFontOfSize:16];
    AboutCode.text=@"源码请访问：https://github.com/MobileSprite/project";
    AboutCode.textColor=[UIColor grayColor];
    [self.view addSubview:AboutCode];
    AboutCode.enabled=YES;

    UIImageView *image= [[UIImageView alloc]initWithFrame:CGRectMake(WinSize.width/2-40, WinSize.height/2-170, 76, 76)];
    image.image=[UIImage imageNamed:@"Icon2-60"];
    [self.view addSubview:image];
    UILabel *copyRight= [[UILabel alloc]initWithFrame:CGRectMake(WinSize.width/2-40, WinSize.height/2-100, 290, 30)];
    copyRight.textAlignment=NSTextAlignmentLeft;
    copyRight.text=@"手机提醒精灵";
    copyRight.textColor=[UIColor grayColor];
    copyRight.font=[UIFont systemFontOfSize:10];
    
    [self.view addSubview:copyRight];
    
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
