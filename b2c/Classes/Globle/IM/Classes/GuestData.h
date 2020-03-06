//
//  GuestData.h
//  IOSCim
//
//  Created by apple apple on 11-8-15.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GuestData : NSObject {
	NSString *userId;
	NSString *guestCode;
	NSString *guestName;
	NSString *lastAccessTime;
	NSString *lastAccessPage;
	BOOL isTalked;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *guestCode;
@property (nonatomic, retain) NSString *guestName;
@property (nonatomic, retain) NSString *lastAccessTime;
@property (nonatomic, retain) NSString *lastAccessPage;
@property (assign) BOOL isTalked; 

@end
