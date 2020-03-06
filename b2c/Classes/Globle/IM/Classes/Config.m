//
//  Config.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Config.h"
@implementation Config

static NSString *logicServer = @"203.130.41.166";
static NSString *communicationServer = @"203.130.41.166";
static NSString *tomcatPort = @"8878";
static int communicationPort = 19998;

static NSString *projectName = @"cimls";
static NSString *domain = @"";
static BOOL isCallHttpHander = YES;
static NSString *chatlogViewType = @"text";

+ (void)init
{
	
}


+ (void)canelCallHttpHander 
{
	isCallHttpHander = NO;
}


+ (void)agreeCallHttpHander 
{
	isCallHttpHander = YES;
}


+ (BOOL)getCellHttpHander 
{
	return isCallHttpHander;
}

+ (NSString *)getProjectPath {
    return [NSString stringWithFormat:@"http://%@:%@/%@", logicServer, tomcatPort, projectName];;
}
+ (NSString*)getPath
{
	return [NSString stringWithFormat:@"http://%@:%@/%@/service/HttpService", logicServer, tomcatPort, projectName];
}



//获取下载路径
+ (NSString*)getDownloadPath:(NSString*)fileId
{
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	return [NSString stringWithFormat:@"http://%@:%@/%@/service/UserFileDownload?sessionId=%@&fileId=%@",  
	logicServer, tomcatPort, projectName, sessionId, fileId];
}



+ (NSString*)getFacePath
{
	return [NSString stringWithFormat:@"http://%@:%@/%@/webtm/templets/2011/View/InnerChat/face/", 
			logicServer, tomcatPort, projectName];
}


+ (int)getFaceCount {
	return 105;
}



//获取用户头像的url地址
+ (NSString*)getUserHeadImagePath:(NSString*)faceIndex {
	return [NSString stringWithFormat:@"http://%@:%@/%@/images/userface/%@-40-10.gif", logicServer, tomcatPort, projectName, faceIndex];
}



+ (NSString*)getCommunicationServer 
{
	[self init];
	return communicationServer;
}



+ (int)getCommunicationPort 
{
	return communicationPort;
}



+ (NSString*)getDomain 
{
	return domain;
}


+ (NSString*)getChatLogViewType 
{
	return chatlogViewType;
}


@end
