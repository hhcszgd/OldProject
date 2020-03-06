//
//  RecvAddFriendRequest.m
//  IOSCim
//
//  Created by apple apple on 11-8-4.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "RecvAddFriendRequest.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "MyNotificationCenter.h"
#import "ChatUserStruct.h"
#import "AddFriendHttp.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "GetUserWithIdHttp.h"
#import "CIMFriendListDataStruct.h"
#import "CimGlobal.h"



@implementation RecvAddFriendRequest
@synthesize requestContent, messageType;

//static RecvAddFriendRequest *sharedRootController = nil;

- (void)recvHttpData:(UserData*)user {
}
- (void)recvMessage:(NSString*)userId 
{
	//过滤无效字符
	if ([requestContent isEqualToString:@"@"] || [requestContent isEqualToString:@"-"]) 
	{
		requestContent = @"";
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
	chatUser.dataId = user.userId;
	chatUser.chatType = messageType;
    chatUser.additionalMessage = requestContent;
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketRecvMessage setParam:chatUser];
	//收到同意加好友消息 调用数据接口建立好友关系 动态添加中好友列表中
	if ([messageType isEqualToString:@"agreeAddFriend"]) 
	{
		AddFriendHttp *http = [AddFriendHttp alloc];
		http.delegate = self;
		[http init:user.userId kindName:@"" option:@"agree"];
	}
}



//添加好友成功
- (void)successAddFriend:(UserData*)user 
{
	//更新好友列表
	user.kindId = @"1"; //默认添加到我的好友列表中
	CIMFriendListDataStruct *cimUserListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
    BOOL hasOne = NO;
    NSMutableArray *userList = [cimUserListDataStruct getListUsers];
    for (UserData *userOne in userList) {
        if ([userOne.userId isEqualToString:user.userId]) {
            if ([userOne.userType isEqualToString:@"stranger"]) {
                UserListKindDataStruct *strangerKind = [cimUserListDataStruct getListKind:@"stranger"];
                [strangerKind removeUser:userOne.userId];
                CIMUserListDataStruct *cimUserListDataStruct = (CIMUserListDataStruct *)[CimGlobal getClass:@"CIMShopListDataStruct"];
                UserListKindDataStruct *kind = [cimUserListDataStruct getListKind:userOne.kindId];
                [kind removeUser:userOne.userId];
                [MyNotificationCenter postNotification:SystemEventDynamicRemoveFriend setParam:userOne];
            } else {
                hasOne = YES;
                break;
            }
        }
    }
    if (!hasOne) {
        user.kindId = @"1";
        [cimUserListDataStruct addListUser:user];
    }
	//刷新好友列表
	[MyNotificationCenter postNotification:SystemEventDynamicAddFriend setParam:user];	
}



- (void)errorAddFriend:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}


@end
