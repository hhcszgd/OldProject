//
//  ChatUserStruct.m
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ChatUserStruct.h"


@implementation ChatUserStruct

@synthesize dataId, chatType, additionalMessage, additionalUserId;


- (void)addUnReadAmount 
{
	++unReadAmount;
}



- (NSInteger)getUnReadAmount 
{
	return unReadAmount;
}



- (void)clearUnReadAmount 
{
	unReadAmount = 0;
}


//获取唯一标识
- (NSString *)getMark {
    return [NSString stringWithFormat:@"%@_%@", dataId, chatType];
}

@end
