//
//  LoginManage.m
//  IOSCim
//
//  Created by apple apple on 11-5-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "LoginManage.h"
#import "Config.h"
#import "Debuger.h"
#import "SystemConfig.h"
#import "GroupHttp.h"
#import "GetPasswordHttp.h"
#import "LoginHttp.h"
#import "ErrorParam.h"
#import "MyNotificationCenter.h"

@implementation LoginManage

static NSString *_loginId;
static NSString *_password;

+ (void)setLoginId:(NSString*)loginId 
{
	_loginId = loginId;
}



+ (void)setPassword:(NSString*)password 
{
	_password = password;
}



+ (NSString*)getLoginId 
{
	return _loginId;
}



+ (NSString*)getPassword 
{
	return _password;
}



//保存原始的用户名和密码  调用加密接口
- (void)init:(NSString*)loginId password:(NSString*)password 
{
	[LoginManage setLoginId:loginId];
	[LoginManage setPassword:password];
	GetPasswordHttp *http = [GetPasswordHttp alloc];
	http.delegate = self;
	[http init:loginId password:password];
}



- (void)recvGenerationMD5Data:(NSMutableDictionary*)loginIdData 
{
	[self login:loginIdData];
}



- (void)errorGenerationMD5:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
    [MyNotificationCenter postNotification:SystemEventCrowdedOffline setParam:nil];
}


	 
- (void)login:(NSMutableDictionary*)loginIdData 
{
	//NSLog(@"密码解析成功，开始调用登录接口：%@", password);
	NSString *loginId = [loginIdData objectForKey:@"loginId"];
	NSString *password = [loginIdData objectForKey:@"password"];
	
	LoginHttp *http = [LoginHttp alloc];
	http.delegate = self;
	[http init:loginId password:password];
}



- (void)errorLogin:(ErrorParam*)error 
{
	[Debuger systemAlert:error.errorInfo];
    [MyNotificationCenter postNotification:SystemEventCrowdedOffline setParam:nil];
}



- (void)recvLoginData:(NSString*)sessionId 
{
	NSLog(@"登录成功，sessionId为：%@", sessionId);
	GroupHttp *http = [GroupHttp alloc];
	[http init];
}
	 
@end
