//
//  GlobalAttribute.m
//  IOSCim
//
//  Created by apple apple on 11-9-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GlobalAttribute.h"

@implementation GlobalAttribute

static BOOL isLogined;

+ (void)setIsLogined:(BOOL)value
{
	isLogined = value;
}


+ (BOOL)getIsLogined
{
	return isLogined;
}


+ (void)logout
{
	[self setIsLogined:NO];
}

@end
