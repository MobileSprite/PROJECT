//
//  SettingItemController.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "SettingItemController.h"

#import "SettingViewCell.h"

#import "SettingGroup.h"
#import "SettingItem.h"

#import "AboutAuthor/AboutAuthor.h"
#import "AppCommend/Controller/AppCommend.h"
#import "FeatureController.h"

#import "HFStretchableTableHeaderView.h"

#import "WRLogInViewController.h"

#import "MBProgressHUD+MJ.h"

#import <MessageUI/MessageUI.h>


//#import "UMSocial.h"

@interface SettingItemController ()<UIActionSheetDelegate,MFMailComposeViewControllerDelegate,FeatureControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *HeadImageView;

@property(nonatomic,strong)NSMutableArray *groupArray;

@property (nonatomic, strong) HFStretchableTableHeaderView* stretchableTableHeaderView;

@end

@implementation SettingItemController

-(NSArray *)groupArray
{
    if (_groupArray == nil)
    {
        _groupArray = [NSMutableArray array];
        
    }
    
    return _groupArray;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self addGroup1];
    

    [self addGroup3];
    [self addGroup2];

    _stretchableTableHeaderView = [HFStretchableTableHeaderView new];
    
    [_stretchableTableHeaderView stretchHeaderForTableView:self.tableView withView:self.HeadImageView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_stretchableTableHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [_stretchableTableHeaderView resizeView];
}



-(void)addGroup1
{
    SettingItem *item1_0 = [SettingItem setupWithIcon:@"contacts" Title:@"应用评分"];

//    item1_0.icon
    
    item1_0.option = ^{
        
        NSLog(@"应用评分");
        
        /*
        
        int m_appleID = 0;
        
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple Software&id=%d",
                         
                         m_appleID ];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
         */
        
        
        
    };
    
    SettingItem *item1_1 = [SettingItem setupWithIcon:@"email" Title:@"意见反馈"];
    
    item1_1.option = ^{
        
        /**
         *  send e-mail;
         */

        
        
        NSString *myText = @"感谢您给予我们宝贵的意见，我们会及时答复:";
        
        
        NSMutableString * body = [NSMutableString stringWithString:myText];
        

        
        
        
        if ([MFMailComposeViewController canSendMail])
            // The device can send email.
        {
            [self displayMailComposerSheet:body];
            
        }else
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"设备不支持邮件功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [alert show];
            
        }

    };
    
//    SettingItem *item1_2 = [SettingItem setupWithIcon:@"share" Title:@"分享好友"];
//    __weak SettingItemController *controller = self;
//    item1_2.option = ^{
    
#pragma mark 分享给好友，文字和图片
//        [UMSocialSnsService presentSnsIconSheetView:controller appKey:@"5521ead4fd98c57ecd000424" shareText:@""shareImage:[UIImage imageNamed:@""] shareToSnsNames:[NSArray arrayWithObjects:UMShareToDouban,UMShareToEmail,UMShareToRenren,UMShareToSina,UMShareToSms, nil] delegate:controller];
    
//    };
    
//    SettingItem *item1_3 = [SettingItem setupWithIcon:@"in" Title:@"功能引导"];
//    SettingItem *item1_3 = [SettingItem setupWithIcon:@"in" Title:@"功能介绍" DestineClass:[FeatureController class]];
    
    
//    item1_3.option = ^{
//        
//        NSLog(@"功能引导");
//        
//        
//        
//    };
    
    
    SettingGroup *group_1 = [[SettingGroup alloc]init];
    
    group_1.headerTitle = @"欢迎,^_^";

    group_1.items = @[item1_0,item1_1];
    
    [self.groupArray addObject:group_1];
    
}



-(void)addGroup2
{
    SettingItem *item2_0 = [SettingItem setupWithIcon:@"card" Title:@"关于我们" DestineClass:[AboutAuthor class]];
    

    
    
    SettingGroup *group_2 = [[SettingGroup alloc]init];
    
    
    group_2.items = @[item2_0];
    
    [self.groupArray addObject:group_2];
    
}

-(void)addGroup3
{
    SettingItem *item3_0 = [SettingItem setupWithIcon:@"bottle" Title:@"版本检测"];
    
    item3_0.option = ^{
        
#pragma mark- 版本检测功能
        
        [MBProgressHUD showMessage:@"检测新版本中"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showSuccess:@"已是最新版本"];

        });
        

        
        
    };
    
    SettingGroup *group_3 = [[SettingGroup alloc]init];
    
    group_3.items = @[item3_0];
    
    [self.groupArray addObject:group_3];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.groupArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    SettingGroup *group = self.groupArray[section];
    
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingViewCell *cell = [SettingViewCell setupCellWithTableView:tableView];

    SettingGroup *group = self.groupArray[indexPath.section];
    
    cell.item = group.items[indexPath.row];
    // Configure the cell...
    
    
    
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    SettingViewCell *cell = (SettingViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.item.option)
    {
        cell.item.option();
        
    }
    
    SettingGroup *group = self.groupArray[indexPath.section];
    
    SettingItem *item = group.items[indexPath.row];
    
    if (item.controllerClass)
    {
        
        UIViewController *Vc = [[item.controllerClass alloc]init];
        
        Vc.title = item.title;
        
        [self.navigationController pushViewController:Vc animated:YES];
        
        if ([Vc.title isEqualToString:@"功能介绍"])
        {
            FeatureController *feature = (FeatureController*)Vc;
            feature.delegate = self;
        }
        
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup *group =self.groupArray[section];
    
    return group.headerTitle;
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

- (void)displayMailComposerSheet:(NSString *)text
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
    NSArray *recipientsArray = @[@"wrcj12138@163.com"];
    
    [picker setToRecipients:recipientsArray];
    
	[picker setSubject:@"意见反馈"];
	
    
    NSString *emailBody = text;
    
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //	self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -账户退出
- (IBAction)clickToLogOut:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"确认返回登陆界面吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定返回" otherButtonTitles: nil];
    
    [actionSheet showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        WRLogInViewController *logVc = [story instantiateViewControllerWithIdentifier:@"logController"];
        
        [UIApplication sharedApplication].delegate.window.rootViewController = logVc; /// 这句话在其他VC也可以用
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        NSLog(@"确定返回");
        
//        NSString *fullPath = [NSString alloc]
        
#pragma mark 删除当前账号的信息
        NSError *error;
        [[NSFileManager defaultManager]removeItemAtPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"current_access_token.dat"] error:&error];
        
    }
    
}


#pragma mark 分享组件代理

//-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
//{
//    NSLog(@"---");
//    
//}

@end
