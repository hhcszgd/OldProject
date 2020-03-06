//
//  YYMDebug.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMDebug.h"


@implementation YYMDebug


//显示NSData中的数据
+ (void)printNSData:(NSData*)data 
{
	NSString *responseString = [[NSString alloc] initWithData:data 
													 encoding:NSUTF8StringEncoding];
	NSLog(@"%@", responseString);
}

@end
