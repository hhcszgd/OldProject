//
//  ParseGetUser.h
//  IOSCim
//
//  Created by apple apple on 11-7-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseXMLString.h"
#import "UserData.h"

@interface ParseGetUser : ParseXMLString {
	UserData *user;
	BOOL isNormal;
	id delegate;
}

@property (nonatomic, retain) id delegate;

@end
