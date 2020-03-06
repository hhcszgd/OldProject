//
//  RecvAddFriendRequest.h
//  IOSCim
//
//  Created by apple apple on 11-8-4.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface RecvAddFriendRequest : NSObject {
	NSString *requestContent;
	NSString *messageType;
	BOOL isRuning;
}

@property (nonatomic, retain) NSString *requestContent;
@property (nonatomic, retain) NSString *messageType;

- (void)recvHttpData:(UserData*)user;
- (void)recvMessage:(NSString*)userId;
@end
