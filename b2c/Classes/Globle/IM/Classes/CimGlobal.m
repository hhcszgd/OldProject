//
//  CimGlobal.m
//  IOSCim
//
//  Created by apple apple on 11-8-15.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  将需要全局使用的Class保存在这个静态类中 以便在任何地方都可以使用
//

#import "CimGlobal.h"


@implementation CimGlobal

static NSMutableDictionary *classDictionary;


+ (void)addClass:(NSObject*)class name:(NSString*)name 
{
	if (classDictionary == nil) 
	{
		classDictionary = [[NSMutableDictionary alloc] init];
	}
	
	[classDictionary setObject:class forKey:name];
}



+ (id)getClass:(NSString*)name {
	return [classDictionary objectForKey:name];
}


@end
