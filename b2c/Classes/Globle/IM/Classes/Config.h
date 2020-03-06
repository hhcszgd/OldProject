//
//  Config.h
//  IOSCim
//
//  Created by fukq helpsoft on 11-4-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject {
	
}

+ (void)init;
+ (NSString *)getPath;
+ (int)getFaceCount;
+ (NSString *)getCommunicationServer;
+ (int)getCommunicationPort;
+ (NSString *)getDomain;
+ (NSString*)getFacePath;
+ (void)agreeCallHttpHander;
+ (void)canelCallHttpHander;
+ (BOOL)getCellHttpHander;
+ (NSString *)getProjectPath;
+ (NSString*)getUserHeadImagePath:(NSString*)faceIndex;
+ (NSString*)getDownloadPath:(NSString*)fileId;
@end
