//
//  LoginManage.h
//  IOSCim
//
//  Created by apple apple on 11-5-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseXMLString.h"

@interface LoginManage : ParseXMLString {
	id myDelegate;
	SEL mySelector;
	NSString *myLoginId;
}

-(void)init:(NSString*)loginId password:(NSString*)password;
+ (NSString*)getLoginId;
+ (NSString*)getPassword;
@end
