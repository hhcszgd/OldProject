//
//  GetPasswordHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GetPasswordHttp.h"
#import "XMLElementParam.h"
#import "MyNotificationCenter.h"
#import "ErrorParam.h"

@implementation GetPasswordHttp
@synthesize delegate;

- (void)init:(NSString*)loginId password:(NSString*)password 
{
	_loginId = loginId;
	//url参数
	additionalParam = [[NSString alloc]
					   initWithFormat:@"&function=%@&data=%@&loginId=%@", 
					   @"generationMD5Type", password, loginId];
	httpType = @"generationMD5Type";
	isPrintXML = NO;
	[self call];
}



- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
	if ([xmlParam.elementName isEqualToString:@"encrypt"]) 
	{
		NSMutableDictionary *loginIdData = [[NSMutableDictionary alloc] init];
		[loginIdData setObject:[xmlParam.attributeDict objectForKey:@"password"] forKey:@"password"];
		[loginIdData setObject:_loginId forKey:@"loginId"];
		NSLog(@"获取密码成功");
		[delegate performSelector:@selector(recvGenerationMD5Data:) withObject:loginIdData];
	}
}



//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}



- (void)errorFunction:(ErrorParam*)error 
{
	[delegate performSelector:@selector(errorGenerationMD5:) withObject:error];
}


@end
