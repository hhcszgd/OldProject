//
//  HttpGetData.m
//  IOSCim
//
//  Created by apple apple on 11-5-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "HttpGetData.h"
#import "Debuger.h"
#import "Config.h"
#import "MyNotificationCenter.h"

@implementation HttpGetData

- (void)request:(NSString*)url param:(NSString *)param delegate:(id)delegate selector:(SEL)selector 
{
	myDelegate = delegate;
	mySelector = selector;
	
	if (timeoutValue == 0) 
	{
		timeoutValue = 20;
	}
	
	NSURL *dataUrl = [[NSURL alloc] initWithString:url];
	request = [[NSMutableURLRequest alloc] init];
	//NSLog(@"发送HTTP请求:%@?%@", dataUrl, param);
	[request setURL:dataUrl];
	[request setTimeoutInterval:timeoutValue];
	
	NSString *length = [[NSString alloc] initWithFormat:@"%d", [param length]];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:length forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
	
	connecttion = [NSURLConnection connectionWithRequest:request delegate:self];
	receivedData = [[NSMutableData alloc] init];
} 

/**
 b2c_im_test@163.com/123456
 */
- (void)setTimeout:(int)timeout 
{
	timeoutValue = timeout;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	[receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[receivedData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	responseString = [responseString substringWithRange: NSMakeRange(16, [responseString length] - 17)];
#warning crash
	if ([Config getCellHttpHander]) {
		[myDelegate performSelector:mySelector withObject:[responseString dataUsingEncoding: NSUTF8StringEncoding]];
	}
}

//超时报警
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[Debuger systemAlert:@"HTTP连接超时，请检查网络状态"];
    [MyNotificationCenter postNotification:SystemEventCrowdedOffline setParam:nil];
}

@end
