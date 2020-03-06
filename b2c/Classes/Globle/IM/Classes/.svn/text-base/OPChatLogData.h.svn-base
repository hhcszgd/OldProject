//
//  OPChatLogData.h
//  IOSCim
//
//  Created by apple apple on 11-6-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "UserData.h"
#import "YYMSqlite.h"


@interface OPChatLogData : YYMSqlite 
{

	NSMutableDictionary *guestDictionary;
	NSMutableDictionary *strangerDictonary;
	NSString *_userLoginId;
}


- (id)init:(NSString*)userLoginId;
- (NSMutableArray*)getStrangers;
- (NSMutableArray*)getGuestsInfo;


//保存沟通过的访客
- (void)addGuestUser:(UserData*)user;
//删除访客
- (void)deleteGeustById:(NSString *)userId;

- (void)addMessageLog:(NSString*)loginerUserId 
		 chatWitherId:(NSString*)chatWitherId 
		 sendObjectId:(NSString*)sendObjectId
	   messageContent:(NSString*)messageContent 
			 sendTime:(NSString*)sendTime 
		  messageType:(int)messageType;

- (NSMutableArray*)getMessageLog:(NSString*)loginerUserId 
					chatWitherId:(NSString*)chatWitherId;


- (void)deleteMessageLog:(NSString*)loginerUserId chatWitherId:(NSString*)chatWitherId;
- (NSMutableArray*)getMessageLog:(NSString*)loginerUserId chatWitherId:(NSString*)chatWitherId messageType:(int)messageType;
- (void)removeStranger:(NSString*)userId ;
- (void)addStranger:(UserData*)user;
@end
