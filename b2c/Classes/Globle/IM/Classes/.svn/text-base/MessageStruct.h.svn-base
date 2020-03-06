//
//  MessageStruct.h
//  IOSCim
//
//  Created by apple apple on 11-6-3.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseXMLString.h"

@interface MessageStruct : ParseXMLString {
	NSString *userId;
	NSString *status;
	NSString *type;
	NSString *groupId;
	NSString *remark;
	NSString *time;
	NSString *content;
	NSString *realContent;
	NSMutableArray *imageIdArray;
	BOOL isIncludeImage;
	
	id myDelegate;
	SEL myDelegateSelector;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *content;
@property (assign) BOOL isIncludeImage;


- (NSString*)getContent;
- (NSString*)getTime;
- (int)getType;
- (NSArray*)getImageIdArray;

@end
