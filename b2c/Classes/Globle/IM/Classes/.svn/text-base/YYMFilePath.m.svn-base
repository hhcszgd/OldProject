//
//  YYMFilePath.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMFilePath.h"


@implementation YYMFilePath


//获取系统路径
+ (NSString*)getDocPath:(NSString*)path 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
	NSString *documentDirectory = [paths objectAtIndex:0];
	NSString *docPath = [documentDirectory stringByAppendingPathComponent:path]; 
	return docPath;
}

@end
