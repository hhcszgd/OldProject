//
//  YYMData.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMData.h"


@implementation YYMData

//获取当前的系统时间
+ (NSString*)getNow
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	[dateFormatter setDateFormat:@"HH:mm:ss"];
	return [dateFormatter stringFromDate:[NSDate date]];
}

@end
