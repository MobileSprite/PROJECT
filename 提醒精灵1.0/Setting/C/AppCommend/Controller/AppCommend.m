//
//  AppCommend.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/15.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "AppCommend.h"
#import "appModel.h"
#import "appView.h"

@interface AppCommend ()
@property(nonatomic,strong)NSArray *apps;

@end

@implementation AppCommend



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int totalCol =3;
    float appW =80;
    float appH =80;
    CGFloat marginX =(self.view.frame.size.width -totalCol *appW)/(totalCol+1);
    CGFloat marginY=15;
    for (int i =0; i<self.apps.count; i++) {
    
        appView *app =[appView appViewWithAppModel:self.apps[i] ];

    
        
//        app.backgroundColor =[UIColor redColor];
        [self.view addSubview:app];
        
        int row =i/totalCol;
        int col =i%totalCol;

        
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = 90 + row * (appH + marginY);
       
        app.frame = CGRectMake(appX, appY, appW, appH);

        app.app = self.apps[i];
        
        UIButton *Btn =[app subviews][0];
        
        [Btn addTarget:self action:@selector(appBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray *)apps
{
    if (_apps==nil) {
        
        NSString*path=[[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil];
        NSArray *arr =[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *nuArr =[NSMutableArray array];
        for (NSDictionary *dic in arr) {
            
            appModel *model =[appModel appWithDic:dic];
            [nuArr addObject:model];
        }
        _apps =nuArr;
        
        
    }
    return _apps;
}
-(void)appBtnPressed:(UIButton *)btn
{
    appView  *view=(appView*) btn.superview;
    

    // NSLog(@"%@--被按下",view.app.name);
}

@end
