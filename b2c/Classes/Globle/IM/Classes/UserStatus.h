//
//  UserStatus.h
//  IOSCim
//
//  Created by apple apple on 11-6-1.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
	UserStatusOnline = 10,
	UserStatusBusy = 20,
	UserStatusLeave = 30,
	UserStatusStealth = 40,
	UserStatusOffline = 50
};

@interface UserStatus : NSObject {

}

@end
