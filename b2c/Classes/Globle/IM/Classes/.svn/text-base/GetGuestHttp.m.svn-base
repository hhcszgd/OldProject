//
//  GetGuestHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GetGuestHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"
#import "UserDataManage.h"
#import "UserData.h"
#import "ChatUserStruct.h"
#import "MyNotificationCenter.h"
#import "Debuger.h"
#import "CimGlobal.h"
#import "CIMGuestListDataStruct.h"
#import "UserListKindDataStruct.h"

@implementation GetGuestHttp
@synthesize delegate;


- (void)init:(NSString*)userId
{
	_userId = userId;
	//url参数
	additionalParam = [[NSString alloc]
					   initWithFormat:@"&function=%@&userId=%@", @"getGuest", userId];
	httpType = @"getGuest";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	if ([xmlParam.elementName isEqualToString:@"user"]) 
	{
		UserData *user = [UserData alloc];
		user.userId = _userId;
		user.guestCode = [xmlParam.attributeDict objectForKey:@"code"];
		user.nickname = [NSString stringWithFormat:@"访客_%@", user.guestCode];
		[delegate performSelector:@selector(recvGetGuestData:) withObject:user];
	}
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}



- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(getGuestError:) withObject:error];
}



@end
