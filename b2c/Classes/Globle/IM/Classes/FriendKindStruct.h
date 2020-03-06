//
//  FriendKindStruct.h
//  IOSCim
//
//  Created by apple apple on 11-6-20.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FriendKindStruct : NSObject {
	NSString *kindId;
	NSString *parentId;
	NSString *kindName;
	NSMutableArray *userIdArray;
}

@property (nonatomic, retain) NSString *kindId;
@property (nonatomic, retain) NSString *parentId;
@property (nonatomic, retain) NSString *kindName;

@end
