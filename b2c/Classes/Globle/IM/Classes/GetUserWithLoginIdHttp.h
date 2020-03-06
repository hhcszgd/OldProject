//
//  GetUserWithLoginIdHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"
#import "UserData.h"

@interface GetUserWithLoginIdHttp : CallCIMHttp {
	id delegate;
	UserData *user;
    NSString *queryKey;
    BOOL hasCheckNickname;
}

@property (nonatomic, retain) id delegate;
- (void)init:(NSString*)loginId;
@end
