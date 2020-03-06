//
//  RecvAddGroupResponse.m
//  IOSCim
//
//  Created by apple apple on 11-8-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
// 我请求加入别人的群  在此接收回应信息
//

#import "RecvAddGroupResponse.h"
#import "UserData.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "ChatUserStruct.h"
#import "GroupDataManage.h"
#import "GetGroupHttp.h"
#import "RecvSocketMessage.h"
#import "MyNotificationCenter.h"
#import "UserDataManage.h"
#import "GetUserWithIdHttp.h"


@implementation RecvAddGroupResponse
@synthesize groupId, message, messageType, requestContent;

//
//- (void)init 
//{
//	   //已有的群
//	if ([GroupDataManage isMyGroup:groupId])
//	{
//		[self getUserInfo];
//	} 
//	else 
//	{
//		//获取群数据
//		GetGroupHttp *http = [GetGroupHttp alloc];
//		http.delegate = self;
//		[http initWithGourpId:groupId];
//	}
//}



//得到群数据
- (void)recvGetGroupData:(GroupStruct*)group 
{
	//通知消息
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = group.groupId;
	chatUser.chatType = messageType;
	
		//同意 将群添加到群列表中
	if ([messageType isEqualToString:@"agreeAddGroup"])
	{
		[GroupDataManage addGroup:group];
		//更新群列表
		[MyNotificationCenter postNotification:SystemEventUpdateGroupView setParam:nil];
	} 
	else
	{
		//拒绝 只保存在内存中
		[GroupDataManage saveSystemGroupData:group];
	}
	
	
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketRecvMessage setParam:chatUser];

	[self getUserInfo];
}



//得到群数据
- (void)errorGetGroup:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}



//获取用户信息
- (void)getUserInfo 
{
	if ([UserDataManage isExist:message.userId]) 
	{
		[self recvGetUserData:[UserDataManage getUser:message.userId]];
	} 
	else 
	{
		GetUserWithIdHttp *http = [GetUserWithIdHttp alloc];
		http.delegate = self;
		[http init:message.userId];
	}
}



//得到用户数据 出现系统消息
- (void)recvGetUserData:(UserData*)user 
{
	[UserDataManage addUser:user];
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = groupId;
	chatUser.additionalUserId = user.userId;
	chatUser.chatType = messageType;
	chatUser.additionalMessage = requestContent;
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketUpdateStatus setParam:nil];
}



- (void)errorGetUserData:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}



@end
