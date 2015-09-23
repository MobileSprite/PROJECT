//
//  xViewController.m
//  倒数计时2.0
//
//  Created by Dee on 14-12-9.
//  Copyright (c) 2014年 zjsruxxxy7. All rights reserved.
//

#import "xViewController.h"
#import "CircleprocessVie.h"

#import <Foundation/Foundation.h>

@interface xViewController ()<UIAlertViewDelegate>
{
    BOOL isPause;
    CircleprocessVie *progress;
}
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;



@end

@implementation xViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self drawRound];

    
    _pauseBtn.enabled=NO;
    _cancleBtn.enabled=NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:40/255.0 green:155/255.0 blue:232/255.0 alpha:1.0];
   
    [self timeChange:self.DatePicker];
    [self timeChange:self.DatePicker];
}

- (IBAction)timeChange:(UIDatePicker *)sender {
    
    NSInteger totalSubView = [[sender.subviews[0] subviews] count];
    ((UILabel *)[[sender.subviews[0] subviews] objectAtIndex:(totalSubView-2)]).textColor = [UIColor redColor];
    ((UILabel *)[[sender.subviews[0] subviews] objectAtIndex:(totalSubView-1)]).textColor = [UIColor redColor];

}
//1.设置倒计时
  //获取设定时间
-(NSInteger)pickerCount
{
    
    return self.DatePicker.countDownDuration ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    
    if (_timer ==nil&&_timerLable.tag==0) {
        
        _pauseBtn.enabled=YES;
        _cancleBtn.enabled=YES;
        _totlaTime=self.pickerCount;
        _arcBgView.alpha =1;
        [self creatNotification:_totlaTime];//创建提醒
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tiemFireMethod) userInfo:nil repeats:YES];
        
        _startBtn.tag=_totlaTime;
        NSLog(@"strat");
        
    }
 
    
    

}
//

-(void)tiemFireMethod
{
    
    
    
 
    _totlaTime -=1;
    hour =_totlaTime/60/60;
    sec =_totlaTime%60;
    min =(_totlaTime-sec-hour*60*60)/60;
    _timerLable.text =[NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)min,(long)sec];
    
    if (_arcBgView.layer.sublayers.count>=2) {
        
    [[_arcBgView.layer.sublayers lastObject]removeFromSuperlayer];
        
        }

    [self progressCirclie:_totlaTime];
    
    if (_totlaTime <=0)
    {
        
        _timerLable.text=@"00:00:00";
        //关闭定时器
        
        [_timer invalidate];
         _timer =nil;
      //弹窗提示
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"计时结束!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        
        [self.delegate SetController];
        [alert show];
        //取消note
        [self cancleNote];
        
       
    }
    
  //NSLog(@"%d",_arcBgView.layer.sublayers.count);
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    [self cancle:nil];
    
}

/**
 *  关闭定时器，记录totalsecond
 *   保存到tag里
 */
- (IBAction)pause:(id)sender {
    
    
    if ( isPause==NO && _timer!=nil) {
          NSLog(@"pause1");
        _timerLable.tag = _totlaTime;
        [_timer invalidate];
        _timer = nil;
        [self cancleNote];
        isPause=YES;
        _pauseBtn.selected=YES;
    }else if (isPause == YES) {
        NSLog(@"pause2");
        isPause =NO;
        _pauseBtn.selected=NO;
        _totlaTime =_timerLable.tag;
        [self creatNotification:_totlaTime];
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tiemFireMethod) userInfo:nil repeats:YES];
        
    }
    
   
    
}

- (IBAction)cancle:(id)sender {
    
    
   if ((isPause==NO&& _startBtn.tag!=0)||isPause ==YES) {
       
       _pauseBtn.enabled=NO;
       _cancleBtn.enabled=NO;
       
       _arcBgView.alpha =0.9;
       
       self.notification!=nil?[self cancleNote]:nil ;
       
        [_timer invalidate];
        _timer =nil;
        _timerLable.text=@"开始计时";

       isPause =NO;
       _startBtn.tag=0;
       _timerLable.tag=0;
       _pauseBtn.selected=NO;
       [progress removeFromSuperview];

   }
    
    
}

-(void)reStart
{
    
    _totlaTime =_timerLable.tag;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tiemFireMethod) userInfo:nil repeats:YES];
  
    
}

//
-(void)creatNotification:(NSInteger )totalT;
{
    if (self.notification==nil) {
    
    
    self.notification =[[UILocalNotification alloc]init];

    self.notification.fireDate = [[NSDate date]dateByAddingTimeInterval:totalT-1];
        
    
    self.notification.repeatInterval=0;
   self.notification.alertBody=@"计时已到，请查看。";
    
    self.notification.alertAction=NSLocalizedString(@"LOCKED AO!!", nil);
        
    self.notification.soundName =@"10000.caf";
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"timeCount",@"ID",self.notification.alertBody,@"dateText",nil];
        
    self.notification.userInfo = dic;
        
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:1];
    
    [[UIApplication sharedApplication ]scheduleLocalNotification:self.notification];
    }
    
}

-(void)cancleNote{
    
    [[UIApplication sharedApplication ] cancelLocalNotification:self.notification];
     self.notification=nil;
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
   
    

}
-(void) drawRound
{
    

    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGRect rect = _arcBgView.frame;
    
    
    [path addArcWithCenter:CGPointMake(rect.size.width/2,(rect.size.height)/2) radius:80 startAngle:0 endAngle:2*M_PI clockwise:NO];
    
    _arcLayer=[CAShapeLayer layer];
    
     _arcLayer.path=path.CGPath;
    
    _arcBgView.alpha =0.9;
    _arcLayer.fillColor=[UIColor colorWithRed:40.0/255.0 green:170.0/255.0 blue:240.0/255.0 alpha:1].CGColor;
    _arcLayer.strokeColor=[UIColor colorWithWhite:1 alpha:0.7].CGColor;
    _arcLayer.lineWidth=15;
    _arcLayer.frame=self.view.frame;
    [_arcBgView.layer addSublayer:_arcLayer];

}


//画环
-(void)progressCirclie :(CGFloat)totaltime;
{
    

    progress =[[ CircleprocessVie alloc] initWithFrame:CGRectMake(0,0, 176, 144)];

    
    progress.trackColor=[UIColor colorWithWhite:1 alpha:0.5];
    progress.progressColor =[UIColor colorWithRed:46.0/255.0 green:169.0/255.0 blue:230.0/255.0 alpha:1];
    
    progress.progress=1-totaltime/_startBtn.tag;
    NSLog(@"%f",progress.progress);
    progress.progressWidth=5;
    
    [_arcBgView addSubview:progress];
    
}

@end
