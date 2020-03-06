//
//  GroupHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GroupHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"
#import "GroupStruct.h"
#import "GroupDataManage.h"
#import "SystemConfig.h"
#import "CIMSocketLogicExt.h"
#import "CimGlobal.h"
#import "GetGroupUsersHttp.h"


@implementation GroupHttp
@synthesize delegate;

- (instancetype)init
{
	//url参数
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@", @"getSupraGroup"];
	httpType = @"getSupraGroup";
	isPrintXML = YES;
	[self call];
    return nil ;
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	
	if ([xmlParam.elementName isEqualToString:@"group"]) 
	{
		NSLog(@"%@", @"获取群信息成功");
		GroupStruct *group = [GroupStruct alloc];
		group.groupId = [xmlParam.attributeDict objectForKey:@"id"];
		group.groupName = [xmlParam.attributeDict objectForKey:@"name"];
		group.notes = [xmlParam.attributeDict objectForKey:@"notes"];
		group.myTypeInGroup = [xmlParam.attributeDict objectForKey:@"groupUserType"];
		//将硬盘中的设置信息读取的内存中
		group.isRecvMessage = [SystemConfig isRecvGroupMessage:group.groupId];
		[GroupDataManage addGroup:group];
		
		GetGroupUsersHttp *http = [GetGroupUsersHttp alloc];
		[http init:group.groupId];
	}	
}



//解析完成后通知
- (void)postEndFunction:(id)sender {
	CIMSocketLogicExt *cimSocketLogicExt = [CIMSocketLogicExt alloc];
	//初始化参数配置
	[cimSocketLogicExt initParam]; 
	//初始化Socket对象
	[cimSocketLogicExt initSocket];
	[CimGlobal addClass:cimSocketLogicExt name:@"CIMSocketLogicExt"];
}



- (void)errorFunction:(ErrorParam*)error 
{
	//[delegate performSelector:@selector(errorAddFriend:) withObject:error];
}


@end
