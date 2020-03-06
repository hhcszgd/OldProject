//
//  GroupStruct.m
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GroupStruct.h"
#import "UserChatData.h"
#import "UserData.h"
#import "UserDataManage.h"
#import "Debuger.h"
#import "CimGlobal.h"
#import "UserDataManage.h"
#import "OPChatLogData.h"
#import "RegexKitLite.h"


@implementation GroupStruct
@synthesize groupId, groupName, notes, isRecvMessage, groupMaster, myTypeInGroup;


- (void)addMessage:(UserChatData*)chatData 
{
	if (groupChatLog == nil)
	{
		groupChatLog = [[NSMutableArray alloc] init];
	}
	
	[groupChatLog addObject:chatData];
}



//添加图片消息
- (void)addImageMessage:(NSString*)imageId downloadId:(NSString*)downloadId messageType:(int)messageType
{
	NSString *regexString = [NSString stringWithFormat:@"<img.*name=.*%@.*[^<]*>", imageId];
	NSString *realImageString = [NSString stringWithFormat:@"<img src=\"%@\" onclick=\"callShowImage(this.src);\" />", downloadId];
	UserChatData *userChatData = nil;
	
	for (int i=0; i<[groupChatLog count]; i++)
	{
		userChatData = [groupChatLog objectAtIndex:i];
		NSArray *resultArray = [userChatData.content componentsMatchedByRegex:regexString];
		
		if ([resultArray count] > 0)
		{
			userChatData.content = [userChatData.content stringByReplacingOccurrencesOfRegex:regexString  withString:realImageString];
			//接收完图片后再保存聊天信息
			OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
			[opChatlogData addMessageLog:[[UserDataManage getSelfUser] userId] 
							chatWitherId:userChatData.groupId
							sendObjectId:userChatData.userId
						  messageContent:userChatData.content
								sendTime:userChatData.sendTime
							 messageType:messageType];
		}
	}
}



- (void)clearMessage 
{
	if (groupChatLog != nil) 
	{
		[groupChatLog removeAllObjects];
	}
}



- (NSMutableArray*)getMessage 
{
	return groupChatLog;
}



- (void)addUser:(UserData*)user 
{
	if (userIdArray == nil) 
	{
		userIdArray = [[NSMutableArray alloc] init];
	}
	
	[userIdArray addObject:user.userId];
	[UserDataManage addUser:user];
}



//状态排序
NSComparisonResult sortByGroupUserStatus(UserData *firstUser, UserData *secondUser, void *context) 
{
	int firstStatus = [firstUser getStatus]; 
	int secondStatus = [secondUser getStatus];
	
	if (firstStatus < secondStatus)
		return NSOrderedAscending;
	else if (firstStatus > secondStatus)
		return NSOrderedDescending;
	else
		return NSOrderedSame;
}



//获取部门成员
- (NSArray*)getUsers
{
	NSMutableArray *users = [[NSMutableArray alloc] init];
	
	for (NSString *userId in userIdArray) 
	{
		[users addObject:[UserDataManage getUser:userId]];
	}
	
	//状态排序
	[users sortUsingFunction:sortByGroupUserStatus context:NULL];
	return users;
}




- (void)clearUsers {
	[userIdArray removeAllObjects];
}




- (NSArray*)getUsersId {
	return userIdArray;
}

@end
