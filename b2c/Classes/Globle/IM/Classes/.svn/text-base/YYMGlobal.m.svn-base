//
//  YYMGlobal.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMGlobal.h"


@implementation YYMGlobal

static NSMutableDictionary *objectDictionary;


+ (void)addObject:(NSObject*)object name:(NSString*)name 
{
	if (objectDictionary == nil) 
	{
		objectDictionary = [[NSMutableDictionary alloc] init];
	}
	
	[objectDictionary setObject:object forKey:name];
}



+ (NSObject*)getObject:(NSString*)name 
{
	return [objectDictionary objectForKey:name];
}

@end
