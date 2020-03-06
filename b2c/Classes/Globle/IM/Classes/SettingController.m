//
//  SettingController.m
//  IOSCim
//
//  Created by apple apple on 11-6-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SettingController.h"
#import "LoginViewController.h"
#import "ChooseOnlineStatus.h"
#import "SystemConfig.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "MyNotificationCenter.h"
#import "ClearLoginerData.h"
#import "Tool.h"
#import "SystemVariable.h"
#import "WebViewController.h"
#import "MyUserInfoViewController.h"
#import "UserVerifyViewController.h"
#import "Config.h"

@implementation SettingController
@synthesize exitSystem, soundSwitch, setSoundCell;

- (IBAction)exit:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isAutoLogined"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [MyNotificationCenter postNotification:SystemEventClearMessageTips setParam:nil];
    //清除登录的数据
    [ClearLoginerData clear];
    
    NSArray *viewControllers = self.parentViewController.navigationController.viewControllers;
    for (UIViewController *viewControllerOne in viewControllers) {
        if ([viewControllerOne isKindOfClass:[LoginViewController class]]) {
            [self.parentViewController.navigationController popToViewController:viewControllerOne animated:YES];
            return;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO];
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    title = @"系统设置";
    //全屏大小
    CGRect mainRect = [Tool screenRect];
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    //背景图
    CGRect backgroundViewRect = mainRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    [super viewDidLoad];
    
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + self.tabBarController.tabBar.frame.size.height + 5));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + self.tabBarController.tabBar.frame.size.height + 5));
    }
    myTableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.layer.opacity = 0.8;
    [self.view addSubview:myTableView];

	[self initLoad];
	[self.navigationController setNavigationBarHidden:NO];
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	 
	userStatusDict = [[NSMutableDictionary alloc] init];
	[userStatusDict setObject:@"上线" forKey:@"10"];
    [userStatusDict setObject:@"忙碌" forKey:@"20"];
    [userStatusDict setObject:@"离开" forKey:@"30"];
	[userStatusDict setObject:@"隐身" forKey:@"50"];
}
- (void)updateData {
	[myTableView reloadData];
}
//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
	//tableView.backgroundView.alpha = 0;
	tableView.backgroundColor = [UIColor clearColor];
	return 3;
}
//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
	return 1;
}
//行的創建
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger section = indexPath.section; //獲取第幾分區
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	UserData *mySelfUser = [UserDataManage getSelfUser];
	NSString *key = [[NSString alloc] initWithFormat:@"%d", [mySelfUser getStatus]];
	
    switch (section) {
		case 0:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"基本资料";
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"好友验证设置";
            } else if (indexPath.row == 2) {
                cell.textLabel.text = @"静音模式";
                if (soundSwitch == nil) {
                    soundSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
                    if ([SystemConfig isSoundRemind]) {
                        [soundSwitch setOn:YES];
                    } else {
                        [soundSwitch setOn:NO];
                    }
                    [soundSwitch addTarget:self action:@selector(setSoundRemind:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = soundSwitch;		
                }
            } else if (indexPath.row == 3) {
                cell.textLabel.text = @"消息震动模式";
                if (shockSwitch == nil) {
                    shockSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
                    if ([SystemConfig isShockMode]) {
                        [shockSwitch setOn:YES];
                    } else {
                        [shockSwitch setOn:NO];
                    }
                    [shockSwitch addTarget:self action:@selector(setShockMode:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = shockSwitch;
                }
            } else if (indexPath.row == 4) {
                cell.textLabel.text = @"接收群消息";
                if (groupSwitch == nil) {
                    groupSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
                    if ([SystemConfig isReceiveGroupMessage]) {
                        [groupSwitch setOn:YES];
                    } else {
                        [groupSwitch setOn:NO];
                    }
                    [groupSwitch addTarget:self action:@selector(setReceiveGroupMessage:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = groupSwitch;
                }
            }/* else if (indexPath.row == 6) {
                cell.textLabel.text = @"访客上线提示";
                if (guestSwitch == nil) {
                    guestSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
                    if ([SystemConfig isGuestOnline]) {
                        [guestSwitch setOn:YES];
                    } else {
                        [guestSwitch setOn:NO];
                    }
                    [guestSwitch addTarget:self action:@selector(setGuestOnline:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = guestSwitch;
                }
            }*/
            if (indexPath.row < 2) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
			break;
		case 1:
			cell.textLabel.text = [userStatusDict objectForKey:key];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
        case 2:
            cell.textLabel.text = @"更换账号";
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
		default:
			break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
	return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return @"系统设置";
		case 1:
			return @"设置状态";
		case 2:
			return @"更换账号";
	}
	return @"";
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger section = indexPath.section; //獲取第幾分區
	if (section == 0) {
        if (indexPath.row == 0) {
            MyUserInfoViewController *mvc = [[MyUserInfoViewController alloc] init];
            [self.parentViewController.navigationController pushViewController:mvc animated:YES];
        } else if (indexPath.row == 1) {
            UserVerifyViewController *uvc = [[UserVerifyViewController alloc] init];
            [self.parentViewController.navigationController pushViewController:uvc animated:YES];
        }
	} else if (section == 1) {
		[self chooseOnlineStatus];
	} else if (section == 2) {
        if (actionSheet == nil) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"更改用户" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
        }
        [actionSheet showFromTabBar:self.parentViewController.parentViewController.view];
    }
	return indexPath;
}
- (IBAction)setSoundRemind:(id)sender {
	[SystemConfig setSoundRemind];
}
- (IBAction)setShockMode:(id)sender {
    [SystemConfig setShockMode];
}
- (IBAction)setReceiveGroupMessage:(id)sender {
    [SystemConfig setReceiveGroupMessage];
}
- (IBAction)setGuestOnline:(id)sender {
    [SystemConfig setGuestOnline];
}
- (void)chooseOnlineStatus {
	ChooseOnlineStatus *chooseOnlineStatus = [ChooseOnlineStatus alloc];
	[self.parentViewController.navigationController pushViewController:chooseOnlineStatus animated:YES];
}
- (void)actionSheet:(UIActionSheet *)actionSheetc willDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [actionSheetc cancelButtonIndex]) {
		[self exit:nil];
    }
}

@end
