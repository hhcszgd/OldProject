//
//  GetGroupHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GetGroupHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"
#import "GroupStruct.h"
#import "UserData.h"

@implementation GetGroupHttp
@synthesize delegate;

- (void)init:(NSString*)groupCode 
{
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&groupCode=%@", @"getGroupDetail", groupCode];
	httpType = @"getGroupDetail";
	isPrintXML = YES;
	[self call];
}


- (void)initWithGourpId:(NSString*)groupId 
{
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&groupId=%@", @"getGroupDetail", groupId];
	httpType = @"getGroupDetail";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	
	if ([xmlParam.elementName isEqualToString:@"group"]) 
	{
		if (_group == nil) 
		{
			_group = [GroupStruct alloc];
		}
		
		_group.groupId = [xmlParam.attributeDict objectForKey:@"id"];
		_group.groupName = [xmlParam.attributeDict objectForKey:@"name"];
		_group.notes = [xmlParam.attributeDict objectForKey:@"notes"];
		_group.isRecvMessage = YES;
	}
	
	
	if ([xmlParam.elementName isEqualToString:@"user"]) 
	{
		UserData *user = [UserData alloc];
		user.userId = [xmlParam.attributeDict objectForKey:@"id"];
		user.loginId = [xmlParam.attributeDict objectForKey:@"loginId"];
		user.nickname = [xmlParam.attributeDict objectForKey:@"nickname"];
		user.idiograph = [xmlParam.attributeDict objectForKey:@"idiograph"];
        user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
		_group.groupMaster = user;
	}
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	[delegate performSelector:@selector(recvGetGroupData:) withObject:_group];
}



- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(errorGetGroup:) withObject:error];
}


@end
