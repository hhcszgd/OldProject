//
//  RecvStrangerMessage.m
//  IOSCim
//
//  Created by apple apple on 11-8-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "RecvStrangerMessage.h"
#import "GetUserWithIdHttp.h"
#import "Debuger.h"
#import "CIMFriendListDataStruct.h"
#import "MyNotificationCenter.h"
#import "ChatUserStruct.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "CimGlobal.h"
#import "ErrorParam.h"
#import "CIMSocketLogicExt.h"


@implementation RecvStrangerMessage


- (void)init:(NSString*)userId 
{
	_userId = userId;
	GetUserWithIdHttp *http = [GetUserWithIdHttp alloc];
	http.delegate = self;
	[http init:_userId];
}



- (void)recvGetUserData:(UserData*)user 
{
	UserData *tempUser = [UserDataManage getUser:_userId];
	tempUser.nickname = user.nickname;
	tempUser.idiograph = user.idiograph;
    NSMutableArray *messages = [tempUser getMessage];
    if (messages && [messages count] > 0) {
        UserChatData *userChatData = [messages lastObject];
        if (!userChatData.userName) {
            userChatData.userName = user.nickname;
        }
    }
	[tempUser setUserType:@"stranger"];
	
    CIMFriendListDataStruct *cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
    //更新访客列表
    [cimFriendListDataStruct addStranger:user];
    
	//将陌生人添加到好友列表中 更新视图
	[MyNotificationCenter postNotification:SystemEventDynamicAddFriend setParam:tempUser];
	
	//发送消息通知
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = _userId;
	chatUser.chatType = @"user";
	
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketUpdateStatus setParam:nil];
	//获取访客状态
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	[cimSocketLogicExt queryStatusForUser:_userId];
}



- (void)errorFunction:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}


@end
