//
//  UserListKindDataStruct.h
//  IOSCim
//
//  Created by apple apple on 11-8-5.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  用户列表分组的数据结构
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface UserListKindDataStruct : NSObject 
{
	//ID标识
	NSString *dataId;
	//父级ID
	NSString *parentId;
	//分组名称
	NSString *kindName;
	NSMutableArray *userIdArray;
}


@property (nonatomic, retain) NSString *dataId;
@property (nonatomic, retain) NSString *parentId;
@property (nonatomic, retain) NSString *kindName;


//获取分组名称
- (NSString*)getKindName;
//给分组中添加成员
- (void)addUser:(UserData*)user;
//从分组中删除成员
- (void)removeUser:(NSString*)userId;
//获取分组中的成员
- (NSArray*)getUsers;
//获取分组中上线的成员数量
- (int)getOnlineUserCount;
//获取分组中总的成员数量
- (int)getTotalUserCount;

@end
