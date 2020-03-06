//
//  CIMGuestUserTreeViewController.m
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMGuestUserTreeViewController.h"
#import "CimGlobal.h"
#import "MyNotificationCenter.h"


@implementation CIMGuestUserTreeViewController

//加载完成回调
- (void)viewDidLoad 
{
	cimUserListDataStruct = [CimGlobal getClass:@"CIMGuestListDataStruct"];
	windowTitle = @"访客";
	className = @"CIMGuestListDataStruct";
	lookInfoSelector = @selector(lookGuestUserInfo:);
	
	[MyNotificationCenter addObserver:self selector:@selector(dynamicAddUser:) 
								 name:SystemEventUpdateGuestView 
						   obServerId:@"CIMGuestUserTreeViewController_dynamicAddUser"];
	
	[self loadInit];
}




//动态添加人员
- (void)dynamicAddUser:(UserData*)user 
{
	if (self.isViewLoaded) 
	{
		TreeNode *userNode = [[TreeNode alloc] init];
		userNode.title = [user getUserName];
		userNode.key = [@"kinduser" stringByAppendingString:user.userId];
		userNode.nodeType = @"node";
		userNode.info = user.idiograph;
		userNode.param = user.userId;
		
		TreeNode *kind = [userNodesDictionary objectForKey:@"1"];
		[kind addChild:userNode];
		[userNodes removeAllObjects];
		[TreeNode getNodes:userTree :userNodes];
		[self updateUserStatus:nil];
	}
}


	 

//更新列表
- (void)updateUserList:(id)sender 
{
	[treeTableView reloadData];
}

	 

//跳转到查看企业用户详细信息窗口
- (void)lookGuestUserInfo:(UIButton*)sender 
{
	/*
	ShopUserNavigation *shopUserNavigation = [ShopUserNavigation alloc];
	shopUserNavigation.optUserId = [sender titleForState:UIControlStateNormal];
	[self.navigationController pushViewController:shopUserNavigation animated:YES];*/
}


@end
