//
//  ExistFriendHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-8.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"

@interface ExistFriendHttp : CallCIMHttp {
	id delegate;
}

@property (nonatomic, retain) id delegate;
- (void)init:(NSString*)friendLoginId ;
@end
