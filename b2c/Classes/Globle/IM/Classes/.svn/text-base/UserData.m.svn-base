//
//  UserData.m
//  IOSCim
//
//  Created by apple apple on 11-5-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  用户数据结构 综合了  企业用户、好友和访客的所有属性  以userId 作为键值区分
//

#import "UserData.h"
#import "UserChatData.h"
#import "CimGlobal.h"
#import "OPChatLogData.h"
#import "RegexKitLite.h"
#import "UserDataManage.h"
#import "Config.h"

@implementation UserData
@synthesize userId, loginId, nickname, idiograph, deptId, kindId, userInfo, oldStatus, 
isUnReadMessage, unReadAmount, friendVerifyType, guestCode, lastAcessTime, lastAcessPage, userType, groupUserType,faceIndex;



//添加消息记录
- (void)addMessage:(UserChatData*)chatData 
{
	if (userChatLog == nil)
	{
		userChatLog = [[NSMutableArray alloc] init];
	}
	
	
	if (![chatData.content isEqualToString:@""]) 
	{
		[userChatLog addObject:chatData];
	}
}




//添加图片消息
- (void)addImageMessage:(NSString*)imageId downloadId:(NSString*)downloadId messageType:(int)messageType
{
	NSString *regexString = [NSString stringWithFormat:@"<img.*name=.*%@.*[^<]*>", imageId];
	NSString *realImageString = [NSString stringWithFormat:@"<img src=\"%@\" onclick=\"callShowImage(this.src);\" />", downloadId, downloadId];
	UserChatData *userChatData;
	
	for (int i=0; i<[userChatLog count]; i++)
	{
		userChatData = [userChatLog objectAtIndex:i];
		NSArray *resultArray = [userChatData.content componentsMatchedByRegex:regexString];
		
		if ([resultArray count] > 0)
		{
			userChatData.content = [userChatData.content stringByReplacingOccurrencesOfRegex:regexString  withString:realImageString];
			//接收完图片后再保存聊天信息
			OPChatLogData *opChatlogData = [CimGlobal getClass:@"OPChatLogData"];
			//保存聊天记录
			[opChatlogData addMessageLog:[[UserDataManage getSelfUser] userId] 
							chatWitherId:userChatData.userId
							sendObjectId:userChatData.userId
						  messageContent:userChatData.content
								sendTime:userChatData.sendTime
							 messageType:messageType];
			
		}
	}
}




//获取聊天消息
- (NSMutableArray*)getMessage 
{
	return userChatLog;
}




//清除消息记录
- (void)clearMessage
{
	if (userChatLog != nil)
	{
		[userChatLog removeAllObjects];
	}
}




//添加未读消息的数量
- (void)addUnReadAmount 
{
	unReadAmount++;
}




//获取未读消息的数量
- (NSInteger)getUnReadAmount 
{
	return unReadAmount;
}



//获取用户名称
- (NSString*)getUserName
{
	if ([nickname isEqualToString:@""]) 
	{
		return loginId;
	} 
	
	return nickname;
}



//获取登录帐号
- (NSString*)getLoginId
{
	return loginId;
}



//获取状态
- (int)getStatus
{
	if (status == 0 || status == UserStatusStealth) 
	{
		status = UserStatusOffline;
	}
	
	return status;
}



//状态是否发生改变
- (BOOL)isChangeStatus 
{
	if (oldStatus == status) {
		return NO;
	}
	
	return YES;
}




//设置自己的状态
- (void)setStatus:(NSString*)userStatus 
{
	int intStatus = [userStatus intValue];
	oldStatus = status;
	status = intStatus;
}




//设置用户类型
- (void)setUserType:(NSString*)type
{
	userType = type;
	OPChatLogData *opChatLogData = [CimGlobal getClass:@"OPChatLogData"];
	
		//保存沟通过的访客
	if ([type isEqualToString:@"guest"])
	{
		[opChatLogData addGuestUser:self];
		//保存陌生人
	} 
	else if ([type isEqualToString:@"stranger"])
	{
		[opChatLogData addStranger:self];
	}
}




//获取用户头像
- (NSString *)getHeadImage {
    if (!faceIndex || [faceIndex length] == 0 || faceIndex.longLongValue == 0) {
        NSString *userHeadImgage;
        if ([self getStatus] == UserStatusOffline) {
            userHeadImgage = @"OfflineHead1.png";
        } else {
            userHeadImgage = @"DefaultHead.png";
        }
        return userHeadImgage;
    } else {
        NSString *imageURL = [Config getUserHeadImagePath:faceIndex];
        return imageURL;
    }
}


@end
