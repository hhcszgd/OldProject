//
//  YYMHttp.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMHttp.h"


@implementation YYMHttp

//发送请求
- (void)send:(NSString*)url param:(NSString *)param 
{	
	NSURL *dataUrl = [[NSURL alloc] initWithString:url];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:dataUrl];
	[request setTimeoutInterval:timeout];
	
	NSString *length = [[NSString alloc] initWithFormat:@"%d", [param length]];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:length forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
	
	[NSURLConnection connectionWithRequest:request delegate:self];

} 


/////////////////////////////////////////////////


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[receivedData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	NSString *responseString = [[NSString alloc] initWithData:receivedData 
													 encoding:NSUTF8StringEncoding];
	
	[self recvData:responseString];
}


//网络错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
	[self netError];
}


////////////////////////////////////////////////////////////////


//接收数据
- (void)recvData:(NSString*)data 
{
	
}


- (void)netError 
{
	NSLog(@"%@", @"网络无法连接, 请检查网络设置");
}


@end
