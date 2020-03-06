//
//  LoginHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"
#import "CIMShopListDataStruct.h"
#import "CIMFriendListDataStruct.h"

@interface LoginHttp : CallCIMHttp 
{
	id delegate;
	NSString *parentElementName;
	NSString *shopId;
	NSString *deptId;
	NSString *kindId;
	NSString *sessionId;
	CIMShopListDataStruct *cimShopListDataStruct;
	CIMFriendListDataStruct *cimFriendListDataStruct;
}

@property (nonatomic, retain) id delegate;
- (void)init:(NSString*)loginId password:(NSString*)password ;

@end
