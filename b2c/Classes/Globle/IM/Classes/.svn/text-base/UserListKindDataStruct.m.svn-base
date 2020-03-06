//
//  UserListKindDataStruct.m
//  IOSCim
//
//  Created by apple apple on 11-8-5.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  分组的数据结构 包括企业部门和好友分组
//

#import "UserListKindDataStruct.h"
#import "UserDataManage.h"

@implementation UserListKindDataStruct

@synthesize dataId, parentId, kindName;

//获取分组名称
- (NSString *)getKindName {
	if ([kindName isEqualToString:@""]) {
		return @"默认分组";
	} else {
		return kindName;
	}
}


//给分组中添加成员
- (void)addUser:(UserData*)user {
	if (userIdArray == nil) {
		userIdArray = [[NSMutableArray alloc] init];
	}
	
	[userIdArray addObject:user.userId];
}



//从分组中删除成员
- (void)removeUser:(NSString*)userId {
	[userIdArray removeObject:userId];
	[UserDataManage removeUser:userId];
}



//批量添加人员
- (void)batchAddListUser:(NSMutableArray*)users {
	for (UserData *user in users) {
		[self addUser:user];
	}
}


//状态排序算法
NSComparisonResult sortByUserStatus(UserData *firstUser, UserData *secondUser, void *context) {
	int firstStatus = [firstUser getStatus]; 
	int secondStatus = [secondUser getStatus];
	
	if (firstStatus < secondStatus)
		return NSOrderedAscending;
	else if (firstStatus > secondStatus)
		return NSOrderedDescending;
	else
		return NSOrderedSame;
}


//获取分组中的成员
- (NSArray*)getUsers {
	NSMutableArray *users = [[NSMutableArray alloc] init];
	
	for (NSString *userId in userIdArray) {
        UserData* userData = [UserDataManage getUser:userId];
        if (userData != nil) {
            [users addObject:userData];
        }
	}
	
	//状态排序
	[users sortUsingFunction:sortByUserStatus context:NULL];
	
	if ([users count] > 0) {
		return users;
	} 
	
	return nil;
}



//获取分组中上线的成员数量
- (int)getOnlineUserCount {
	int onlineCount = 0;
	
	//统计上线人数
	for (NSString *userId in userIdArray) {
		UserData *user = [UserDataManage getUser:userId];
		
		if ([user getStatus] != UserStatusOffline) {
			onlineCount++;
		}
	}	
	
	return onlineCount;
}



//获取分组中总的成员数量
- (int)getTotalUserCount {
	return [userIdArray count];
}


@end
