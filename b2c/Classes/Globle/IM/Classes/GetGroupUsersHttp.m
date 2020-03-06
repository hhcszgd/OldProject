//
//  GetGroupUsers.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GetGroupUsersHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"
#import "GroupStruct.h"
#import "GroupUserManage.h"
#import "GroupDataManage.h"
#import "UserData.h"
#import "MyNotificationCenter.h"
#import "SystemConfig.h"

@implementation GetGroupUsersHttp
@synthesize delegate;


- (void)init:(NSString*)groupIdc
{
	//url参数
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&groupId=%@", @"getGroupUser", groupIdc];
	httpType = @"getGroupUser";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	
	if ([xmlParam.elementName isEqualToString:@"group"]) 
	{
		NSLog(@"%@", @"获取群成员信息成功");
		GroupStruct *group = [GroupStruct alloc];
		group.groupId = [xmlParam.attributeDict objectForKey:@"id"];
		group.groupName = [xmlParam.attributeDict objectForKey:@"name"];
		group.notes = [xmlParam.attributeDict objectForKey:@"notes"];
		//将硬盘中的设置信息读取的内存中
		group.isRecvMessage = [SystemConfig isRecvGroupMessage:group.groupId];
		[GroupDataManage addGroup:group];
	}	
	
	
	if ([xmlParam.elementName isEqualToString:@"group"]) 
	{
		groupId = [xmlParam.attributeDict objectForKey:@"id"];
	}
	
	
	if ([xmlParam.elementName isEqualToString:@"user"]) 
	{
		UserData *user = [UserData alloc];
		user.userId = [xmlParam.attributeDict objectForKey:@"id"];
		user.loginId = [xmlParam.attributeDict objectForKey:@"loginId"];
		user.nickname = [xmlParam.attributeDict objectForKey:@"nickname"];
		user.idiograph = [xmlParam.attributeDict objectForKey:@"idiograph"];
        user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
        [[GroupDataManage getGroup:groupId] addUser:user];
	}
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	[MyNotificationCenter postNotification:HttpGroupUserDataComplete setParam:groupId];
}



- (void)errorFunction:(ErrorParam*)error 
{
	//[delegate performSelector:@selector(errorAddFriend:) withObject:error];
}


@end
