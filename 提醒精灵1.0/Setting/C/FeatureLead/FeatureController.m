//
//  FeatureController.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 15/4/9.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "FeatureController.h"

@interface FeatureController ()<UIScrollViewDelegate>
{
    NSString *picName;
    
    CGFloat width;
    CGFloat height;
}

@property(nonatomic,weak)UIScrollView *scrollView;

@end

@implementation FeatureController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    [self.view addSubview: scrollView];
    
    self.scrollView = scrollView;
    
    self.scrollView.frame = self.view.bounds;
    
    [self.view addSubview:self.scrollView];
    
    height = self.view.bounds.size.height;
    
    width = self.view.bounds.size.width;
    
    self.scrollView.contentSize = CGSizeMake(10*width,height);
    
    self.scrollView.scrollEnabled = YES;
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.userInteractionEnabled = YES;
    
    self.scrollView.delegate = self;
    
    for (int i = 0; i<10; i++)
    {
        picName = [NSString stringWithFormat:@"%d.png",i+1];
        
        UIImage * image = [UIImage imageNamed:picName];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width*i, 0, width, height)];
        
        [imageView setImage:image];
        
        imageView.userInteractionEnabled = YES;
        
        [self.scrollView addSubview:imageView];
        
    }
    
    /*
    UIButton *dimiss2 = [[UIButton alloc]init];
    
    dimiss2.frame = CGRectMake(width*9+width/2,height-100, 55, 30);
    
    dimiss2.center = CGPointMake(width*9+width/2, height-100);
    
    [dimiss2 setTitle:@"返回" forState:UIControlStateNormal];
    
    [dimiss2 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
    
    dimiss2.backgroundColor = [UIColor redColor];
    
    [self.scrollView addSubview:dimiss2];
     
     */
    
    
    
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(BOOL)hidesBottomBarWhenPushed
{
    self.navigationController.navigationBarHidden = YES;
    
    return YES;
}

-(void)dismiss
{
//    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if ([self.delegate respondsToSelector:@selector(featureControllerViewDismissBackToSourceController)])
    {
        
        [self.delegate featureControllerViewDismissBackToSourceController];

        
    }
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    if ((*targetContentOffset).x>=2880)
    {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismiss];
            
        });
    }

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
