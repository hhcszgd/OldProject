//
//  GetGuestHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"


@interface GetGuestHttp : CallCIMHttp 
{
	id delegate;
	NSString *_userId;
}

@property (nonatomic, retain) id delegate;
- (void)init:(NSString*)userId;
@end
