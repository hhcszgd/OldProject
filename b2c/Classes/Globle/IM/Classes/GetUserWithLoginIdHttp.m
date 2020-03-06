//
//  GetUserWithLoginIdHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GetUserWithLoginIdHttp.h"
#import "XMLElementParam.h"
#import "MyNotificationCenter.h"
#import "ErrorParam.h"

@implementation GetUserWithLoginIdHttp
@synthesize delegate;

- (void)init:(NSString*)loginId 
{
	//url参数
	additionalParam = [[NSString alloc] initWithFormat:@"&function=%@&loginId=%@&queryUserStatus=%@", @"queryUser", loginId, @"true"];
	httpType = @"queryUser";
    queryKey = loginId;
	isPrintXML = YES;
	[self call];
}
- (void)queryNickName {
    //url参数
    additionalParam = [[NSString alloc] initWithFormat:@"&function=%@&nickName=%@&queryUserStatus=%@", @"queryUser", queryKey, @"true"];
    httpType = @"queryUser";
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
        user.faceIndex = [xmlParam.attributeDict objectForKey:@"faceIndex"];
		[user setStatus:[xmlParam.attributeDict objectForKey:@"status"]];
		[delegate performSelector:@selector(recvGetUserData:) withObject:user];
	}
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}



- (void)errorFunction:(ErrorParam*)error {
    if (!hasCheckNickname) {
        hasCheckNickname = YES;
        [self queryNickName];
        return;
    }
	[delegate performSelector:@selector(errorGetUserData:) withObject:nil];
}


@end
