//
//  GetUserManage.m
//  IOSCim
//
//  Created by apple apple on 11-7-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GetUserManage.h"
#import "Config.h"
#import "Debuger.h"
#import "HttpGetData.h"
#import "ParseGetUser.h"

@implementation GetUserManage
@synthesize delegate;


- (void)init:(NSString*)userLoginId {
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	//userLoginId = @"王世建";
	HttpGetData *shopHttp = [HttpGetData alloc];
	//对密码加密
	NSString *urlParam = [NSString stringWithFormat:@"function=%@&sessionId=%@&loginId=%@&queryUserStatus=true", 
						  @"getUsers", sessionId, userLoginId];
	
	NSLog(@"请求地址为:%@", urlParam);
	
	[shopHttp request:[Config getPath]
				param:urlParam 
			 delegate:self 
			 selector:@selector(recvUserData:)];
	
}

- (void)recvUserData:(NSData *)xmlData {
	[Debuger printNSData:xmlData];
	ParseGetUser *parseGetUser = [ParseGetUser alloc];
	parseGetUser.delegate = delegate;
	[parseGetUser create:xmlData];
}


- (void)getUserWithId:(NSString*)userId {
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	HttpGetData *shopHttp = [HttpGetData alloc];
	NSString *urlParam = [NSString stringWithFormat:@"function=%@&sessionId=%@&userId=%@&queryUserStatus=true", 
						  @"getUsers", sessionId, userId];
	
	NSLog(@"请求地址为:%@", urlParam);
	
	[shopHttp request:[Config getPath]
				param:urlParam 
			 delegate:self 
			 selector:@selector(recvUserData:)];
}


@end
