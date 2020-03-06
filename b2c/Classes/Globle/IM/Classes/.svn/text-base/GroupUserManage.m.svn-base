//
//  GroupUserManage.m
//  IOSCim
//
//  Created by apple apple on 11-7-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GroupUserManage.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "GroupDataManage.h"
#import "GroupStruct.h"

@implementation GroupUserManage


//添加群成员
+ (void)addGroupUser:(UserData*)user groupId:(NSString*)groupId 
{
	GroupStruct *group = [GroupDataManage getGroup:groupId];
	[group addUser:user];
}
								  



//获取群成员
+ (NSMutableArray*)getGroupUsers:(NSString*)groupId 
{
	GroupStruct *group = [GroupDataManage getGroup:groupId];
	return [group getUsers]; 
}




//清除数据
+ (void)clearData 
{
	//needClear = YES;
}

@end
