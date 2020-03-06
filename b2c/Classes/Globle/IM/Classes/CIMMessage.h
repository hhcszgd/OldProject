//
//  CIMMessage.h
//  IOSCim
//
//  Created by apple apple on 11-5-4.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface CIMMessage : NSObject {
	AsyncSocket *socket;
}

@end
