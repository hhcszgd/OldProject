//
//  RecvAddGroupResponse.h
//  IOSCim
//
//  Created by apple apple on 11-8-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageStruct.h"


@interface RecvAddGroupResponse : NSObject {
	NSString *groupId;
	MessageStruct *message;
	NSString *messageType;
	NSString *requestContent;
}


@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *messageType;
@property (nonatomic, retain) NSString *requestContent;
@property (nonatomic, retain) MessageStruct *message;

@end
