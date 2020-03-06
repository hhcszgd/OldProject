//
//  CIMUserListDataStruct.h
//  IOSCim
//
//  Created by apple apple on 11-8-15.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"
#import "UserListKindDataStruct.h"

@interface CIMUserListDataStruct : NSObject {
	NSMutableDictionary *listUsersId; //用户ID的集合
	NSMutableDictionary *listKinds; //用户分组
	NSString *userListType; //列表类型
	BOOL needClear;
}


//设置用户列表的类型 shop / friend / guest
- (void)setUserListType:(NSString*)listType;
//给列表中添加用户
- (void)addListUser:(UserData*)user;
//添加列表分组
- (void)addListKind:(UserListKindDataStruct*)kind;
//获取单个列表分组
- (UserListKindDataStruct*)getListKind:(NSString*)dataId;
//获取所有的列表分组
- (NSMutableArray*)getListKinds;
//获取列表所有的用户数据
- (NSMutableArray*)getListUsers;
//获取所有的用户ID
- (NSMutableArray*)getListUsersId;
//是否时该列表中的用户
- (BOOL)isMyUser:(NSString*)userId;
//清除数据
- (void)clearData;
- (void)batchAddListUser:(NSMutableArray*)users;
//删除单个用户
- (void)removeUserById:(NSString *)userId;

//+ (NSMutableArray*)getCurrentlyChatWithers;

- (void)addListUser:(UserData*)user ;
@end
