//
//  ParseLogin.h
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseXMLString.h"
#import "UserDataManage.h"

@interface ParseLogin : ParseXMLString {
	id myDelegate;
	SEL mySelector;
	NSMutableDictionary *resultData;
	NSString *shopId;
	NSString *parentDeptId;
	NSString *deptId;
	NSString *deptName;
	NSString *kindId;
	NSMutableDictionary *shopUsers;
	NSMutableDictionary *shopDepts;
	NSMutableArray *shopDeptsId;
	NSMutableArray *shopUsersId;
	BOOL isShopMaster;
	UserDataManage *userDataManage;
}

- (void)setDelegate:(id)delegate selector:(SEL)selector;
@end
