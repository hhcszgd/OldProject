//
//  ParseGetUser.m
//  IOSCim
//
//  Created by apple apple on 11-7-11.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseGetUser.h"
#import "MyNotificationCenter.h"
#import "UserData.h"

@implementation ParseGetUser

@synthesize delegate;


//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"result"]) {
		NSString *code = [attributeDict objectForKey:@"code"];
		
		if (![code isEqualToString:@"0"]) {
			//没有数据
			isNormal = NO;
			
			if (delegate != nil) {
				[delegate performSelector:@selector(recvHttpData) withObject:user];
			} else {
				[MyNotificationCenter postNotification:HttpGetUserDataComplete setParam:user];
			}

			return;
		} else {
			isNormal = YES;
		}
	}
	
	if (isNormal) {
		if (user == nil) {
			user = [UserData alloc];
		}
		
		if ([elementName isEqualToString:@"user"]) {
			user.userId = [attributeDict objectForKey:@"id"];
			user.loginId = [attributeDict objectForKey:@"loginId"];
			user.nickname = [attributeDict objectForKey:@"nickname"];
			user.idiograph = [attributeDict objectForKey:@"idiograph"];
			user.friendVerifyType = [attributeDict objectForKey:@"friendVerifyType"];
			[user setStatus:[attributeDict objectForKey:@"status"]];
			
			if (delegate != nil) {
				[delegate performSelector:@selector(recvHttpData:) withObject:user];
			} else {
				[MyNotificationCenter postNotification:HttpGetUserDataComplete setParam:user];
			}
		}
	}
}


@end
