//
//  CallCIMHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-8.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CallCIMHttp.h"
#import "ParseCIMXML.h"
#import "XMLElementParam.h"
#import "HttpGetData.h"
#import "Config.h"
#import "Debuger.h"
#import "ErrorParam.h"

@implementation CallCIMHttp

//发送Http请求
- (void)call 
{
	NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
	HttpGetData *http = [HttpGetData alloc];
	NSString *urlParam;
	
	if ([httpType isEqualToString:@"login"]) 
	{
		urlParam = [NSString stringWithFormat:@"%@", additionalParam];
	} 
	else 
	{
		urlParam = [NSString stringWithFormat:@"&sessionId=%@%@", sessionId, additionalParam];
	}
	
	if (isPrintXML) 
	{
		NSLog(@"%@", [[Config getPath] stringByAppendingFormat:@"?%@", urlParam]);
	}
	
	[http request:[Config getPath]
			param:urlParam
		 delegate:self
		 selector:@selector(recvData:)];
}




//接收http数据
- (void)recvData:(NSData*)xmlData 
{
	ParseCIMXML *parseXML = [[ParseCIMXML alloc] init:self 
									 parseXMLFunction:@selector(parseXMLFunction:) 
									  postEndFunction:@selector(postEndFunction:) 
										errorFunction:@selector(errorFunction:) 
										     httpType:httpType];
	
	if (isPrintXML) 
	{
		[Debuger printNSData:xmlData];
	}
	
	[parseXML parseXML:xmlData];
}




//解析xml内容
- (void)parseXMLFunction:(XMLElementParam*)xmlParam 
{
}
	 


//解析完成后通知
- (void)postEndFunction:(id)sender 
{
	
}


//处理错误
- (void)errorFunction:(ErrorParam*)error 
{
	
}

@end
