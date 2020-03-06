//
//  SearchFriend.m
//  IOSCim
//
//  Created by apple apple on 11-7-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SearchFriend.h"
#import "Config.h"
#import "MyNotificationCenter.h"
#import "Debuger.h"
#import "AddFriendRequest.h"
#import "CIMFriendListDataStruct.h"
#import "ExistFriendHttp.h"
#import "AddFriendHttp.h"
#import "ErrorParam.h"
#import "GetUserWithLoginIdHttp.h"
#import "CimGlobal.h"
#import "CIMSocketLogicExt.h"


@implementation SearchFriend
@synthesize searchUserLoginIdFiled;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	/*
	[MyNotificationCenter addObserver:self 
							 selector:@selector(showSearchResult:) 
								 name:HttpGetUserDataComplete 
						   obServerId:@"SearchFriend_showSearchResult"];*/
	
	[MyNotificationCenter addObserver:self 
							 selector:@selector(addFriendResult:) 
								 name:HttpAddFriendDataComplete 
						   obServerId:@"SearchFriend_addFriendResult"];
	
	promptMessage = @"查到的用户";
	cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
    [super viewDidLoad];
}
	 



- (void)recvGetUserData:(UserData*)user 
{
	promptMessage = @"查到的用户";
	searchResult = user;
	[myTableView reloadData];
	myTableView.hidden = NO;
}




- (void)errorGetUserData:(ErrorParam*)error 
{
	promptMessage = @"没有数据";
	[myTableView reloadData];
	myTableView.hidden = NO;
}



//獲取分區的數量
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
	myTableView = tableView;
	return 1;
}



//行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (searchResult == nil) 
	{
		return 0;
	}
	
	return 1;
}



//行的創建
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) 
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] ;
    }
	
	cell.imageView.image = [UIImage imageNamed:@"DefaultHead.png"];
	cell.textLabel.text = searchResult.nickname;
	cell.detailTextLabel.text = searchResult.idiograph;
	return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return 50;
}



//分区标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	return promptMessage;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (!isRequestData) 
	{

		if ([cimFriendListDataStruct isMyUser:searchResult.userId]) 
		{
			[Debuger systemAlert:@"该用户已经是您的好友,不能再添加"];
			return;
		}
		
		
		//拒绝加任何人为好友
		if ([searchResult.friendVerifyType isEqualToString:@"2"]) 
		{
			isRequestData = NO;
			[Debuger systemAlert:@"对方拒绝任何人加他为好友"];
			return;
		}
		
		isRequestData = YES;
		//判断是否存在单边好友或黑名单关系
		ExistFriendHttp *http = [ExistFriendHttp alloc];
		http.delegate = self;
		[http init:searchResult.loginId];
		return;
	}
}



//是单边好友
- (void)isUnilateralFriend:(id)sender 
{
	//不通知对方
	isNoticeAddFriend = NO; 
	AddFriendHttp *http = [AddFriendHttp alloc];
	http.delegate = self;
	[http init:searchResult.userId kindName:@"" option:@"add"];
}



//是黑名单用户
- (void)isBlackListUser:(id)sender 
{
	isRequestData = NO;
	[Debuger systemAlert:@"对方已经将您加入黑名单，不能添加好友"];
}



//是普通用户无任何关系
- (void)isNormalUser:(id)sender 
{
	//通知对方
	isNoticeAddFriend = YES;
	
	//允许任何人加为好友
	if ([searchResult.friendVerifyType isEqualToString:@"0"]) {
		AddFriendHttp *http = [AddFriendHttp alloc];
		http.delegate = self;
		[http init:searchResult.userId kindName:@"" option:@"add"];
	//需要验证
	} else if ([searchResult.friendVerifyType isEqualToString:@"1"]) {
		isRequestData = NO;
		AddFriendRequest *addFriendRequest = [AddFriendRequest alloc];
		addFriendRequest.tipsMessage = searchResult.nickname;
		addFriendRequest.friendId = searchResult.userId;
		[self.navigationController pushViewController:addFriendRequest animated:YES];
	}
}




//添加好友成功
- (void)successAddFriend:(UserData*)user 
{
	isRequestData = NO;
	[Debuger systemAlert:@"添加成功，请在好友列表中查看"];
	//发送确认消息让对方的好友列表中消息自己
	
	if (isNoticeAddFriend) 
	{
		CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
		[cimSocketLogicExt sendAgreeAddFriendMessage:searchResult.userId];
	}
	
	//更新好友列表
	searchResult.kindId = @"1"; //默认添加到我的好友列表中
	CIMFriendListDataStruct *cimUserListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
	[cimUserListDataStruct addListUser:user];
	
	//刷新好友列表
	[MyNotificationCenter postNotification:SystemEventDynamicAddFriend setParam:searchResult];	
}




- (void)errorAddFriend:(ErrorParam*)error 
{
	isRequestData = NO;
	[Debuger systemAlert:error.errorInfo];
}




- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar 
{
	[self.navigationController setNavigationBarHidden:YES];
	searchBar.text = @"";
	return YES;
}




- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
	[searchBar resignFirstResponder];
	[self.navigationController setNavigationBarHidden:NO];
	
	if ([searchBar.text isEqualToString:@""]) 
	{
		return;
	}
	
	NSString *userLoginId = [searchBar.text stringByAppendingString:[Config getDomain]];
	//userLoginId = @"罗永强";
	GetUserWithLoginIdHttp *http = [GetUserWithLoginIdHttp alloc];
	http.delegate = self;
	[http init:userLoginId];
}





@end
