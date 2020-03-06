//
//  UserDataManage.m
//  IOSCim
//
//  Created by apple apple on 11-5-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "UserDataManage.h"
#import "UserData.h"

@implementation UserDataManage

static NSMutableDictionary *users;
static NSString *selfUserId;
static BOOL needClear;

//标识自己的用户id
+ (void)setSelfUserId:(NSString*)userId 
{
	selfUserId = userId;
}



+ (UserData*)getSelfUser 
{
	return [users objectForKey:selfUserId];
}



+ (void)addUser:(UserData*)data 
{
	if (users == nil) 
	{
		users = [[NSMutableDictionary alloc] init];
	} 
	else if (needClear) 
	{
		[users removeAllObjects];
		needClear = NO;
	}

	
	UserData *user = [users objectForKey:data.userId];
	
	if (user == nil) 
	{
		[users setObject:data forKey:data.userId];
	} 
	else if (data.kindId != nil) 
	{
		user.kindId = data.kindId;
	}
}


+ (void)removeUser:(NSString*)userId 
{
	[users removeObjectForKey:userId];
}



+ (UserData*)getUser:(NSString*)userId 
{
	return [users objectForKey:userId];
}



//清除数据
+ (void)clearData 
{
	needClear = YES;
}



+ (BOOL)isExist:(NSString*)userId 
{
	if ([users objectForKey:userId] == nil) 
	{
		return NO;
	}
	
	return YES;
}


@end
