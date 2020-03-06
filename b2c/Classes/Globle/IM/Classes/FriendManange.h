//
//  FriendManange.h
//  IOSCim
//
//  Created by apple apple on 11-7-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendManange : NSObject {
	NSString *myFriendId;
}


- (void)deleteFriend:(NSString*)friendId;

@end