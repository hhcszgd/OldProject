//
//  SocketManage.m
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SocketManage.h"
#import "IOSCimAppDelegate.h"
#import "Config.h"
#import "AsyncSocket.h"
#import "MyNotificationCenter.h"
#import "MessageStruct.h"
#import "ChatUserStruct.h"
#import "SystemConfig.h"
#import "MsgSound.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "GroupDataManage.h"
#import "GroupStruct.h"

@implementation SocketManage

static AsyncSocket *asyncSocket;
static int updateStatusNumber;
BOOL isRuningNoticeStatus;
static NSMutableArray *updateMessageArray;
BOOL isRuningNoticeMessage;



//记录状态的更新次数
+ (void)rememberUpdateStatusNumber {
	
}



//记录消息的更新次数
+ (void)rememberUpdateMessageNumber:(ChatUserStruct*)user {
}



//创建连接
+ (void)connectSocket {
	}



//获取用户在线状态
+ (void)requestUserStatus:(NSMutableArray*)usersId {
	
}


//获取单个用户状态
+ (void)requestOneUserStatus:(NSString*)userId {
	}


//设置自己的状态
+ (void)setMyStatus:(int)status {
	
}



//申请加入群
+ (void)sendAddGroupRequest:(NSString*)groupId groupMasterId:(NSString*)groupMasterId {
	
}



//决绝加入我的群
+ (void)sendRefuseAddGroupMessage:(NSString*)groupId userId:(NSString*)userId {

}



//决绝加入我的群
+ (void)sendAgreeAddGroupMessage:(NSString*)groupId userId:(NSString*)userId {
	
}



//退出群
+ (void)leaveGroupMessage:(NSString*)groupId {
	
}



//解散群
+ (void)dissolveGroupMessage:(NSString*)groupId {
	
}



//发送请求添加好友的消息
+ (void)sendRequestAddFriendMessage:(NSString*)friendId 
					 requestContent:(NSString*)requestContent {
	

}



//发送同意添加为好友消息
+ (void)sendAgreeAddFriendMessage:(NSString*)friendId {
}



//发送拒绝添加为好友消息
+ (void)sendRefuseAddFriendMessage:(NSString*)friendId {
	
}



//发送多个用户消息
+ (void)sendMessage:(NSString*)message 
			usersId:(NSMutableArray*)usersId {
	
	
}



//发送单个用户消息
+ (void)sendMessage:(NSString*)message 
			userId:(NSString*)userId {
	NSMutableArray *userArr = [[NSMutableArray alloc] init];
	[userArr addObject:userId];

	
}



//群消息
+ (void)sendGroupMessage:(NSString*)message groupId:(NSString*)groupId {
	
}


//关闭socket网络
+ (void)closeSocket {
	
}


+ (void)dealloc {
	
}

@end
