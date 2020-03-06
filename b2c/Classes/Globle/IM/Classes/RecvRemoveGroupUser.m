//
//  RecvRemoveGroupUser.m
//  IOSCim
//
//  Created by apple apple on 11-8-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "RecvRemoveGroupUser.h"
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
#import "MyNotificationCenter.h"
#import "RecvSocketMessage.h"
#import "GroupStruct.h"

@implementation RecvRemoveGroupUser

@synthesize removeUserId, groupId, message;




//得到用户信息后做提示
- (void)recvGetUserData:(UserData*)user 
{
	//GroupStruct *group = [GroupDataManage getSystemGourpData:groupId];
    UserData *userDataOne = [UserDataManage getUser:message.userId];
	NSString *groupMasterName = [userDataOne getUserName];
	NSString *content = [[NSString alloc]
						 initWithFormat:@"管理员 %@ 将用户 %@ 移除该群", groupMasterName, [user getUserName]];
	
	[RecvSocketMessage recvSystemGroupMessage:@"removeOtherFromGroup" 
									  groupId:groupId
									  message:message 
									  content:content];
	
}



- (void)errorGetUserData:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
}


@end
