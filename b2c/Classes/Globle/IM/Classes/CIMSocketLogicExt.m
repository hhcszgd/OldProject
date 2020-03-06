//
//  CIMSocketLogicExt.m
//  IOSCim
//
//  Created by apple apple on 11-8-19.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMSocketLogicExt.h"
#import "GroupDataManage.h"
#import "GroupStruct.h"
#import "UserDataManage.h"


@implementation CIMSocketLogicExt


//申请加入群
- (void)sendAddGroupRequest:(NSString*)groupId groupMasterId:(NSString*)groupMasterId 
{
	[self sendMessageToUser:@"@" userId:groupMasterId messageType:3 groupId:groupId];
}



//拒绝别人加入我的群
- (void)sendRefuseAddGroupMessage:(NSString*)groupId userId:(NSString*)userId 
{
	[self sendMessageToUser:@"-" userId:userId messageType:5 groupId:groupId];
}



//同意别人加入我的群
- (void)sendAgreeAddGroupMessage:(NSString*)groupId userId:(NSString*)userId 
{	
	[self sendMessageToUser:@"-" userId:userId messageType:4 groupId:groupId];
}



//退出群
- (void)leaveGroupMessage:(NSString*)groupId 
{
	GroupStruct *group = [GroupDataManage getGroup:groupId];
	NSString *context = [[NSString alloc] initWithFormat:@"%@,0", [UserDataManage getSelfUser].userId];
	[self sendMessageToUsers:context usersId:[[NSMutableArray alloc] initWithArray:[group getUsersId]] messageType:2012 groupId:groupId];
}



//解散群
- (void)dissolveGroupMessage:(NSString*)groupId 
{
	GroupStruct *group = [GroupDataManage getGroup:groupId];
	NSString *context = [[NSString alloc] initWithFormat:@"%@,%@", groupId, group.groupName];	
	[self sendMessageToUsers:context usersId:[[NSMutableArray alloc] initWithArray:[group getUsersId]] messageType:2013 groupId:groupId];
}



////////////////////////////////////////////////////////



//发送请求别人添加我为好友
- (void)sendRequestAddFriendMessage:(NSString*)friendId 
					 requestContent:(NSString*)requestContent 
{
	if ([requestContent isEqualToString:@""]) 
	{
		requestContent = @"@";
	}
	
	[self sendMessageToUser:requestContent userId:friendId messageType:3 groupId:@"0"];
}



//发送同意添加为好友消息
- (void)sendAgreeAddFriendMessage:(NSString*)friendId 
{	
	[self sendMessageToUser:@"-" userId:friendId messageType:4 groupId:@"0"];
}




//发送拒绝添加为好友消息
- (void)sendRefuseAddFriendMessage:(NSString*)friendId 
{
	[self sendMessageToUser:@"-" userId:friendId messageType:5 groupId:@"0"];
}



@end
