//
//  GroupManage.m
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GroupManage.h"
#import "Config.h"
#import "Debuger.h"
#import "HttpGetData.h"
#import "ParseGroup.h"
#import "ParseGroupUser.h"

@implementation GroupManage

//获取用户所在的所有群
- (instancetype )init {
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	
	HttpGetData *groupHttp = [HttpGetData alloc];
	//对密码加密
	NSString *urlParam = [NSString stringWithFormat:@"function=%@&sessionId=%@", 
						  @"getGroup", sessionId];
	
	[groupHttp request:[Config getPath] 
				param:urlParam 
			 delegate:self 
			 selector:@selector(recvGroupData:)];
    return nil ;
}


- (void)recvGroupData:(NSData *)xmlData {
	ParseGroup *parseGroup = [ParseGroup alloc];
	[parseGroup create:xmlData];
}


//获取群用户
- (void)getGroupUser:(NSString*)groupId {
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	
	HttpGetData *groupHttp = [HttpGetData alloc];
	//对密码加密
	NSString *urlParam = [NSString stringWithFormat:@"function=%@&sessionId=%@&groupId=%@", 
						  @"getGroupUser", sessionId, groupId];
	
	[groupHttp request:[Config getPath] 
				 param:urlParam 
			  delegate:self 
			  selector:@selector(recvGroupUserData:)];
}


- (void)recvGroupUserData:(NSData *)xmlData {
	[Debuger printNSData:xmlData];
	ParseGroupUser *parseGroupUser = [ParseGroupUser alloc];
	[parseGroupUser create:xmlData];
}


@end
