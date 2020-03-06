//
//  SendSocketContent.h
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SendSocketContent : NSObject {

}

+ (NSString *)getLoginXML:(int)priority userStatus:(int)userStatus;
+ (NSString *)getQueryUserStatusXML:(NSMutableArray*)usersId;
+ (NSString *)getSendCheckPackageXML;
+ (NSString *)getSendMessageXML:(NSString*)message usersId:(NSMutableArray*)usersId messageType:(int)messageType groupId:(NSString*)groupId;
+ (NSString *)setMyStatus:(int)status;
+ (NSString *)getGroupMessageXML:(NSString*)message groupId:(int)groupId messageType:(NSString*)messageType;
+ (NSString *)getSendMessageXML:(NSString*)message usersId:(NSMutableArray*)usersId messageType:(int)messageType groupId:(NSString*)groupId remark:(NSString *)remark;
@end
