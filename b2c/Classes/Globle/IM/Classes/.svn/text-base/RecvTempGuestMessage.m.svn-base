//
//  RecvTempGuestMessage.m
//  IOSCim
//
//  Created by apple apple on 11-8-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "RecvTempGuestMessage.h"
#import "GetGuestHttp.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "ErrorParam.h"
#import "Debuger.h"
#import "CIMGuestListDataStruct.h"
#import "CimGlobal.h"
#import "UserListKindDataStruct.h"
#import "MyNotificationCenter.h"
#import "ChatUserStruct.h"
#import "CIMSocketLogicExt.h"
#import "CimGlobal.h"



@implementation RecvTempGuestMessage


- (void)init:(NSString*)userId 
{
	_userId = userId;
	GetGuestHttp *http = [GetGuestHttp alloc];
	http.delegate = self;
	[http init:_userId];
}



- (void)recvGetGuestData:(UserData*)user 
{
	UserData *tempUser = [UserDataManage getUser:_userId];
	tempUser.nickname = user.nickname;
	tempUser.guestCode = user.guestCode;
    tempUser.kindId = @"1";
	[tempUser setStatus:@"10"];
	[tempUser setUserType:@"guest"];
	
	CIMGuestListDataStruct *cimGuestListDataStruct = [CimGlobal getClass:@"CIMGuestListDataStruct"];
	//更新访客列表
	[[cimGuestListDataStruct getListKind:@"1"] addUser:tempUser];
	
	//将访客添加到访客列表中 更新视图
	[MyNotificationCenter postNotification:SystemEventUpdateGuestView setParam:tempUser];
	
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



- (void)getGuestError:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}

@end
