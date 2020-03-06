//
//  SocketObserver.h
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

enum SocketObServerType {
	SocketObServerTypeDidLogin = 0,
	SocketObServerTypeUpdateStatus = 1,
	SocketObServerTypeRecvMessage = 2,
	SocketObServerTypeTipsMessage = 3
};

typedef enum SocketObServerType SocketObServerType;

@interface SocketObserver : NSObject {
	
}

+ (void) addObserver:(id)class selector:(SEL)method obType:(SocketObServerType)obType;
+ (void) removeObserver:(id)class selector:(SEL)selector obType:(SocketObServerType)obType;
+ (void) update:(SocketObServerType)obType setObject:(id)object;
@end
