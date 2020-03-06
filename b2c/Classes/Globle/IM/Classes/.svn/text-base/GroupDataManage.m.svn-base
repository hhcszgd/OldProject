//
//  GroupDataManage.m
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GroupDataManage.h"
#import "GroupStruct.h"

@implementation GroupDataManage

static NSMutableDictionary *groupsMap;
static NSMutableDictionary *systemGroupData;
static BOOL needClear;



+ (void)addGroup:(GroupStruct*)group 
{
	if (groupsMap == nil) 
	{
		groupsMap = [[NSMutableDictionary alloc] init];
	} 
	else if (needClear) 
	{
		[groupsMap removeAllObjects];
		[systemGroupData removeAllObjects];
		needClear = NO;
	}
	
	if ([groupsMap objectForKey:group.groupId] == nil) 
	{
		[groupsMap setObject:group forKey:group.groupId];
		[self saveSystemGroupData:group];
	}
}




+ (void)removeGroup:(NSString*)groupId 
{
	[groupsMap removeObjectForKey:groupId];
}




+ (void)saveSystemGroupData:(GroupStruct*)group 
{
	if (systemGroupData == nil) 
	{
		systemGroupData = [[NSMutableDictionary alloc] init];
	}
	
	[systemGroupData setObject:group forKey:group.groupId];
}




+ (GroupStruct *)getSystemGourpData:(NSString*)groupId
{
	 return [systemGroupData objectForKey:groupId];
}




+ (NSMutableArray*)getMyGroups 
{
	return [groupsMap allValues];
}




+ (BOOL)isMyGroup:(NSString*)groupId 
{
	if ([groupsMap objectForKey:groupId] == nil) 
	{
		return NO;
	} 
	else 
	{
		return YES;
	}
}




+ (GroupStruct*)getGroup:(NSString*)groupId 
{
	return [groupsMap objectForKey:groupId];
}


+ (void)clearGroupData {
    [groupsMap removeAllObjects];
    [systemGroupData removeAllObjects];
    needClear = NO;
}
//清除数据
+ (void)clearData 
{	
	needClear = YES;
}


@end
