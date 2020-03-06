//
//  ParseSocketData.h
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseXMLString.h"
#import "MessageStruct.h"
#import "RecvSocketMessage.h"

@interface ParseSocketData : ParseXMLString 
{
	NSString *messageType;
	MessageStruct *chatMessage;
	NSMutableArray *messageArray;
	RecvSocketMessage *recvSocketMessage;
}

- (void)clearData;
- (void)loginResult:(NSString *)code;

@end
