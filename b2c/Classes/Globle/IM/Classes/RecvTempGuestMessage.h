//
//  RecvTempGuestMessage.h
//  IOSCim
//
//  Created by apple apple on 11-8-17.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RecvTempGuestMessage : NSObject {
	NSString *_userId;
}
- (void)init:(NSString*)userId;

@end
