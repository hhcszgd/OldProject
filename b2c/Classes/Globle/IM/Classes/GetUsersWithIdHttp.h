//
//  GetUsersWithIdHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"


@interface GetUsersWithIdHttp : CallCIMHttp {
	id delegate;
}

@property (nonatomic, retain) id delegate;
- (void)init:(NSString*)usersId;
@end
