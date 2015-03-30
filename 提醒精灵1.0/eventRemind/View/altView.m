//
//  altView.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-9.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "altView.h"

@implementation altView



+(instancetype)loadAlterView
{
    NSArray *altviews=[[NSBundle mainBundle] loadNibNamed:@"altView" owner:nil options:nil];

    
    altView *alterview = altviews[1];
    
    alterview.textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    //
    
    return alterview;
}

-(void)layoutSubviews
{
    
//    self.frame = CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    
    [super layoutSubviews];

    self.finishButton.center = CGPointMake(160, 150);
    self.dateButton.center = CGPointMake(80, 10);
    self.musicButton.center = CGPointMake(240, 10);
    

    
//    self.sendButton.center
    self.editButton.center = CGPointMake(4, 31);
    self.mailButton.center = CGPointMake(4, 71);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)clickMusic:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidMusicIntheAlterView:)])
    {
        [self.delegate alterViewDidMusicIntheAlterView:self];
    }
    
    self.musicChange = YES;

}

- (IBAction)clickRepeat:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidRepeatIntheAlterView:)])
    {
        [self.delegate alterViewDidRepeatIntheAlterView:self];
    }
}

- (IBAction)clickDate:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidDateIntheAlterView:)])
    {
        [self.delegate alterViewDidDateIntheAlterView:self];
    }
    
    self.dateChange = YES;
}

- (IBAction)clickFinish:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidFinishIntheAlterView2:)])
    {
        [self.delegate alterViewDidFinishIntheAlterView2:self];
    }
    
    
}

-(void)clickEdit
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidEditIntheAlterView:)])
    {
        [self.delegate alterViewDidEditIntheAlterView:self];
    }
    
    NSLog(@"%s",__func__);
}

-(IBAction)clickMail
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidMailIntheAlterView:)])
    {
        [self.delegate alterViewDidMailIntheAlterView:self];
    }
    

    NSLog(@"%s",__func__);
}

-(IBAction)clickSms
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidSmsIntheAlterView:)])
    {
        [self.delegate alterViewDidSmsIntheAlterView:self];
    }
    NSLog(@"%s",__func__);
}
/*
- (IBAction)clickEdit:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidEditIntheAlterView:)])
    {
        [self.delegate alterViewDidEditIntheAlterView:self];
    }
    
    NSLog(@"%s",__func__);

}

- (IBAction)clickMail:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidMailIntheAlterView:)])
    {
        [self.delegate alterViewDidMailIntheAlterView:self];
    }
    
    NSLog(@"%s",__func__);

}

- (IBAction)clickSms:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alterViewDidSmsIntheAlterView:)])
    {
        [self.delegate alterViewDidSmsIntheAlterView:self];
    }
    NSLog(@"%s",__func__);

}
 */

@end
