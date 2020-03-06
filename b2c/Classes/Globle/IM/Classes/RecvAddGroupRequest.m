//
//  RecvAddGroupRequest.m
//  IOSCim
//
//  Created by apple apple on 11-8-10.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "RecvAddGroupRequest.h"
#import "GetGroupHttp.h"
#import "GroupStruct.h"
#import "GroupDataManage.h"
#import "MyNotificationCenter.h"
#import "ChatUserStruct.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "GetUserWithIdHttp.h"
#import "UserDataManage.h"

@implementation RecvAddGroupRequest
@synthesize requestContent, messageType, groupId;


//解析消息 调用接口获取群信息
- (void)recvMessage:(NSString*)userId 
{
	//过滤无效字符
	if ([requestContent isEqualToString:@"－"]) 
	{
		requestContent = @"";
	} 
	
	
	if ([UserDataManage isExist:userId]) 
	{
		[self recvGetUserData:[UserDataManage getUser:userId]];
		return;
	}
	
	
	GetUserWithIdHttp *http = [GetUserWithIdHttp alloc];
	http.delegate = self;
	[http init:userId];
}



//委托函数  接收接口所有获取的数据
- (void)recvGetUserData:(UserData*)user 
{
	//将用户数据加载的系统中
	[UserDataManage addUser:user];
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = groupId;
	chatUser.additionalUserId = user.userId;
	chatUser.chatType = messageType;
	chatUser.additionalMessage = requestContent;
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketRecvMessage setParam:chatUser];
}



- (void)errorGetUserData:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}

@end
