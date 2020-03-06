//
//  ExistFriendHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-8.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ExistFriendHttp.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"

@implementation ExistFriendHttp
@synthesize delegate;


- (void)init:(NSString*)friendLoginId 
{
	//url参数
	additionalParam = [[NSString alloc] 
					   initWithFormat:@"&function=%@&loginId=%@", @"existFriend", friendLoginId];
	httpType = @"existFriend";
	isPrintXML = YES;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	//是单边好友
	[delegate performSelector:@selector(isUnilateralFriend:) withObject:nil];
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{

}



- (void)errorFunction:(ErrorParam*)error 
{
	//是黑名单用户
	if ([error.errorCode isEqualToString:@"23"]) 
	{
		[delegate performSelector:@selector(isBlackListUser:) withObject:nil];
	} 
	else 
	{
		[delegate performSelector:@selector(isNormalUser:) withObject:nil];
	}
}

@end
