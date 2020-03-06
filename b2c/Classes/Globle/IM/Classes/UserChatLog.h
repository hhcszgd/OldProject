//
//  UserChatLog.h
//  IOSCim
//
//  Created by apple apple on 11-6-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserChatLog : NSObject {
	NSString *sendUserId;
	NSString *recvUserId;
	NSString *messageContent;
	NSString *sendTime;
	int messageType;
}

@property (nonatomic, retain) NSString *sendUserId;
@property (nonatomic, retain) NSString *recvUserId;
@property (nonatomic, retain) NSString *messageContent;
@property (nonatomic, retain) NSString *sendTime;
@property (nonatomic) int  messageType;

@end
