//
//  AddDateViewController.m
//  纪念日提醒
//
//  Created by zjsruxxxy3 on 14-11-1.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "AddDateViewController.h"
#import "NSDate+DateCount.h"

#import "CurrentToken.h"
#import "AccessTokenTool.h"

#define AnimateTimePicker .45

#define RemindTime -2.5*60*60

#define aDay 86400

@interface AddDateViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textField;

@property(nonatomic,weak)IBOutlet UIDatePicker *datePick;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIButton *dateButton;

-(IBAction)dismiss;


-(IBAction)save;

@end

@implementation AddDateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        
        self.dateButton.userInteractionEnabled = NO;
        
//        self.view.backgroundColor = [UIColor grayColor];
        
        self.textField.delegate = self;
        
        NSDateFormatter *defaultFormatter = [[NSDateFormatter alloc]init];
        
        [defaultFormatter setDateFormat:@"yyyy-MM-dd"];
        
        self.dateButton.titleLabel.text = [defaultFormatter stringFromDate:self.datePick.date];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.textField];

    [self.datePick addTarget:self action:@selector(timeChange) forControlEvents:UIControlEventValueChanged];

}


-(void)viewDidAppear:(BOOL)animated
{
    [self.textField becomeFirstResponder];
    
    [super viewDidAppear:animated];
    
}

-(IBAction)save
{
    
    if ([self.delegate respondsToSelector:@selector(addDateViewControllerClick:AndTheModel:)])
    {
        /**
         *  创建一个模型
         */
        DateModel *model = [self setUpModel];
        
        for (DateModel *aModel in self.dateModels)
        {
            if ([aModel.identity isEqualToString:model.identity])
            {
                
                UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"warn" message:@"日子已存在"
                                                delegate:nil
                                        cancelButtonTitle:@"yes"
                                         otherButtonTitles:nil, nil];
                
                [alterView show];
                
                return;
                
            }
        }
        
        [ModelDataTool addTimeData:model];
    
        [self addNoteWith:model];
        
        [self.delegate addDateViewControllerClick:self
                                      AndTheModel:model];
        
        [self dismiss];
        
    }

}

-(DateModel *)setUpModel
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    NSString *settedTime = [dateFormatter stringFromDate:self.datePick.date];
    
    NSString *idenity = [settedTime substringFromIndex:4];
    
    NSString *fireDate = [dateFormatter stringFromDate:[NSDate dateTheYearWithTheDate:self.datePick.date]];
    
    DateModel *model = [[DateModel alloc]init];
    
    model.identity = idenity;
    
    model.dateText = self.textField.text;
    
    model.date = settedTime;
    
    model.fireDate = fireDate;
    
    /**
     *  判断给出对应账号的access_token
     */

    model.access_token = [AccessTokenTool getCurrentTokenFromFile].current_access_token;
    
    return model;
    
}

#pragma mark - addNote 9:30PM（default）

-(void)addNoteWith:(DateModel*)model
{
    // string ==> data;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    NSDate *finalDate =[dateFormatter dateFromString:model.fireDate];
    
    UILocalNotification *localNote = [[UILocalNotification alloc]init];
    
    localNote.timeZone = [NSTimeZone defaultTimeZone];
    
    localNote.soundName = @"10000.caf";
    
    localNote.alertBody = [NSString stringWithFormat:@"明天%@,别忘喽,亲",model.dateText];
    
    localNote.alertAction = nil;
    
    localNote.applicationIconBadgeNumber = 1;
    
    localNote.repeatInterval = NSCalendarUnitYear;
    
    localNote.fireDate = [finalDate dateByAddingTimeInterval:RemindTime];
    
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    
    [userDic setValue:model.date forKey:@"date"];
    [userDic setValue:model.dateText forKey:@"dateText"];
    [userDic setValue:model.identity forKey:@"identity"];
    [userDic setValue:localNote.fireDate forKey:@"fireDate"];
    [userDic setValue:model.access_token forKeyPath:@"access_token"];
    
    [userDic setValue:@"dateCount" forKey:@"ID"];
    
    localNote.userInfo = userDic;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNote];
    
}

-(void)textChange
{
    self.saveButton.enabled = self.textField.text.length;
}

-(void)timeChange
{
    
    NSDateFormatter *defaultFormatter = [[NSDateFormatter alloc]init];
    
    [defaultFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [self.dateButton setTitle:[defaultFormatter stringFromDate:self.datePick.date] forState:UIControlStateNormal];
    
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"dismiss");
        
    }];
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

#pragma mark - textFiledDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
// called when 'return' key pressed. return NO to ignore.


@end
