//
//  altView.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-10-9.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class altView,remainModel;
@protocol alterViewDelegate <NSObject>

-(void)alterViewDidMusicIntheAlterView:(altView *)alterView;

-(void)alterViewDidDateIntheAlterView:(altView *)alterView;

-(void)alterViewDidRepeatIntheAlterView:(altView *)alterView;

-(void)alterViewDidFinishIntheAlterView2:(altView *)alterView;


-(void)alterViewDidEditIntheAlterView:(altView *)alterView;

-(void)alterViewDidMailIntheAlterView:(altView *)alterView;

-(void)alterViewDidSmsIntheAlterView:(altView *)alterView;




@end

@interface altView : UIView


@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIButton *mailButton;

@property (weak, nonatomic) IBOutlet UIButton *smsButton;



@property (weak, nonatomic) IBOutlet UIButton *musicButton;

@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property(assign,nonatomic)id<alterViewDelegate> delegate;

@property(strong,nonatomic)remainModel *models;

@property(assign,nonatomic)BOOL noRead;

@property(assign,nonatomic)BOOL dateChange;

@property(assign,nonatomic)BOOL musicChange;


@property(assign,nonatomic)int theRow;
@property(assign,nonatomic)int theSection;


- (IBAction)clickMusic:(UIButton *)sender;

- (IBAction)clickDate:(UIButton *)sender;

- (IBAction)clickFinish:(UIButton *)sender;

- (IBAction)clickRepeat:(UIButton *)sender;

-(IBAction)clickEdit;

-(IBAction)clickMail;

-(IBAction)clickSms;

//-(IBAction)clicksms;



+(instancetype)loadAlterView;

@end
