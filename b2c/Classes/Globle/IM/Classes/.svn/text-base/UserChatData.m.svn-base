//
//  UserChatData.m
//  IOSCim
//
//  Created by apple apple on 11-6-1.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "UserChatData.h"
#import "Config.h"
#import "UserDataManage.h"
#import "UserData.h"

@implementation UserChatData
@synthesize userId, userName, sendTime, content, groupId, isSelf, isSystemMessage, imageIdArray;

+ (NSString*)getNow 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	[dateFormatter setDateFormat:@"HH:mm:ss"];
	return [dateFormatter stringFromDate:[NSDate date]];
}



- (NSString*)getContent 
{
	return content;
}



- (NSString*)getUserName 
{
	if (isSystemMessage) 
	{
		return @"系统消息";
	}
	
	if ([UserDataManage isExist:userId]) 
	{
		return [[UserDataManage getUser:userId] getUserName];
	}
	
	return userId;
}

@end
