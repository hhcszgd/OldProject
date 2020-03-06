//
//  ChooseOnlineStatus.m
//  IOSCim
//
//  Created by apple apple on 11-5-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ChooseOnlineStatus.h"
#import "SystemConfig.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "CimGlobal.h"
#import "CIMSocketLogicExt.h"
#import "Tool.h"
#import "SystemVariable.h"


@implementation ChooseOnlineStatus

- (void)viewDidLoad 
{
    title = @"状态设置";
    isShowBackButton = YES;
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
    
    CGRect tableRect;
    if (IS_GTE_IOS7) {
        tableRect = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + self.tabBarController.tabBar.frame.size.height + 5));
    } else {
        tableRect = CGRectMake(0, navigationBarHeight, mainRect.size.width, mainRect.size.height - (statusBarHeight + navigationBarHeight + self.tabBarController.tabBar.frame.size.height + 5));
    }
    table = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    table.layer.opacity = 0.8;
    [self.view addSubview:table];
    
	statusKey = [[NSMutableDictionary alloc] init];
	[statusKey setObject:@"上线" forKey:@"10"];
    [statusKey setObject:@"忙碌" forKey:@"20"];
    [statusKey setObject:@"离开" forKey:@"30"];
	[statusKey setObject:@"隐身" forKey:@"40"];
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO];
}



//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
	//tableView.backgroundView.alpha = 0;
	tableView.backgroundColor = [UIColor clearColor];
	tableView.scrollEnabled = NO;
	return 1;
}



//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [[statusKey allValues] count];
}



//行的創建
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSUInteger section = indexPath.section; //獲取第幾分區
	NSUInteger row = indexPath.row; //獲取行
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) 
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:CellIdentifier] ;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	NSString *statusValue = [[statusKey allKeys] objectAtIndex:indexPath.row];
	NSInteger *realStatusValue = [statusValue intValue];
	
	if (realStatusValue == 40) 
	{
		realStatusValue = 50;
	}
	
	UserData *mySelfUser = [UserDataManage getSelfUser];

	if (realStatusValue == [mySelfUser getStatus]) 
	{
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} 
	else 
	{
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	cell.textLabel.text = [[statusKey allValues] objectAtIndex:indexPath.row];
	
	if (row == 0) {
		cell.imageView.image = [UIImage imageNamed:@"status_online.png"];
	} else if (row == 1) {
		cell.imageView.image = [UIImage imageNamed:@"status_leave.png"];
    } else if (row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"status_busy.png"];
    } else if (row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"status_invisible.png"];
    }
	return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString *value = [[statusKey allKeys] objectAtIndex:indexPath.row];
	int *realValue = [value intValue];
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	[cimSocketLogicExt setMyStatus:realValue];
	UserData *mySelfUser = [UserDataManage getSelfUser];
	[mySelfUser setStatus:value];
	[tableView reloadData];
	return indexPath;
}





@end
