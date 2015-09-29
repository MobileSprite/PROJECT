//
//  DateTableViewController.m
//  纪念日提醒
//
//  Created by zjsruxxxy3 on 14-11-1.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "DateTableViewController.h"
#import "AddDateViewController.h"
#import "DateModel.h"
#import "DateCell.h"
#import "NSDate+DateCount.h"
#import "ModelDataTool.h"
#import "Constants.h"
#import "FRDLivelyButton.h"

#define fileName     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"dateModels.archive"]


@import CoreSpotlight;

@interface DateTableViewController ()<AddDateViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray *dateArray;

@property (weak, nonatomic) IBOutlet UILabel *todayLabel;

//@property (strong, nonatomic) IBOutlet LTPopButton *popButton;
@property (weak, nonatomic) IBOutlet UIView *HeadView;

@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
//@property (unsafe_unretained, nonatomic) IBOutlet UIView *bgroudView;

//@property (strong, nonatomic)LTPopButton *popButton;
@property (weak, nonatomic) IBOutlet FRDLivelyButton *popButton;

@property (weak, nonatomic) IBOutlet UIImageView *headBackgroundView;

- (IBAction)changeStyle:(FRDLivelyButton *)sender;


@end

@implementation DateTableViewController

-(NSMutableArray *)dateArray
{
    if (_dateArray == nil)
    {
        _dateArray = [NSMutableArray arrayWithArray:[ModelDataTool allDateModel]];
        
    }
    
    return _dateArray;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTouch) name:RMWillHandleDateReminder object:nil];
    }
    
    return self;
    
}

- (void)viewDidLoad
{
//    self.view.backgroundColor = [UIColor grayColor];
    
    [super viewDidLoad];
    
    [self setupHeadViewContent];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DateTouch"]) {
        [self handleTouch];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"DateTouch"];
        
    }
}


-(void)setupHeadViewContent
{
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc]init];
    
    dayFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *newDay = [dayFormatter stringFromDate:today];
    self.headBackgroundView.backgroundColor = [UIColor colorWithRed:40/255.0 green:155/255.0 blue:232/255.0 alpha:1.0];
    
    self.headBackgroundView.frame = self.HeadView.bounds;
    
    self.todayLabel.text = newDay;
    
    self.weekLabel.text = [NSDate dateWeekInTheDate:[NSDate date]];
    
    [self.popButton setStyle:kFRDLivelyButtonStylePlus animated:NO];

    [self.popButton setOptions:@{
                                 kFRDLivelyButtonColor: [UIColor whiteColor],
                      kFRDLivelyButtonHighlightedColor: [UIColor whiteColor],
            kFRDLivelyButtonHighlightAnimationDuration: @(.1),
                        kFRDLivelyButtonHighlightScale: @(0.9),
                             kFRDLivelyButtonLineWidth: @(2.5),
          kFRDLivelyButtonUnHighlightAnimationDuration: @(.15),
          kFRDLivelyButtonStyleChangeAnimationDuration: @(.3)
                                 }];

}

- (void)setEmptyView {
    
    UIImageView *emptyView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emptyView2"]];
    emptyView.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.backgroundView = emptyView;
    
}

- (IBAction)changeStyle:(FRDLivelyButton *)sender
{
      [sender setStyle:kFRDLivelyButtonStyleClose animated:YES];
    
    AddDateViewController * addViewController = [[AddDateViewController alloc]init];
    
    [self presentViewController:addViewController animated:YES completion:^{
        
        [sender setStyle:kFRDLivelyButtonStylePlus animated:NO];
        
        addViewController.dateModels = self.dateArray;
        
        addViewController.delegate = self;
        
    }];
    
}

#pragma mark addDelegate

-(void)addDateViewControllerClick:(AddDateViewController *)addVc AndTheModel:(DateModel *)model
{
    
    // 添加一个模型数据
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    
    NSDate *date =[dateFormatter dateFromString:model.date];
    
    [self addIndexWith:model AndDate:date];
    
    [self.dateArray addObject:model];
    
    [self.tableView reloadData];
    
}

#pragma mark - addIndexWith CoreSpotlight API
- (void) addIndexWith:(DateModel *)model AndDate:(NSDate *)date{
    CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc]initWithItemContentType:@"text"];
    NSString *ID = model.identity;
    NSString *content = nil;
    //TODO: 处理过长的几点信息.
    if (model.dateText.length > 20) {
        
       content = [[model.dateText substringToIndex:10] stringByAppendingString:@"..."];
    }else {
        content =  model.dateText;
    }
    
    set.title = @"特殊的一天";
    set.keywords = @[@"生日",@"假日",content];

    set.contentDescription = [NSString stringWithFormat:@"最近一次打开时,距离%@还有%d天",content,(int)([NSDate dateCountWithTheDate:date]+1)];
    
    CSSearchableItem *item = [[CSSearchableItem alloc]initWithUniqueIdentifier:ID domainIdentifier:@"DateCount" attributeSet:set];
    
    CSSearchableIndex *index = [CSSearchableIndex defaultSearchableIndex];
    [index indexSearchableItems:@[item] completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",error);
            return;
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (self.dateArray.count == 0) {
        [self setEmptyView];
        
    }else {
        tableView.backgroundView = nil;
    }
    
    return self.dateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    DateCell *cell = [DateCell dateCellWithTable:tableView];
//    cell.backgroundColor=[UIColor redColor];
    cell.model = self.dateArray[indexPath.row];
    
    cell.selected = NO;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        
        DateModel *deleteModel = self.dateArray[indexPath.row];
        
        for (UILocalNotification *oldNote in [UIApplication sharedApplication].scheduledLocalNotifications)
        {
            
            NSDictionary *dicOldNote = oldNote.userInfo;
            
            
            if ([dicOldNote[@"identity"] isEqualToString:deleteModel.identity])
            {
                [[UIApplication sharedApplication]cancelLocalNotification:oldNote];
            }
            
        }
        // NSLog(@"%@",deleteModel);
        
        [ModelDataTool removeTimeData:deleteModel];
        
        [self.dateArray removeObjectAtIndex:indexPath.row];

        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [[CSSearchableIndex defaultSearchableIndex] deleteSearchableItemsWithIdentifiers:@[deleteModel.identity] completionHandler:^(NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"indeError: %@ ",error);
                return;
            }
        }];


    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)handleTouch {
    
    AddDateViewController * addViewController = [[AddDateViewController alloc]init];
    
    [self presentViewController:addViewController animated:YES completion:^{
        
        addViewController.dateModels = self.dateArray;
        
        addViewController.delegate = self;
        
    }];}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
