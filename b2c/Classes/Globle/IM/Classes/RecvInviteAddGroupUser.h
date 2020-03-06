//
//  RecvInviteAddGroupUser.h
//  IOSCim
//
//  Created by apple apple on 11-8-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageStruct.h"

@interface RecvInviteAddGroupUser : NSObject {
	NSString *groupId;
	NSString *addUserId;
	MessageStruct *message;
}

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *addUserId;
@property (nonatomic, retain) MessageStruct *message;

@end
