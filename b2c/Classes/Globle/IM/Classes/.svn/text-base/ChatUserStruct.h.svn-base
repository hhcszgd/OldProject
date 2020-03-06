//
//  ChatUserStruct.h
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ChatUserStruct : NSObject {
	NSString *dataId;
	NSString *chatType;
	NSMutableArray *holdReadArray;
	NSInteger unReadAmount;
	NSString *additionalMessage;
	NSString *additionalUserId;
}

@property (nonatomic, retain) NSString *dataId;
@property (nonatomic, retain) NSString *chatType;
@property (nonatomic, retain) NSString *additionalMessage;
@property (nonatomic, retain) NSString *additionalUserId;

- (void)addUnReadAmount;

- (NSInteger)getUnReadAmount;

- (void)clearUnReadAmount;
- (NSString *)getMark;
@end
