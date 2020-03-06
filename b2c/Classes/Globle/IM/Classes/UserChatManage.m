//
//  UserChatManage.m
//  IOSCim
//
//  Created by apple apple on 11-5-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//
#import "UserChatManage.h"
#import "UserChatData.h"

@implementation UserChatManage

- (void)addChatMessage:(UserChatData *)data userId:(NSString*)userId {
	if ([chatLog objectForKey:userId] == nil) {
		NSMutableArray *chatArray;
		[chatLog setObject:chatArray forKey:userId];
		chatArray = [[NSMutableArray alloc] init];
	}
	
	NSMutableArray *myChatArray = [chatLog objectForKey:userId];
	[myChatArray addObject:data];
}

- (NSMutableArray*)getChatMessage:(NSString*)userId {
	return [chatLog objectForKey:userId];
}



@end
