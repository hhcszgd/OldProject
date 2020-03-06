//
//  CIMSocketLogic.h
//  IOSCim
//
//  Created by apple apple on 11-8-19.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIMSocket.h"
#import "ParseSocketData.h"


@interface CIMSocketLogic : CIMSocket {
	ParseSocketData *parseSocketData;
    NSTimer *checkTimer;
}
- (void)sendMessageToUser:(NSString*)message userId:(NSString*)userId messageType:(int)messageType groupId:(NSString*)groupId;
- (void)sendGroupMessage:(NSString*)message groupId:(int)groupId;
- (void)queryStatusForUsers:(NSMutableArray*)usersId;
- (void)sendMessageToUsers:(NSString*)message usersId:(NSMutableArray*)usersId messageType:(int)messageType groupId:(NSString*)groupId;
- (void)sendSystemGroupMessage:(NSString*)message groupId:(NSString*)groupId messageType:(NSString*)messageType;
- (void)sendMessageToUser:(NSString*)message userId:(NSString*)userId messageType:(int)messageType groupId:(NSString*)groupId;
- (void)startCheckPackageTimer;
- (void)setMyStatus:(int)status;
- (void)queryStatusForUser:(NSString*)userId;
- (void)initParam;
- (void)sendMessageToUsers:(NSString*)message usersId:(NSMutableArray*)usersId messageType:(int)messageType groupId:(NSString*)groupId remark:(NSString *)remark;
@end
