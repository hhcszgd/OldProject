//
//  SetGroupUserHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SetGroupUserHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"
#import "GroupStruct.h"
#import "GroupDataManage.h"
#import "SystemConfig.h"

@implementation SetGroupUserHttp
@synthesize delegate;


- (void)addUser:(NSString*)userId groupId:(NSString*)groupId 
{
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&groupId=%@&userId=%@&op=%@", 
					   @"setGroupUser", groupId, userId, @"add"];
	httpType = @"setGroupUser";
	isPrintXML = YES;
	[self call];
}



- (void)removeUser:(NSString*)userId groupId:(NSString*)groupId 
{
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&groupId=%@&userId=%@&op=%@", 
					   @"setGroupUser", groupId, userId, @"del"];
	httpType = @"setGroupUser";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	[delegate performSelector:@selector(recvSetGroupUserData:) withObject:nil];
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}



- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(errorSetGroupUser:) withObject:error];
}

@end
