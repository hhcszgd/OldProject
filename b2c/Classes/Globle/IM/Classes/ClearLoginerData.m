//
//  ClearLoginerData.m
//  IOSCim
//
//  Created by apple apple on 11-8-1.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ClearLoginerData.h"
#import "UserDataManage.h"
#import "ChatListDataStruct.h"
#import "GroupDataManage.h"
#import "GroupUserManage.h"
#import "CIMShopListDataStruct.h"
#import "CIMFriendListDataStruct.h"
#import "CimGlobal.h"
#import "CIMSocketLogicExt.h"
#import "GlobalAttribute.h"
 
@implementation ClearLoginerData


+ (void)clear 
{
	[GlobalAttribute logout];
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	//设置离线并关闭socket
	[cimSocketLogicExt setMyStatus:50];
	[self clearData];
}




//清空原有数据  洗牌
+ (void)clearData
{
	CIMShopListDataStruct *cimShopListDataStruct = [CimGlobal getClass:@"CIMShopListDataStruct"];
	CIMFriendListDataStruct *cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
	[cimShopListDataStruct clearData];
	[cimFriendListDataStruct clearData];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sessionId"];
	
	[UserDataManage clearData];
	[GroupDataManage clearData];
	[ChatListDataStruct clearData];	
	
	RecvSocketMessage *recvSocketMessage = [CimGlobal getClass:@"RecvSocketMessage"];
	[recvSocketMessage clearData];
}

@end
