//
//  GetUsersWithIdHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  获取多个用户的数据接口
//

#import "GetUsersWithIdHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"
#import "UserData.h"


@implementation GetUsersWithIdHttp
@synthesize delegate;


- (void)init:(NSString*)usersId 
{
	//url参数
	additionalParam = [[NSString alloc]
					   initWithFormat:@"&function=%@&userId=%@&queryUserStatus=%@", @"getUsers", usersId, @"true"];
	httpType = @"getUsers";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	if ([xmlParam.elementName isEqualToString:@"user"]) 
	{
		UserData *user = [UserData alloc];
		user.userId = [xmlParam.attributeDict objectForKey:@"id"];
		user.loginId = [xmlParam.attributeDict objectForKey:@"loginId"];
		user.nickname = [xmlParam.attributeDict objectForKey:@"nickname"];
		user.idiograph = [xmlParam.attributeDict objectForKey:@"idiograph"];
		user.friendVerifyType = [xmlParam.attributeDict objectForKey:@"friendVerifyType"];
        user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
		[user setStatus:[xmlParam.attributeDict objectForKey:@"status"]];
		//多次回调recvGetUserData 方法
		[delegate performSelector:@selector(recvGetUserData:) withObject:user];
	}
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}



- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(errorGetUsersData:) withObject:nil];
}



@end
