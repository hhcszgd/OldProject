//
//  GuestData.m
//  IOSCim
//
//  Created by apple apple on 11-8-15.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "GuestData.h"


@implementation GuestData

@synthesize userId, guestCode, guestName, lastAccessTime, lastAccessPage, isTalked;

- (NSString*)getGuestName 
{
	if (guestName == nil) 
	{
		return [[NSString alloc] initWithFormat:@"访客%@", guestCode];
	}
	
	return guestName;
}

@end
