//
//  GetUserWithIdHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GetUserWithIdHttp.h"
#import "XMLElementParam.h"
#import "MyNotificationCenter.h"
#import "ErrorParam.h"

@implementation GetUserWithIdHttp
@synthesize delegate;


- (void)init:(NSString*)userId 
{
	//url参数
	additionalParam = [[NSString alloc]
					   initWithFormat:@"&function=%@&userId=%@&queryUserStatus=%@", @"getUsers", userId, @"true"];
	httpType = @"getUsers";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	if (user == nil) 
	{
		user = [UserData alloc];
	}
	
	if ([xmlParam.elementName isEqualToString:@"user"]) 
	{
		user.userId = [xmlParam.attributeDict objectForKey:@"id"];
		user.loginId = [xmlParam.attributeDict objectForKey:@"loginId"];
		user.nickname = [xmlParam.attributeDict objectForKey:@"nickname"];
		user.idiograph = [xmlParam.attributeDict objectForKey:@"idiograph"];
		user.friendVerifyType = [xmlParam.attributeDict objectForKey:@"friendVerifyType"];
		[user setStatus:[xmlParam.attributeDict objectForKey:@"status"]];
		user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
		[delegate performSelector:@selector(recvGetUserData:) withObject:user];
	}
}


//解析完成后通知
- (void)postEndFunction:(id)sender {
	
}


- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(errorGetUserData:) withObject:nil];
}


@end
