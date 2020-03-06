//
//  RecvSocketMessage.m
//  IOSCim
//
//  Created by apple apple on 11-6-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "RecvSocketMessage.h"
#import "MessageStruct.h"
#import "UserChatData.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "MyNotificationCenter.h"
#import "MsgSound.h"
#import "SystemConfig.h"
#import "UserChatLog.h"
#import "OPChatLogData.h"
#import "GroupDataManage.h"
#import "GroupStruct.h"
#import "ChatUserStruct.h"
#import "RecvAddFriendRequest.h"
#import "RecvAddGroupRequest.h"
#import "RecvRemoveGroupUser.h"
#import "RecvInviteAddGroupUser.h"
#import "RecvAddGroupRequest.h"
#import "RecvAddGroupResponse.h"
#import "RecvGuestComeMessage.h"
#import "GetGuestHttp.h"
#import "RecvTempGuestMessage.h"
#import "RecvStrangerMessage.h"
#import "CIMShopListDataStruct.h"
#import "CIMFriendListDataStruct.h"
#import "CIMSocketLogicExt.h"
#import "Debuger.h"
#import "CimGlobal.h"
#import "Config.h"
#import "GlobalAttribute.h"
#import "SystemVariable.h"


@implementation RecvSocketMessage


//分发登录的消息
- (void)loginResult:(NSString *)code
{
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	
	if ([code isEqualToString:@"0"])
	{
		//记录登录状态
		[GlobalAttribute setIsLogined:YES];
		
		//发送状态请求
		CIMShopListDataStruct *cimShopListDataStruct = [CimGlobal getClass:@"CIMShopListDataStruct"];
		[cimSocketLogicExt queryStatusForUsers:[cimShopListDataStruct getListUsersId]];
		//发送心跳检测包
		[cimSocketLogicExt startCheckPackageTimer]; 
		[MyNotificationCenter postNotification:SocketDidLogin setParam:code];
		
		sleep(0.5);
		UserData *user = [UserDataManage getSelfUser];
		
		//矫正状态
		if ([SystemConfig getLoginStatus])
		{
			NSLog(@"隐身登录");
			[cimSocketLogicExt setMyStatus:40];
			[user setStatus:@"40"];
		} 
		else
		{
			NSLog(@"上线登录");
			[cimSocketLogicExt setMyStatus:10];
			[user setStatus:@"10"];
		}
	} 
	else if ([code isEqualToString:@"9"] && [GlobalAttribute getIsLogined]) 
	{
		[cimSocketLogicExt close:nil];
		[MyNotificationCenter postNotification:SystemEventCrowdedOffline setParam:nil];
		[Debuger systemAlert:@"该帐号在别处登录，您被迫下线！"];
	}
}



//接收客户端消息
- (void)recvUserMessage:(MessageStruct*)message 
{
	//陌生人消息
	if (![UserDataManage isExist:message.userId]) 
	{
		return;
	}
	
	
	UserChatData *chatData = [[UserChatData alloc] init];
	chatData.userName = [[UserDataManage getUser:message.userId] getUserName];
	chatData.sendTime = [message getTime];
	chatData.content = [message getContent];
	chatData.userId = message.userId;
	chatData.imageIdArray = [[NSMutableArray alloc] initWithArray:[message getImageIdArray]];
	[[UserDataManage getUser:message.userId] addMessage:chatData];
	
	OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
	
	//只保存没有图片内容的信息
	if (!message.isIncludeImage) 
	{
		//保存聊天记录
		[opChatlogData addMessageLog:[[UserDataManage getSelfUser] userId] 
						chatWitherId:message.userId
						sendObjectId:message.userId
					  messageContent:chatData.content
							sendTime:chatData.sendTime
						 messageType:1];
	}
	
	
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = message.userId;
	chatUser.chatType = @"user";
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketRecvMessage setParam:chatUser];
}



//接收用户的图片消息
- (void)recvUserImageMessage:(MessageStruct*)message 
{
	//陌生人消息
	if (![UserDataManage isExist:message.userId]) 
	{
		return;
	}
	
	UserChatData *chatData = [[UserChatData alloc] init];
	chatData.userName = [[UserDataManage getUser:message.userId] getUserName];
	chatData.sendTime = [message getTime];
	chatData.content = [message getContent];
	chatData.userId = message.userId;
	
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = message.userId;
	chatUser.chatType = @"user";
	
	NSArray *paramArray = [chatData.content componentsSeparatedByString:@","];
	NSString *imageId = [paramArray objectAtIndex:2];
	imageId = [imageId substringWithRange: NSMakeRange(1, [imageId length] - 2)];
	NSString *downloadId = [paramArray objectAtIndex:0];
	downloadId = [Config getDownloadPath:downloadId];
	
	[[UserDataManage getUser:message.userId] addImageMessage:imageId downloadId:downloadId messageType:1];
	NSMutableDictionary *paramDictionary = [[NSMutableDictionary alloc] init];
	[paramDictionary setObject:imageId forKey:@"imageId"];
	[paramDictionary setObject:downloadId forKey:@"downloadId"];
	//通知聊天窗口接收图片
	[MyNotificationCenter postNotification:SocketRecvImageMessage setParam:paramDictionary];
}




//保存临时用户消息
- (void)saveTempUserMessage:(MessageStruct*)message 
{
	//创建消息结构
	UserChatData *chatData = [[UserChatData alloc] init];
	chatData.sendTime = [message getTime];
	chatData.content = [message getContent];
	chatData.userId = message.userId;
	//获取消息内容中 图标的id数组
	chatData.imageIdArray = [[NSMutableArray alloc] initWithArray:[message getImageIdArray]];
	
	CIMShopListDataStruct *cimShopListDataStruct = [CimGlobal getClass:@"CIMShopListDataStruct"];
	CIMFriendListDataStruct *cimFriendListDataStruct = [CimGlobal getClass:@"CIMFriendListDataStruct"];
	
	if ([cimShopListDataStruct isMyUser:message.userId] || [cimFriendListDataStruct isMyUser:message.userId]) 
	{
		
		//用户信息尚未获取完成 继续寄存消息
		if ([[UserDataManage getUser:message.userId].userType isEqualToString:@"tempUser"]) 
		{
			[[UserDataManage getUser:message.userId] addMessage:chatData];
		} 
		else
		{
			//用户信息已经获取完 直接显示信息
			[self recvUserMessage:message];
			return;
		}
		
		//没有用户的信息 创建临时用户 寄存消息 并调用接口获取用户信息 等待接口完成时通知接收消息
	} 
	else 
	{
		//创建临时用户
		UserData *tempUser = [UserData alloc];
		tempUser.userId = message.userId;
		tempUser.userType = @"tempUser";
		[UserDataManage addUser:tempUser];
		//保存消息
		[tempUser addMessage:chatData];

        
		RecvStrangerMessage *recvStrangerMessage = [RecvStrangerMessage alloc];
		[recvStrangerMessage init:message.userId];
	}
	
	
	OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
	//保存聊天记录
	[opChatlogData addMessageLog:[[UserDataManage getSelfUser] userId] 
					chatWitherId:message.userId
					sendObjectId:message.userId
				  messageContent:[message getContent]
						sendTime:[message getTime]
					 messageType:1];
	
}



//保存临时的访客消息
- (void)saveTempGuestMessage:(MessageStruct*)message 
{
	//创建消息结构
	UserChatData *chatData = [[UserChatData alloc] init];
	chatData.sendTime = [message getTime];
	chatData.content = [message getContent];
    chatData.userId = message.userId;
	chatData.imageIdArray = [[NSMutableArray alloc] initWithArray:[message getImageIdArray]];
	
	if ([UserDataManage isExist:message.userId]) 
	{
		//访客信息尚未获取完成 继续寄存消息
		if ([[UserDataManage getUser:message.userId].userType isEqualToString:@"tempGuest"]) 
		{
			[[UserDataManage getUser:message.userId] addMessage:chatData];
		} 
		else 
		{
			//访客信息已经获取完 直接显示信息
			[self recvUserMessage:message];
		}
		
		//没有该访客的信息 窗口临时用户 寄存消息 并调用接口获取访客信息 等待接口完成时通知接收消息
	} 
	else 
	{
		//创建临时用户
		UserData *tempGuest = [UserData alloc];
		tempGuest.userId = message.userId;
		tempGuest.userType = @"tempGuest";
		[UserDataManage addUser:tempGuest];
		//保存消息
		[tempGuest addMessage:chatData];
		
		GetGuestHttp *http = [GetGuestHttp alloc];
		[http init:message.userId];
		
		RecvTempGuestMessage *recvTempGuestMessage = [RecvTempGuestMessage alloc];
		[recvTempGuestMessage init:message.userId];
	}
	
	OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
    

    
	//保存聊天记录
	[opChatlogData addMessageLog:[[UserDataManage getSelfUser] userId] 
									   chatWitherId:message.userId
									   sendObjectId:message.userId
									 messageContent:[message getContent]
										   sendTime:[message getTime]
										messageType:1];
}



//接收群消息
- (void)recvGroupMessage:(MessageStruct*)message 
{
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	UserChatData *chatData = [[UserChatData alloc] init];
	chatData.userName = [[UserDataManage getUser:message.userId] getUserName];
	chatData.sendTime = [message getTime];
	chatData.content = [message getContent];
	chatData.userId = message.userId;
	chatData.groupId = message.groupId;
	
	if ([chatData.userId isEqualToString:[UserDataManage getSelfUser].userId]) 
	{
		chatData.isSelf = YES;
	}
	
	GroupStruct *group = [GroupDataManage getGroup:message.groupId];
	[group addMessage:chatData];
	
	if (!message.isIncludeImage)
	{
		OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
		[opChatlogData addMessageLog:[[UserDataManage getSelfUser] userId] 
						chatWitherId:message.groupId
						sendObjectId:message.userId
					  messageContent:chatData.content
							sendTime:chatData.sendTime
						 messageType:1004];
	}
	
	chatUser.dataId = message.groupId;
	chatUser.chatType = @"group";
	
	//用户设置不接收该群消息 不做消息提醒
	if (!group.isRecvMessage) 
	{
		return;
	}
	
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketRecvMessage setParam:chatUser];
}



//接收群的图片消息
- (void)recvGroupImageMessage:(MessageStruct*)message 
{
	
	UserChatData *chatData = [[UserChatData alloc] init];
	chatData.userName = [[UserDataManage getUser:message.userId] getUserName];
	chatData.sendTime = [message getTime];
	chatData.content = [message getContent];
	chatData.userId = message.userId;
	
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	chatUser.dataId = message.groupId;
	chatUser.chatType = @"group";
	NSArray *paramArray = [chatData.content componentsSeparatedByString:@","];
	NSString *imageId = [paramArray objectAtIndex:2];
	imageId = [imageId substringWithRange: NSMakeRange(1, [imageId length] - 2)];
	NSString *downloadId = [paramArray objectAtIndex:0];
	downloadId = [Config getDownloadPath:downloadId];
	
	GroupStruct *group = [GroupDataManage getGroup:message.groupId];
	[group addImageMessage:imageId downloadId:downloadId messageType:1004];

	NSMutableDictionary *paramDictionary = [[NSMutableDictionary alloc] init];
	[paramDictionary setObject:imageId forKey:@"imageId"];
	[paramDictionary setObject:downloadId forKey:@"downloadId"];
	//通知聊天窗口接收图片
	[MyNotificationCenter postNotification:SocketRecvImageMessage setParam:paramDictionary];
}



//接收群系统消息
+ (void)recvSystemGroupMessage:(NSString*)type
					   groupId:(NSString*)groupId
					   message:(MessageStruct*)message 
					   content:(NSString*)content
{
	
	ChatUserStruct *chatUser = [ChatUserStruct alloc];
	UserChatData *chatData = [[UserChatData alloc] init];
	chatData.userName = @"系统消息";
	chatData.sendTime = [message getTime];
	chatData.content = content;
	chatData.userId = message.userId;
	chatData.isSystemMessage = YES;
	
	GroupStruct *group = [GroupDataManage getSystemGourpData:groupId];
	[group addMessage:chatData];
	
	OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
	[opChatlogData addMessageLog:[UserDataManage getSelfUser].userId 
									   chatWitherId:groupId
									   sendObjectId:message.userId
									 messageContent:chatData.content
										   sendTime:chatData.sendTime
										messageType:1004];
	chatUser.dataId = message.groupId;
	chatUser.chatType = @"group";
	
	//用户设置不接收该群消息 不做消息提醒
	if (!group.isRecvMessage && ![type isEqualToString:@"removeMeFromGroup"]) 
	{
		return;
	}
	
	//记录消息通知次数
	[MyNotificationCenter postNotification:SocketRecvMessage setParam:chatUser];
}



//接收并分配消息
- (void)recvMessage:(MessageStruct*)message 
{
	BOOL isSoundPrompt = YES;
    BOOL isGroupMessage = YES;
    
    NSLog(@"message:%d", [message getType]);	
	
	  //客户端消息
	if ([message getType] == SocketMessageTypeWindowsUser) 
	{
		[self saveTempUserMessage:message];
		
	} //群消息
	else if ([message getType] == SocketMessageTypeGroupUser) 
	{
        isGroupMessage = YES;
        if ([SystemConfig isReceiveGroupMessage] || message.userId.longLongValue == [[UserDataManage getSelfUser] userId].longLongValue) {
            [self recvGroupMessage:message];
        }
	} //访客消息
	else if ([message getType] == SocketMessageTypeBowserUser) 
	{
      
		[self saveTempGuestMessage:message];
		
	} //来访消息
	else if ([message getType] == SocketMessageTypeGuestCome) 
	{
		RecvGuestComeMessage *recvGuestComeMessage = [RecvGuestComeMessage alloc];
		recvGuestComeMessage.message = message;
		[recvGuestComeMessage init];
		
	  //请求加我为好友消息  / 添加群请求
	} 
	else if ([message getType] == SocketMessageRequestAddFriend) 
	{
		//有人请求加自己为好友
		if ([message.groupId isEqualToString:@"0"])
		{
			RecvAddFriendRequest *recvAddFriendRquest = [RecvAddFriendRequest alloc];
			recvAddFriendRquest.requestContent = [message getContent];
			recvAddFriendRquest.messageType = @"addFriendRequest";
			[recvAddFriendRquest recvMessage:message.userId];
		} 
		else //有人请求加入自己的群
		{
			RecvAddGroupRequest *recvAddGroupRequest = [RecvAddGroupRequest alloc];
			recvAddGroupRequest.requestContent = [message getContent];
			recvAddGroupRequest.messageType = @"addGroupRequest";
			recvAddGroupRequest.groupId = message.groupId;
			[recvAddGroupRequest recvMessage:message.userId];
		}
		
		//对方同意加我为好友 或创建者同意我加入群
	} 
	else if ([message getType] == SocketMessageAgreeAddFriend) 
	{
		
			//同意加我为好友
		if ([message.groupId isEqualToString:@"0"]) 
		{
			RecvAddFriendRequest *recvAddFriendRquest = [RecvAddFriendRequest alloc];
			recvAddFriendRquest.requestContent = [message getContent];
			recvAddFriendRquest.messageType = @"agreeAddFriend";
			[recvAddFriendRquest recvMessage:message.userId];
		} 
		else //同意将我加入群
		{
			RecvAddGroupResponse *recvAddGroupResponse = [RecvAddGroupResponse alloc];
			recvAddGroupResponse.requestContent = [message getContent];
			recvAddGroupResponse.messageType = @"agreeAddGroup";
			recvAddGroupResponse.groupId = message.groupId;
			recvAddGroupResponse.message = message;
			[recvAddGroupResponse init];
		}
		
		
	} //对方拒绝加我为好友
	else if ([message getType] == SocketMessageRefuseAddFriend) 
	{
		if ([message.groupId isEqualToString:@"0"])
		{
			RecvAddFriendRequest *recvAddFriendRquest = [RecvAddFriendRequest alloc];
			recvAddFriendRquest.requestContent = [message getContent];
			recvAddFriendRquest.messageType = @"refuseAddFriend";
			[recvAddFriendRquest recvMessage:message.userId];
		} 
		else //对方拒绝将我加入群
		{
			RecvAddGroupResponse *recvAddGroupResponse = [RecvAddGroupResponse alloc];
			recvAddGroupResponse.requestContent = [message getContent];
			recvAddGroupResponse.messageType = @"refuseAddGroup";
			recvAddGroupResponse.groupId = message.groupId;
			recvAddGroupResponse.message = message;
			[recvAddGroupResponse init];
		}
		
		//删除群成员
	} 
	else if ([message getType] == SocketMessageRemoveGroupUser || [message getType] == SocketMessageOldRemoveGroupUser) 
	{
		NSString *content = [message getContent];
		NSString *removedUserId = [[content componentsSeparatedByString:@","] objectAtIndex:0];
		RecvRemoveGroupUser *recvRemoveGroupUser = [RecvRemoveGroupUser alloc];
		recvRemoveGroupUser.groupId = message.groupId;
		recvRemoveGroupUser.removeUserId = removedUserId;
		recvRemoveGroupUser.message = message;
		[recvRemoveGroupUser init];
	}	//群被解散了
	else if ([message getType] == SocketMessageDissolveGroup || [message getType] == SocketMessageOldDissolveGroup) 
	{
		if ([GroupDataManage isMyGroup:message.groupId]) 
		{
			[GroupDataManage removeGroup:message.groupId];
			//系统提示 同意我加入群
			ChatUserStruct *chatUser = [ChatUserStruct alloc];
			chatUser.dataId = message.groupId;
			chatUser.chatType = @"dissolveGroup";
			
			//记录消息通知次数
			[MyNotificationCenter postNotification:SocketRecvMessage setParam:chatUser];
			[MyNotificationCenter postNotification:SystemEventUpdateGroupView setParam:nil];
		}
		
		//群创建者直接加用户入群
	} 
	else if ([message getType] == SocketMessageInviteAddGroup || [message getType] == SocketMessageOldInviteAddGroup) 
	{
		NSString *content = [message getContent];
		NSString *addUserId = [[content componentsSeparatedByString:@","] objectAtIndex:0];
		RecvInviteAddGroupUser *recvInviteAddGroupUser = [RecvInviteAddGroupUser alloc];
		recvInviteAddGroupUser.groupId = message.groupId;
		recvInviteAddGroupUser.addUserId = addUserId;
		recvInviteAddGroupUser.message = message;
		[recvInviteAddGroupUser init];
	} //接收用户图片
	else if ([message getType] == SocketRecvImage) 
	{
		NSLog(@"图片的第二道消息%@", [message getContent]);
		[self recvUserImageMessage:message];
	} //接收群图片 
	else if ([message getType] == SocketRecvGroupImage) 
	{
		[self recvGroupImageMessage:message];
	}
	else
	{
		isSoundPrompt = NO;
	}
	
	
	if (isSoundPrompt) {
        //群消息设置为不接收的情况下 则不再提示
        if (isGroupMessage && ![SystemConfig isReceiveGroupMessage] && message.userId.longLongValue != [[UserDataManage getSelfUser] userId].longLongValue) {
            return;
        }
		if ([SystemConfig isSoundRemind]) {
			[MsgSound play];
		}
        if ([SystemConfig isShockMode]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
	}
}



- (void)clearData {
	isLoginSuccess = NO;
}

@end
