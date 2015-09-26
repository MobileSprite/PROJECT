//
//  ProgramViewController.h
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-9-24.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ProgramViewController : UIViewController<UITextFieldDelegate>
{
    int no;
    
}


@property(nonatomic,assign)BOOL canReload;

@property(nonatomic,assign)BOOL canSwitch;

@property (weak, nonatomic) IBOutlet UIView *HeadView;


@property(weak,nonatomic)IBOutlet UITableView *tabelView;

#pragma mark - models
@property(nonatomic,strong)NSMutableArray *remaindArrays;

@property(nonatomic,strong)NSArray *musicModelArray;

@property(nonatomic,strong)NSArray *countsArray;

@property(nonatomic,strong)NSArray *timesArray;

@property(nonatomic,weak)IBOutlet UITextField *textField;
@property(nonatomic, assign)BOOL isLoad;

-(void)addSwipeLeft;
-(void)addSwipeRight;

@end
