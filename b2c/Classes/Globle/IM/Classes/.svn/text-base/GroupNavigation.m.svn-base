//
//  GroupNavigation.m
//  IOSCim
//
//  Created by apple apple on 11-7-20.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GroupNavigation.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "UserChatViewController.h"
#import "GroupUserList.h"
#import "GroupStruct.h"
#import "GroupDataManage.h"
#import "SystemConfig.h"
#import "SetGroupHttp.h"
#import "SetGroupUserHttp.h"
#import "Debuger.h"
#import "ErrorParam.h"
#import "MyNotificationCenter.h"
#import "GetGroupUsersHttp.h"
#import "CIMSocketLogicExt.h"
#import "CimGlobal.h"



@implementation GroupNavigation
@synthesize optGroupId;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self.navigationController setNavigationBarHidden:NO];
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	
	//没有群成员时加载群成员
	if ([[[GroupDataManage getGroup:optGroupId] getUsers] count] == 0) {
		GetGroupUsersHttp *http = [GetGroupUsersHttp alloc];
		http.delegate = self;
		[http init:optGroupId];
	}
	
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO];
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	self.title = @"详情";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	tableView.scrollEnabled = NO;
	return 4;
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString* cellid = @"cell";
	UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	GroupStruct *group = [GroupDataManage getGroup:optGroupId];
	
	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = @"发送即时消息";
			break;
//		case 1:
//			cell.textLabel.text = @"查看资料";
//			break;
		case 1:
			cell.textLabel.text = @"查看成员列表";
			break;
		case 2:
			cell.textLabel.text = @"接收消息";
			break;
		default:
			break;
	}
	
	
	if (indexPath.section == 2) {
		UISwitch *recvGroupMessageSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
		
		
		if (group.isRecvMessage) {
			[recvGroupMessageSwitch setOn:YES];
		} else {
			[recvGroupMessageSwitch setOn:NO];
		}
		
		[recvGroupMessageSwitch addTarget:self action:@selector(setRecvGroupMessageSwitch:) 
			  forControlEvents:UIControlEventValueChanged];
		
		cell.accessoryView = recvGroupMessageSwitch;		
	}
	
	
	if (indexPath.section == 3) {
		//自己是创建者
		if ([group.myTypeInGroup isEqualToString:@"1"]) {
			cell.textLabel.text = @"解散该群";
		} else {
			cell.textLabel.text = @"退出该群";
		}
	}
	
	return cell;
}


- (void)setRecvGroupMessageSwitch:(id)sender {
	GroupStruct *group = [GroupDataManage getGroup:optGroupId];
	group.isRecvMessage = !group.isRecvMessage;
	//设置存储在硬盘上
	[SystemConfig setRecvGroupMessageSwitch:optGroupId];
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	GroupStruct *group = [GroupDataManage getGroup:optGroupId];
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	
	//聊天
	if (indexPath.section == 0) 
	{
		UserChatViewController *userChat = [[UserChatViewController alloc] init];
		ChatUserStruct *chatUser = [ChatUserStruct alloc];
		chatUser.dataId = optGroupId;
		chatUser.chatType = @"group";
		[userChat setConcantUser:chatUser];
		[self.parentViewController.navigationController pushViewController:userChat animated:YES];
	}
	else if (indexPath.section == 1) 
	{
		GroupUserList *groupUserList = [GroupUserList alloc];
		groupUserList.groupId = optGroupId;
		[self.navigationController pushViewController:groupUserList animated:YES];
	}
	
	
	if (indexPath.section == 3) 
	{
		//自己是创建者
		if ([group.myTypeInGroup isEqualToString:@"1"]) 
		{
			[cimSocketLogicExt dissolveGroupMessage:optGroupId];
			SetGroupHttp *http = [SetGroupHttp alloc];
			http.delegate = self;
			[http removeGroup:optGroupId];
		} 
		else
		{
			[cimSocketLogicExt leaveGroupMessage:optGroupId];
			SetGroupUserHttp *http = [SetGroupUserHttp alloc];
			http.delegate = self;
			[http removeUser:[UserDataManage getSelfUser].userId groupId:optGroupId];
		}
	}
	
	return indexPath;
}


- (void)recvSetGroupUserData:(id)sender {
	[GroupDataManage removeGroup:optGroupId];
	[MyNotificationCenter postNotification:SystemEventUpdateGroupView setParam:nil];
	[Debuger systemAlert:@"退出成功"];
	[self.navigationController popViewControllerAnimated:YES];
}
	 

- (void)errorSetGroupUser:(ErrorParam*)error {
	[Debuger systemAlert:error.errorInfo];
}


- (void)recvSetGroupData:(id)sender {
	[GroupDataManage removeGroup:optGroupId];
	
	[MyNotificationCenter postNotification:SystemEventUpdateGroupView setParam:nil];
	[Debuger systemAlert:@"解散成功"];
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)errorSetGroup:(ErrorParam*)error {
	[Debuger systemAlert:error.errorInfo];
}
	 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 20.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}





@end
