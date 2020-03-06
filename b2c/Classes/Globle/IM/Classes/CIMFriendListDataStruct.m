//
//  CIMFriendListDataStruct.m
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMFriendListDataStruct.h"
#import "UserData.h"


@implementation CIMFriendListDataStruct


- (id)init {
	//设置用户列表的类型 shop / friend / guest
	userListType = @"friend";
	return self;
}



//添加陌生人
- (void)addStranger:(UserData*)user {
	user.kindId = @"stranger";
	[user setUserType:@"stranger"];
	[self addListUser:user];
}
- (void)removeUserByUserId:(NSString *)userId {
    [super removeUserById:userId];
}

@end
