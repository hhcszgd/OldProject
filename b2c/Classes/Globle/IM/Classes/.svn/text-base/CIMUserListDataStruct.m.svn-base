//
//  CIMUserListDataStruct.m
//  IOSCim
//
//  Created by apple apple on 11-8-15.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  用户列表的原型 其他列表的继承至该类
//

#import "CIMUserListDataStruct.h"
#import "UserDataManage.h"
#import "UserListKindDataStruct.h"

@implementation CIMUserListDataStruct


- (id)init 
{
	//设置用户列表的类型 shop / friend / guest
	userListType = @"shop";
	return self;
}

//设置用户列表的类型 shop / friend / guest
- (void)setUserListType:(NSString*)listType {
    
}

//给列表中添加用户
- (void)addListUser:(UserData*)user 
{
	//将用户添加中全局用户数据中
	[UserDataManage addUser:user];
	
	if (listUsersId == nil) 
	{
		listUsersId = [[NSMutableDictionary alloc] init];
	} 
	else if (needClear)  //清除上次的登录数据
	{
		[listUsersId removeAllObjects];
		[listKinds removeAllObjects];
		needClear = NO;
	}

	
	[listUsersId setObject:user.userId forKey:user.userId];
	UserListKindDataStruct *kind;
	
	if ([userListType isEqualToString:@"shop"]) 
	{
		kind = [listKinds objectForKey:user.deptId];
	} 
	else if ([userListType isEqualToString:@"friend"]) 
	{
		kind = [listKinds objectForKey:user.kindId];
	} 
	else if ([userListType isEqualToString:@"guest"]) 
	{
		kind = [listKinds objectForKey:@"2"];
	}
	
	//加用户关联中分组中
	if (kind != nil) 
	{
		[kind addUser:user];
	}
}




//批量添加用户
- (void)batchAddListUser:(NSMutableArray*)users 
{
	for (UserData *user in users) 
	{
		[self addListUser:user];
	}
}



//添加列表分组
- (void)addListKind:(UserListKindDataStruct*)kind 
{
	if (listKinds == nil) 
	{
		listKinds = [[NSMutableDictionary alloc] init];
	}
	
	[listKinds setObject:kind forKey:kind.dataId];
}



//获取单个列表分组
- (UserListKindDataStruct*)getListKind:(NSString*)dataId 
{
	return [listKinds objectForKey:dataId];
}



//获取所有的列表分组
- (NSMutableArray*)getListKinds 
{
	return [[listKinds allValues] mutableCopy];
}



//获取列表所有的用户数据
- (NSMutableArray*)getListUsers 
{
	NSMutableArray *users = [[NSMutableArray alloc] init];
	
	for (NSString *userId in [listUsersId allValues]) 
	{
		UserData *user = [UserDataManage getUser:userId];
		[users addObject:user];
	}
	
	return users;
}



//获取所有的用户ID
- (NSMutableArray*)getListUsersId 
{
	return [[listUsersId allValues] mutableCopy];
}
//删除单个用户
- (void)removeUserById:(NSString *)userId {
    if (userId && [listUsersId objectForKey:userId]) {
        [listUsersId removeObjectForKey:userId];
    }
}

//是否时该列表中的用户
- (BOOL)isMyUser:(NSString*)userId 
{
	NSString *user = [listUsersId objectForKey:userId];
	UserData *userData = [UserDataManage getUser:userId];
	if (user == nil)
	{
		return NO;
	} 
    if (userData && [[userData userType] isEqualToString:@"stranger"]) {
        return NO;
    }
	return YES;
}



//清除数据
- (void)clearData 
{
	needClear = YES;
}




@end
