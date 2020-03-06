//
//  MessageStruct.m
//  IOSCim
//
//  Created by apple apple on 11-6-3.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "MessageStruct.h"
#import "Base64.h"
#import "RegexKitLite.h"
#import "Config.h"

@implementation MessageStruct
@synthesize userId, status, type, groupId, remark, time, content, isIncludeImage;


- (NSString*)getContent
{
	if (imageIdArray == nil)
	{
		imageIdArray = [[NSMutableArray alloc] init];
	}
	
	[Base64 initialize];
	NSData *messageData = [Base64 decode:content];
	NSString *responseString = [[NSString alloc] initWithData:messageData  
													 encoding:NSUTF8StringEncoding];
	//过滤多余标签
	responseString = [responseString
					  stringByReplacingOccurrencesOfRegex:@"<div\\/?[^>]+>|<\\/?div>" 
					  withString:@""];
	
	responseString = [responseString
					  stringByReplacingOccurrencesOfRegex:@"<font\\/?[^>]+>|<\\/?font>" 
					  withString:@""];
	
	//替换表情路径
	responseString = [responseString
					  stringByReplacingOccurrencesOfString:@"{$SYS_IMAGE_PATH$}" 
												withString:@"f"];
	
	
	NSArray *imageStringArray = [responseString componentsMatchedByRegex:@"\\}\\{[^img]*\\."];	
	
	if ([imageStringArray count] > 0)
	{
		isIncludeImage = YES;
	}
		
	//过滤已经分析过的图片代码
	/*
	responseString = [responseString
					  stringByReplacingOccurrencesOfRegex:@"<img.*name=.*>"
					  withString:@""];*/
    
   
	
	return responseString;
}




- (NSArray*)getImageIdArray 
{
	return imageIdArray;
}




- (int)getType
{
	return [type intValue];
}




- (NSString*)getTime
{
	NSString *string = [time substringWithRange:NSMakeRange([time length]-6, 6)];
	NSString *hour = [string substringWithRange:NSMakeRange(0, 2)];
	NSString *minute = [string substringWithRange:NSMakeRange(2, 2)];
	NSString *seconds = [string substringWithRange:NSMakeRange(4, 2)];
	return [[NSString alloc] initWithFormat:@"%@:%@:%@", hour, minute, seconds];
}

@end
