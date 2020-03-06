//
//  HttpWebService.m
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpWebService.h"

@implementation HttpWebService

/**
 * 调用http数据接口
 * @param url 访问地址
 * @param param 表单参数 
 * example:NSString *postData = [NSString stringWithFormat:@"page=%@&param1=%@", @"item1", @"item 2"];
 */

+ (NSData *)get:(NSString *)url param:(NSString *)param {
	NSURL *dataUrl = [NSURL URLWithString:url];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataUrl 
													   cachePolicy:NSURLRequestReloadIgnoringCacheData 
													   timeoutInterval:60];
	
	NSString *length = [NSString stringWithFormat:@"%lu", [param length]];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:length forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSHTTPURLResponse* urlResponse = nil;
	NSError *error = [[NSError alloc] init] ;  
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request
												 returningResponse:&urlResponse 
												 error:&error]; 
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	responseString = [responseString substringWithRange: NSMakeRange(16, [responseString length] - 17)];
	NSLog(@"%@", responseString);
	return [responseString dataUsingEncoding: NSUTF8StringEncoding];
}

@end
