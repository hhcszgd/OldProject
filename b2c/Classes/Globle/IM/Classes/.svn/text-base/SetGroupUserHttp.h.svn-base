//
//  SetGroupUserHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"

@interface SetGroupUserHttp : CallCIMHttp {
	id delegate;
}

@property (nonatomic, retain) id delegate;

- (void)addUser:(NSString*)userId groupId:(NSString*)groupId;
- (void)removeUser:(NSString*)userId groupId:(NSString*)groupId;

@end
