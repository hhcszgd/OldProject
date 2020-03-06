//
//  Language.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-3-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Language.h"
@implementation Language

static NSDictionary *lang;
static NSDictionary *userStatus;

+ (void)init 
{
	lang = [NSDictionary dictionaryWithObjectsAndKeys:
			@"账号:",@"login_loginId",
			@"密码:", @"login_password", 
			@"登陆",@"login_submit",
			@"退出",@"login_exit",
			@"结束登陆",@"loading_exitLoading",
			@"会话",@"tabBar_chatButton",			
			@"好友",@"tabBar_friendButton",			
			@"群组",@"tabBar_groupButton",			
			@"最近",@"tabBar_nearButton",
			@"访客",@"tabBar_guestButton",
			nil];
}


+ (NSString *)getLanguage:(NSString *)key 
{
	return [lang objectForKey:key];	
}



@end
