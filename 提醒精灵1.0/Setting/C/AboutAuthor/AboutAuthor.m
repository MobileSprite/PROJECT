//
//  AboutAuthor.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "AboutAuthor.h"
#include "Define.h"
@interface AboutAuthor ()

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
    [self addInformation];
    
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
    image.image=[UIImage imageNamed:@"Icon-76"];
    [self.view addSubview:image];
    UILabel *copyRight= [[UILabel alloc]initWithFrame:CGRectMake(WinSize.width/2-40, WinSize.height/2-100, 290, 30)];
    copyRight.textAlignment=NSTextAlignmentLeft;
    copyRight.text=@"手机提醒精灵1.0";
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
