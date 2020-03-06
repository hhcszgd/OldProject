//
//  OPChatLogData.m
//  IOSCim
//
//  Created by apple apple on 11-6-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "OPChatLogData.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "UserChatData.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "Base64.h"

@implementation OPChatLogData


//初始化配置
- (void)initParam
{
	createTableDictionary = [[NSMutableDictionary alloc] init];
	//创建聊天记录表
	[createTableDictionary setObject:@"create table if not exists ChatLog (loginerUserId text, chatWitherId text, sendObjectId text, messageContent text, sendTime text, messageType int)" forKey:@"ChatLog"];
	//创建访客表
	[createTableDictionary setObject:@"create table if not exists GuestUser (userId text, guestCode text, guestName text, lastAcessTime text, lastAcessPage text);" forKey:@"GuestUser"];
	//创建陌生人表
	[createTableDictionary setObject:@"create table if not exists Stranger (userId text);" forKey:@"Stranger"];
	
	dbPath = [NSString stringWithFormat:@"%@_UserDB.sqlite", _userLoginId];
	[self connectDB];
}



//创建数据库连接
- (id)init:(NSString*)userLoginId
{
	_userLoginId = userLoginId;
	guestDictionary = [[NSMutableDictionary alloc] init];
	strangerDictonary = [[NSMutableDictionary alloc] init];
	[self initParam];
	return self;
}



//添加聊天记录
- (void)addMessageLog:(NSString*)loginerUserId 
		 chatWitherId:(NSString*)chatWitherId 
		 sendObjectId:(NSString*)sendObjectId
	   messageContent:(NSString*)messageContent 
			 sendTime:(NSString*)sendTime 
		  messageType:(int)messageType
{
	[Base64 initialize];
	NSData *contentData= [[messageContent copy] dataUsingEncoding: NSUTF8StringEncoding];
	NSString *encodeContent = [Base64 encode:contentData];
	NSString *insertSql = [[NSString alloc] initWithFormat:@"insert into ChatLog (loginerUserId, chatWitherId, sendObjectId, messageContent, sendTime, messageType) VALUES ('%@','%@','%@','%@','%@',%d)", 
						   loginerUserId, chatWitherId, sendObjectId, encodeContent, sendTime, messageType];
	[self update:insertSql];
}



//获取聊天记录
- (NSMutableArray*)getMessageLog:(NSString*)loginerUserId 
					chatWitherId:(NSString*)chatWitherId 
					 messageType:(int)messageType 
{
	[Base64 initialize];
	NSMutableArray *chatLogArray = [[NSMutableArray alloc] init];
	NSString *sql = [[NSString alloc] initWithFormat:@"select * from ChatLog where loginerUserId='%@' and chatWitherId='%@' and messageType=%d", 
					 loginerUserId, chatWitherId, messageType];
	
	FMResultSet *rs = [self query:sql];
	
	while ([rs next]) {  
		NSString *sendObjectId = [rs stringForColumn:@"sendObjectId"];
		NSString *messageContent = [rs stringForColumn:@"messageContent"];
		NSString *sendTime = [rs stringForColumn:@"sendTime"];
		NSString *sendUserName = [[UserDataManage getUser:sendObjectId] getUserName];
		UserChatData *userChatData = [UserChatData alloc];
		userChatData.userName = sendUserName;
		
		NSData *messageData = [Base64 decode:messageContent];
		messageContent = [[NSString alloc] initWithData:messageData  encoding:NSUTF8StringEncoding];
		
		userChatData.content = messageContent;
		userChatData.sendTime = sendTime;
		userChatData.userId = sendObjectId;
		
		NSString *selfId = [UserDataManage getSelfUser].userId;
		
		if ([sendObjectId isEqualToString:selfId]) {
			userChatData.isSelf = YES;
		}
		
		[chatLogArray addObject:userChatData];  
	}  
	
	[rs close];
	return chatLogArray;	
}




//保存沟通过的访客
- (void)addGuestUser:(UserData*)user 
{
	if ([guestDictionary objectForKey:user.userId] != nil) 
	{
		return; //已经记录过  忽略掉
	}
	
	NSString *sql = @"insert into GuestUser (userId, guestCode, guestName, lastAcessTime, lastAcessPage) VALUES ('%@','%@','%@','%@','%@')";
	NSString *insertSql = [[NSString alloc] 
						   initWithFormat: sql, 
						   user.userId, user.guestCode, user.nickname, user.lastAcessTime, user.lastAcessPage];
	
	if (![self update:insertSql]) {
		NSLog(@"数据保存访客数据时 出错");
	} else {
		[guestDictionary setObject:user.userId forKey:user.userId];
	}
	
}




//获取访客记录
- (NSMutableArray*)getGuestsInfo 
{	
	NSMutableArray *guestUserArray = [[NSMutableArray alloc] init];
	NSString *sql = @"select * from GuestUser";
	FMResultSet *rs = [self query:sql];
	
	while ([rs next])
	{ 		
		UserData *user = [UserData alloc];
		user.userId = [rs stringForColumn:@"userId"];
		user.guestCode = [rs stringForColumn:@"guestCode"];
		user.nickname = [rs stringForColumn:@"guestName"];
        user.kindId = @"2";
		user.lastAcessPage = [rs stringForColumn:@"lastAcessPage"];
		[guestDictionary setObject:user.userId forKey:user.userId];
		[guestUserArray addObject:user];
	}  
	
	[rs close];
	return guestUserArray;	
}
- (void)deleteGeustById:(NSString *)userId {
    [self update:[NSString stringWithFormat:@"Delete From GuestUser Where userId = '%@'", userId]];
}



//保存陌生人的Id
- (void)addStranger:(UserData*)user 
{
	if ([strangerDictonary objectForKey:user.userId] != nil) 
	{
		return; //已经记录过  忽略掉
	}
	
	NSString *sql = @"insert into Stranger (userId) VALUES ('%@')";
	NSString *insertSql = [[NSString alloc] 
						   initWithFormat: sql, user.userId];
	
	if (![self update:insertSql]) 
	{
		NSLog(@"数据保存陌生人数据时 出错");
	} 
	else 
	{
		[strangerDictonary setObject:user.userId forKey:user.userId];
	}
	

}



- (void)removeStranger:(NSString*)userId 
{
	[strangerDictonary removeObjectForKey:userId];
	NSString *sql = [NSString stringWithFormat:@"delete from Stranger where userId = '%@'", userId];
	[self update:sql];
}  



//获取陌生人Id
- (NSMutableArray*)getStrangers
{	
	NSMutableArray *strangerIdArray = [[NSMutableArray alloc] init];
	NSString *sql = @"select * from Stranger";
	FMResultSet *rs = [self query:sql];
	
	while ([rs next])
	{
		NSString *userId = [rs stringForColumn:@"userId"];
		
		//过滤已经建立关系的陌生人
		if ([UserDataManage isExist:userId])
		{
			break;
		}
		
		[strangerIdArray addObject:[rs stringForColumn:@"userId"]];
		[strangerDictonary setObject:userId forKey:userId];
	}  
	
	[rs close];
	return strangerIdArray;
}



//删除聊天记录
- (void)deleteMessageLog:(NSString*)loginerUserId chatWitherId:(NSString*)chatWitherId 
{
	NSString *deleteSql = [[NSString alloc] initWithFormat:@"delete from ChatLog where loginerUserId = '%@' and chatWitherId = '%@' ", 
						   loginerUserId, chatWitherId];
	[self update:deleteSql];
}



//关闭数据库连接
- (void)close 
{
	
}

@end
