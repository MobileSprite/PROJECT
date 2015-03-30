//
//  CircleprocessVie.h
//  DrawCircle
//
//  Created by Dee on 14-12-13.
//  Copyright (c) 2014年 Yeming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CircleprocessVie : UIView
{
    
    
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
    
}
@property (nonatomic ,strong)UIColor *trackColor;
@property (nonatomic ,strong)UIColor *progressColor;
@property (nonatomic )float progress;
@property (nonatomic )float progressWidth;
-(void)setProgress:(float)progress animated:(BOOL)animated;


@end
