//
//  GroupStruct.h
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface GroupStruct : NSObject {
	NSString *groupId;
	NSString *groupName;
	NSString *notes;
	NSMutableArray *groupChatLog;
	BOOL isRecvMessage;
	NSMutableArray *userIdArray;
	UserData *groupMaster;
	NSString *myTypeInGroup;
}

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *myTypeInGroup;
@property (assign) BOOL isRecvMessage;
@property (nonatomic, retain) UserData *groupMaster;
- (NSMutableArray*)getMessage ;
- (NSArray*)getUsers;
- (void)clearMessage;
- (void)addMessage:(UserChatData*)chatData;
- (void)addImageMessage:(NSString*)imageId downloadId:(NSString*)downloadId messageType:(int)messageType;
- (void)addUser:(UserData*)user;
- (NSArray*)getUsersId;
- (void)clearUsers ;
@end
