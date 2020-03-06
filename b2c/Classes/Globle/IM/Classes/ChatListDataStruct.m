//
//  ChatListDataStruct.m
//  IOSCim
//
//  Created by apple apple on 11-8-5.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ChatListDataStruct.h"
#import "UserData.h"
#import "ChatUserStruct.h"


@implementation ChatListDataStruct

static ChatUserStruct *currentChatUserId;
//当前会话的用户ID数组
static NSMutableArray *chatUsersId;
//当前正在聊天的用户列表
static NSMutableDictionary *currentlyChatWither;
static BOOL needClear;


//设置当前的会话用户
+ (void)setCurrentChatUserId:(ChatUserStruct*)chatUser 
{
	currentChatUserId = chatUser;
}




//获取当前会话用户
+ (ChatUserStruct*)getCurrentChatUserId 
{
	return currentChatUserId;
}




//获取总共的未读消息
+ (int)getTotalUnReadAmount 
{
	int totalUnReadAmount = 0;
	
	for (ChatUserStruct *user in [currentlyChatWither allValues]) 
	{
		totalUnReadAmount += [user getUnReadAmount];
	}
	
	return totalUnReadAmount;
}




//添加会话用户
+ (void)addChatUser:(ChatUserStruct*)chatObject 
{
	if (currentlyChatWither == nil) 
	{
		currentlyChatWither = [[NSMutableDictionary alloc] init];
	} else if (needClear) 
	{
		[chatUsersId removeAllObjects];
		[currentlyChatWither removeAllObjects];
		needClear = NO;
	}
	
	//键值等于 id加类型
	NSString *key = [[NSString alloc] initWithFormat : @"%@_%@", chatObject.dataId, chatObject.chatType];
	ChatUserStruct *userObject = [currentlyChatWither objectForKey:key];
	
	
	if (userObject == nil) 
	{
		[chatObject addUnReadAmount];
		[currentlyChatWither setObject:chatObject forKey:key];
	} 
	else 
	{
		[userObject addUnReadAmount];
	}
}




//不添加人不提示消息
+ (void)addChatNormalUser:(ChatUserStruct*)chatObject 
{
	if (currentlyChatWither == nil) 
	{
		currentlyChatWither = [[NSMutableDictionary alloc] init];
	}
	
	//键值等于 id加类型
	NSString *key = [[NSString alloc] initWithFormat : @"%@_%@", chatObject.dataId, chatObject.chatType];
	ChatUserStruct *userObject = [currentlyChatWither objectForKey:key];
	
	
	if (userObject == nil) 
	{
		[currentlyChatWither setObject:chatObject forKey:key];
	}
}




//清除未读提示
+ (void)clearTipsNumbers:(ChatUserStruct*)chatObject 
{
	//键值等于 id加类型
	NSString *key = [[NSString alloc] initWithFormat:@"%@_%@", chatObject.dataId, chatObject.chatType];
	ChatUserStruct *userObject = [currentlyChatWither objectForKey:key];
	
	if (userObject != nil) 
	{
		//记录未读消息条数
		[userObject clearUnReadAmount];
	}
}




//删除会话用户
+ (void)removeChatUser:(ChatUserStruct*)chatObject 
{
	//键值等于 id加类型
	NSString *key = [[NSString alloc] initWithFormat:@"%@_%@", chatObject.dataId, chatObject.chatType];
	[currentlyChatWither removeObjectForKey:key];
	
	if ([[currentlyChatWither allKeys] count] == 0) 
	{
		currentChatUserId = nil;
	}
}




//删除所有当前聊天的用户
+ (void)removeAllChatUsers 
{
	[currentlyChatWither removeAllObjects];
}




//获取当前正在聊天的所有联系人信息
+ (NSMutableArray*)getCurrentlyChatWithers 
{
	return [[NSMutableArray alloc] initWithArray:[currentlyChatWither allValues]];
}




+ (void)clearData 
{
	needClear = YES;
}


@end
