//
//  GroupUserList.m
//  IOSCim
//
//  Created by apple apple on 11-7-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GroupUserList.h"
#import "GroupDataManage.h"
#import "UserChatViewController.h"
#import "ChatUserStruct.h"
#import "MyNotificationCenter.h"
#import "GetGroupUsersHttp.h"
#import "CIMSocketLogicExt.h"
#import "CIMFriendListDataStruct.h"
#import "CIMShopListDataStruct.h"
#import "CimGlobal.h"


@implementation GroupUserList
@synthesize groupId, myTableView;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	[self.navigationController setNavigationBarHidden:NO];
	//清除内存中的数据 重新加载
	[[GroupDataManage getGroup:groupId] clearUsers];
	
	[MyNotificationCenter addObserver:self 
							 selector:@selector(updateGroupUser:) 
								 name:HttpGroupUserDataComplete obServerId:@"GroupUserList_updateGroupUser"];
		
	GetGroupUsersHttp *http = [GetGroupUsersHttp alloc];
	[http init:groupId];
    [super viewDidLoad];
	
	[MyNotificationCenter addObserver:self
							 selector:@selector(updateListUserStatus:) 
								 name:SocketUpdateStatus
						   obServerId:@"GroupUserList_updateListUserStatus"];
}



- (void)viewWillAppear:(BOOL)animated 
{
	//清除内存中的数据 重新加载
	[[GroupDataManage getGroup:groupId] clearUsers];
	[self.parentViewController.navigationController setNavigationBarHidden:YES];
	[self.navigationController setNavigationBarHidden:NO];
}



//获取群用户数据后 更新列表
- (void)updateGroupUser:(NSString*)dataId 
{
	if ([dataId isEqualToString:groupId]) 
	{
		//请求群成员的状态
		CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
		[cimSocketLogicExt queryStatusForUsers:[[GroupDataManage getGroup:groupId] getUsersId]];
		[myTableView reloadData];
	}
}
		 


//更新群成员的状态
- (void)updateListUserStatus:(id)sender 
{
	[myTableView reloadData];
}



///////////////////////////////////////////////////////////////////////////////
		 
		 
		 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

		 

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
	groupUsers = [[GroupDataManage getGroup:groupId] getUsers];
	return [groupUsers count];
}
		 


- (UITableViewCell*)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString* cellid = @"cell";
	UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if (cell == nil) 
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:cellid] ;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	UserData *userInfo = [groupUsers objectAtIndex:indexPath.row];
	cell.imageView.image = [userInfo getHeadImage];
	cell.textLabel.text = [userInfo getUserName];
	
	return cell;
}




- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UserData *userInfo = [groupUsers objectAtIndex:indexPath.row];
	CIMFriendListDataStruct *cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
	CIMShopListDataStruct *cimShopListDataStruct = [CimGlobal getClass:@"CIMShopListDataStruct"];
	
	//将没有好友关系的群成员添加到陌生人列表中
	if (![cimFriendListDataStruct isMyUser:userInfo.userId] && ![cimShopListDataStruct isMyUser:userInfo.userId]) 
	{
		[userInfo setUserType:@"stranger"];
		//更新访客列表
		[cimFriendListDataStruct addStranger:userInfo];
		//将陌生人添加到好友列表中 更新视图
		[MyNotificationCenter postNotification:SystemEventDynamicAddFriend setParam:userInfo];
	}
	
	UserChatViewController *userChat = [[UserChatViewController alloc] init];
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = userInfo.userId;
	chatUser.chatType = @"user";
	[userChat setConcantUser:chatUser];
	[self.parentViewController.navigationController pushViewController:userChat animated:YES];
	return indexPath;
}
		 



@end
