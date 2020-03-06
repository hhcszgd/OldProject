//
//  UserChatData.h
//  IOSCim
//
//  Created by apple apple on 11-6-1.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserChatData : NSObject {
	NSString *userName;
	NSString *sendTime;
	NSString *content;
	NSString *groupId;
	NSString *userId;
	BOOL isSystemMessage;
	BOOL isSelf;
	NSMutableArray *imageIdArray;
}

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *sendTime;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSMutableArray *imageIdArray;
@property (assign) BOOL isSelf;
@property (assign) BOOL isSystemMessage;

+ (NSString*)getNow;
- (NSString*)getContent;

@end
