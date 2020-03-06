//
//  SystemConfig.m
//  IOSCim
//
//  Created by apple apple on 11-6-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SystemConfig.h"
#import "UserData.h"

@implementation SystemConfig

static NSMutableDictionary *configDict;
//static NSString *configDictPath;


//获取保存的路径
+ (NSString*)getFilePath:(NSString*)fileName 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
	NSString *documentDirectory = [paths objectAtIndex:0]; 
	return [documentDirectory stringByAppendingPathComponent:fileName];
}


+ (void)init 
{
	configDict = [[NSMutableDictionary alloc] init];
	[configDict setDictionary:[NSDictionary dictionaryWithContentsOfFile:[self getFilePath:@"SystemConfig.txt"]]];
	
	if ([configDict.allKeys count] == 0) 
	{
		[self saveConfigData];
	}

	//[self addLoginUser:@"尹彦明" password:@"888888"];
}


+ (void)saveConfigData
{
	[configDict writeToFile:[self getFilePath:@"SystemConfig.txt"] atomically:YES];
}


//设置 隐身登录
+ (void)setLoginStatus 
{
	if ([self getLoginStatus]) 
	{
		[configDict setObject:@"0" forKey:@"loginStatus"];
	} 
	else 
	{
		[configDict setObject:@"1" forKey:@"loginStatus"];
	}
	
	[self saveConfigData];
}


//是否 隐身登录
+ (BOOL)getLoginStatus 
{
	NSString *loginStatusValue = [configDict objectForKey:@"loginStatus"];
	
	if (loginStatusValue == nil || [loginStatusValue isEqualToString:@"0"]) 
	{
		return NO;
	}
	
	return YES;
}

//设置 自动登录
+ (void)setAutoLogin
{
    if ([self getAutoLogin])
    {
        [configDict setObject:@"0" forKey:@"autoLogin"];
    }
    else
    {
        [configDict setObject:@"1" forKey:@"autoLogin"];
    }
    
    [self saveConfigData];
}


//是否 自动登录
+ (BOOL)getAutoLogin
{
    NSString *autoLoginValue = [configDict objectForKey:@"autoLogin"];
    
    if (autoLoginValue == nil || [autoLoginValue isEqualToString:@"0"])
    {
        return NO;
    }
    
    return YES;
}

//设置 记住密码
+ (void)setRememberPassword 
{
	if (![self isRememberParssword])
	{
		[configDict setObject:@"1" forKey:@"isRemember"];
	} 
	else
	{
		[configDict setObject:@"0" forKey:@"isRemember"];
	}
			 
	[self saveConfigData];
}
+ (void)setRememberPasswordByBOOL:(BOOL)isRemeber {
    if (isRemeber) {
        [configDict setObject:@"1" forKey:@"isRemember"];
    } else {
        [configDict setObject:@"0" forKey:@"isRemember"];
    }
    [self saveConfigData];
}

//是否记住密码
+ (BOOL)isRememberParssword 
{
	NSString *isRemember = [configDict objectForKey:@"isRemember"];
	
	if (isRemember == nil || [isRemember isEqualToString:@"0"]) 
	{
		return NO;
	} 
	else 
	{
		return YES;
	}
}


//设置声音提示
+ (void)setSoundRemind 
{
	//NSString *isRemember = [configDict objectForKey:@"isSoundRemind"];
	
	if (![self isSoundRemind]) 
	{
		[configDict setObject:@"1" forKey:@"isSoundRemind"];
	} 
	else 
	{
		[configDict setObject:@"0" forKey:@"isSoundRemind"];
	}
	
	[self saveConfigData];
}



//是否有声音提示
+ (BOOL)isSoundRemind 
{
	NSString *isRemember = [configDict objectForKey:@"isSoundRemind"];
	//默认开始声音提示
	if (isRemember == nil || [isRemember isEqualToString:@"1"]) 
	{
		return YES;
	} 
	else if ([isRemember isEqualToString:@"0"]) 
	{
		return NO;
	}
    return YES;
}
//是否震动模式
+ (BOOL)isShockMode {
    NSString *isShockMode = [configDict objectForKey:@"isShockMode"];
    //默认开始声音提示
    if (isShockMode == nil || [isShockMode isEqualToString:@"1"]) {
        return YES;
    } else if ([isShockMode isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}
//设置震动模式
+ (void)setShockMode {
    if (![self isShockMode]) {
        [configDict setObject:@"1" forKey:@"isShockMode"];
    } else {
        [configDict setObject:@"0" forKey:@"isShockMode"];
    }
    [self saveConfigData];
}
//是否接收群消息
+ (BOOL)isReceiveGroupMessage {
    NSString *isReceiveGroupMessage = [configDict objectForKey:@"isReceiveGroupMessage"];
    //默认开始声音提示
    if (isReceiveGroupMessage == nil || [isReceiveGroupMessage isEqualToString:@"1"]) {
        return YES;
    } else if ([isReceiveGroupMessage isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}
//设置接收群消息
+ (void)setReceiveGroupMessage {
    if (![self isReceiveGroupMessage]) {
        [configDict setObject:@"1" forKey:@"isReceiveGroupMessage"];
    } else {
        [configDict setObject:@"0" forKey:@"isReceiveGroupMessage"];
    }
    [self saveConfigData];
}
//setGuestOnline
//是否提示好友上线
+ (BOOL)isGuestOnline {
    NSString *isGuestOnline = [configDict objectForKey:@"isGuestOnline"];
    //默认开始声音提示
    if (isGuestOnline == nil || [isGuestOnline isEqualToString:@"1"]) {
        return YES;
    } else if ([isGuestOnline isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}
//设置提示好友上线
+ (void)setGuestOnline {
    if (![self isGuestOnline]) {
        [configDict setObject:@"1" forKey:@"isGuestOnline"];
    } else {
        [configDict setObject:@"0" forKey:@"isGuestOnline"];
    }
    [self saveConfigData];
}
//设置是否接收群消息 开关
+ (void)setRecvGroupMessageSwitch:(NSString*)groupId 
{
	NSMutableDictionary *recvGroupMessageSwitch = [configDict objectForKey:@"recvGroupMessageSwitch"];
	
	if (recvGroupMessageSwitch == nil) 
	{
		recvGroupMessageSwitch = [[NSMutableDictionary alloc] init];
		[configDict setObject:recvGroupMessageSwitch forKey:@"recvGroupMessageSwitch"];
	}
	
	//NSString *groupSwitch = [recvGroupMessageSwitch objectForKey:groupId];
	
	if ([self isRecvGroupMessage:groupId]) 
	{
		[recvGroupMessageSwitch setObject:@"0" forKey:groupId];
	} 
	else 
	{
		[recvGroupMessageSwitch setObject:@"1" forKey:groupId];
	}

	[self saveConfigData];
}



//是否接收群消息
+ (BOOL)isRecvGroupMessage:(NSString*)groupId 
{
	NSMutableDictionary *recvGroupMessageSwitch = [configDict objectForKey:@"recvGroupMessageSwitch"];
	
	if (recvGroupMessageSwitch == nil) 
	{
		return YES;
	}
	
	NSString *groupSwitch = [recvGroupMessageSwitch objectForKey:groupId];
	
	if (groupSwitch == nil || [groupSwitch isEqualToString:@"1"]) 
	{
		return YES;
	} else {
		return NO;
	}
}



//添加登录帐号和密码
+ (void)addLoginUser:(NSString*)loginId password:(NSString*)password 
{	
	NSMutableDictionary *loginUsers = [configDict objectForKey:@"loginUsers"];
	
	if (loginUsers == nil) 
	{
		loginUsers = [[NSMutableDictionary alloc] init];
		[configDict setObject:loginUsers forKey:@"loginUsers"];
	}
	
	[loginUsers setObject:password forKey:loginId];
	[configDict setObject:loginId forKey:@"lastLoginId"];
	[configDict setObject:password forKey:@"lastPassword"];
	[self saveConfigData];
}



//删除登录多的用户信息
+ (void)deleteLoginUser:(NSString*)loginId 
{
	NSMutableDictionary *loginUsers = [configDict objectForKey:@"loginUsers"];
	[loginUsers removeObjectForKey:loginId];
	[self saveConfigData];
}



//获取记忆的登录帐号信息
+ (NSMutableDictionary*)getMemberedLoginData 
{
	return [configDict objectForKey:@"loginUsers"];
}



+ (NSMutableDictionary*)getLassLoginData 
{
	NSString *lastLoginId = [configDict objectForKey:@"lastLoginId"];
	NSString *lastPassword = [configDict objectForKey:@"lastPassword"];
	
	if (lastLoginId == nil)
	{
		return nil;
	}
	
	NSMutableDictionary *loginData = [[NSMutableDictionary alloc] init];
	[loginData setObject:lastLoginId forKey:@"loginId"];
	[loginData setObject:lastPassword forKey:@"password"];
	return loginData;
}


@end
