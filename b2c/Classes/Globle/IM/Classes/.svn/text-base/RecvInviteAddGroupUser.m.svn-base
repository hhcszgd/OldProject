//
//  RecvInviteAddGroupUser.m
//  IOSCim
//
//  Created by apple apple on 11-8-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "RecvInviteAddGroupUser.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "GroupDataManage.h"
#import "ChatUserStruct.h"
#import "GetUserWithIdHttp.h"
#import "UserData.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "ChatUserStruct.h"
#import "GroupDataManage.h"
#import "GetGroupHttp.h"
#import "RecvSocketMessage.h"
#import "MyNotificationCenter.h"

@implementation RecvInviteAddGroupUser

@synthesize groupId, addUserId, message;

- (instancetype)init {
	//已有的群
	if ([GroupDataManage isMyGroup:groupId]) 
	{
        [self analysisUser:nil];
	} 
	else 
	{
		//获取群数据
		GetGroupHttp *http = [GetGroupHttp alloc];
		http.delegate = self;
		[http initWithGourpId:groupId];
	}
    return nil ;
}




//得到群数据
- (void)recvGetGroupData:(GroupStruct*)group 
{
	[GroupDataManage addGroup:group];
    [self analysisUser:group];
}



//得到群数据
- (void)errorGetGroup:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}



//分析被添加入群的用户
- (void)analysisUser:(GroupStruct *)group
{
	
	//是自己 通知后 刷新群列表
	if ([[UserDataManage getSelfUser].userId isEqualToString:addUserId]) 
	{
        UserData *userDataOne = [UserDataManage getUser:message.userId];
		NSString *groupMasterName = [userDataOne getUserName];
		NSString *content = [[NSString alloc] initWithFormat:@"管理员 %@ 将您加入该群", groupMasterName];
		[MyNotificationCenter postNotification:SystemEventUpdateGroupView setParam:nil];
        if (group) {
            [MyNotificationCenter postNotification:SystemEventDynamicAddGroup setParam:group];
        }
		[RecvSocketMessage recvSystemGroupMessage:@"inviteMeToGroup" groupId:groupId message:message content:content];
		 
		//是别人 获取用户信息 
	} 
	else 
	{
		
		if ([UserDataManage isExist:addUserId]) 
		{
			[self recvGetUserData:[UserDataManage getUser:addUserId]];
		} 
		else 
		{
			GetUserWithIdHttp *http = [GetUserWithIdHttp alloc];
			http.delegate = self;
			[http init:addUserId];
		}
	}	
}



//得到用户数据 出现系统消息
- (void)recvGetUserData:(UserData*)user 
{
    UserData *userDataOne = [UserDataManage getUser:message.userId];
    NSString *groupMasterName = [userDataOne getUserName];
	NSString *content = [[NSString alloc] initWithFormat:@"管理员 %@ 将用户 %@ 加入该群", groupMasterName, [user getUserName]];
	[RecvSocketMessage recvSystemGroupMessage:@"inviteOtherToGroup" 
									  groupId:groupId 
									  message:message 
									  content:content];
	
}



- (void)errorGetUserData:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}

@end
