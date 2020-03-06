//
//  ShopDeptStruct.m
//  IOSCim
//
//  Created by apple apple on 11-5-25.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ShopDeptStruct.h"
#import "UserData.h"
#import "UserDataManage.h"

@implementation ShopDeptStruct
@synthesize deptId, parentId, deptName, isHidden;


- (NSString *)getDeptName {
	if ([deptName isEqualToString:@""]) {
		return @"默认分组";
	} else {
		return deptName;
	}
}


- (void)addUser:(UserData*)user {
	if (userIdArray == nil) {
		userIdArray = [[NSMutableArray alloc] init];
	}
	
	[userIdArray addObject:user.userId];
}


//状态排序
NSComparisonResult sortByDate(UserData *firstUser, UserData *secondUser, void *context) {
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
- (NSArray*)getUsers {
	NSMutableArray *users = [[NSMutableArray alloc] init];
	
	for (NSString *userId in userIdArray) {
		[users addObject:[UserDataManage getUser:userId]];
	}
	
	//状态排序
	[users sortUsingFunction:sortByDate context:NULL];
	
	if ([users count] > 0) {
		return users;
	} 
	
	return nil;
}


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


- (int)getTotalUserCount {
	return [userIdArray count];
}

@end
