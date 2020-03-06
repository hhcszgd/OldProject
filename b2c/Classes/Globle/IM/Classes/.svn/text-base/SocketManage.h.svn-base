//
//  SocketManage.h
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SocketManage : NSObject {

}

+ (void)connectSocket;
+ (void)requestUserStatus:(NSMutableArray*)usersId;
+ (void)setMyStatus:(int)status;

+ (void)sendMessage:(NSString*)message usersId:(NSMutableArray*)usersId;
+ (void)sendMessage:(NSString*)message userId:(NSString*)userId;
+ (void)sendGroupMessage:(NSString*)message groupId:(int)groupId;

+ (void)rememberUpdateStatusNumber;
+ (void)noticeUpdateStatus;
@end
