//
//  SendSocketContent.m
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//
#import "SendSocketContent.h"
#import "Base64.h"
#import "UserData.h"
#import "UserDataManage.h"


@implementation SendSocketContent


+ (NSString *)getLoginXML:(int)priority userStatus:(int)userStatus 
{
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	NSString *loginXML = @"<cim client=\"cs\" type=\"login\" priority=\"%d\"><user sessionId=\"%@\" status=\"%d\"/></cim>";
	loginXML = [NSString stringWithFormat:loginXML, priority, sessionId, userStatus];
	return loginXML;
}



//获取用户在线状态
+ (NSString *)getQueryUserStatusXML:(NSMutableArray*)usersId 
{
	UserData *selfUser = [UserDataManage getSelfUser]; 
	NSString *queryStatusXML = @"<cim client=\"cs\" type=\"queryStatus\"><userList>%@</userList></cim>";
	NSString *userList = @"";
	
	for (NSString *userId in usersId) 
	{
		if ([selfUser.userId isEqualToString:userId]) 
		{
			continue;
		}
		
		userList = [userList stringByAppendingFormat:@"<user id=\"%@\"/>", userId]; 
	}
	
	queryStatusXML = [NSString stringWithFormat:queryStatusXML, userList];
	//NSLog(@"%@", queryStatusXML);
	return queryStatusXML;
}



//设置自己的状态
+ (NSString *)setMyStatus:(int)status 
{
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	NSString *setStatusXML = @"<cim client=\"cs\" type=\"setStatus\"><user sessionId=\"%@\" status=\"%d\"/></cim>";
	setStatusXML = [NSString stringWithFormat:setStatusXML, sessionId, status];
	return setStatusXML;
}



//发送检测包
+ (NSString *)getSendCheckPackageXML 
{
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	NSString *checkXML = @"<cim client=\"cs\" type=\"check\"><user sessionId=\"%@\" status=\"%d\"/></cim>";
	checkXML = [NSString stringWithFormat:checkXML, sessionId, 10];
	
	//checkXML = @"<cim client=\"cs\" type=\"sendMessage\"><userList><user id=\"1084\"/></userList><message type=\"1\" groupId=\"0\" remark=\"0\" userStauts=\"10\">MTIzMTMz</message></cim>";
	return checkXML;
}




//发送消息
+ (NSString *)getSendMessageXML:(NSString*)message usersId:(NSMutableArray*)usersId messageType:(int)messageType groupId:(NSString*)groupId 
{
	NSString *messageXML = @"<cim client=\"cs\" type=\"sendMessage\"><userList>%@</userList><message type=\"%d\" groupId=\"%@\" remark=\"0\" userStauts=\"10\">%@</message></cim>";
	NSString *userList = @"";
	
	for (NSString *userId in usersId) 
	{
		userList = [userList stringByAppendingFormat:@"<user id=\"%@\"/>", userId];
	}
	
	[Base64 initialize];
	NSData *messageData= [message dataUsingEncoding: NSUTF8StringEncoding];
//	messageXML = [NSString stringWithFormat:messageXML, userList, messageType, groupId, [Base64 encode:messageData]];

    messageXML = [NSString stringWithFormat:messageXML, userList, messageType,groupId, [Base64 encode:messageData]];
//NSLog(@"发送消息为:%@", messageXML);
	return messageXML;
}
//发送消息
+ (NSString *)getSendMessageXML:(NSString*)message usersId:(NSMutableArray*)usersId messageType:(int)messageType groupId:(NSString*)groupId remark:(NSString *)remark
{
    NSString *messageXML = @"<cim client=\"cs\" type=\"sendMessage\"><userList>%@</userList><message type=\"%d\" groupId=\"%@\" remark=\"%@\" userStauts=\"10\">%@</message></cim>";
    NSString *userList = @"";
    
    for (NSString *userId in usersId)
    {
        userList = [userList stringByAppendingFormat:@"<user id=\"%@\"/>", userId];
    }
    
    [Base64 initialize];
    NSData *messageData= [message dataUsingEncoding: NSUTF8StringEncoding];
    NSData *remarkData = [remark dataUsingEncoding:NSUTF8StringEncoding];
    messageXML = [NSString stringWithFormat:messageXML, userList, messageType, groupId, [Base64 encode:remarkData], [Base64 encode:messageData]];
    //NSLog(@"发送消息为:%@", messageXML);
    return messageXML;
}



//发送群消息
+ (NSString *)getGroupMessageXML:(NSString*)message groupId:(int)groupId messageType:(NSString*)messageType 
{
	NSString *messageXML = @"<cim client=\"cs\" type=\"sendMessage\"><message type=\"%@\" groupId=\"%@\" userStauts=\"10\">%@</message></cim>";
	[Base64 initialize];
	NSData *messageData= [message dataUsingEncoding: NSUTF8StringEncoding];
	messageXML = [NSString stringWithFormat:messageXML, messageType, groupId, [Base64 encode:messageData]];
	return messageXML;
}


@end
