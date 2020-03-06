//
//  YYMXMLCache.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMXMLCache.h"
#import "YYMFilePath.h"


@implementation YYMXMLCache



- (void)create
{
	xmlDictionary = [[NSMutableDictionary alloc] init];
	[xmlDictionary setDictionary:[NSDictionary dictionaryWithContentsOfFile:[YYMFilePath getDocPath:filePath]]];
	
	if ([xmlDictionary.allKeys count] == 0) 
	{
		[self save];
	}
}


- (void)save 
{
	[xmlDictionary writeToFile:[YYMFilePath getDocPath:filePath] atomically:YES];
}

@end
