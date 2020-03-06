//
//  ParseGroupUser.m
//  IOSCim
//
//  Created by apple apple on 11-7-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseGroupUser.h"
#import "GroupUserManage.h"
#import "GroupDataManage.h"
#import "UserData.h"
#import "MyNotificationCenter.h"


@implementation ParseGroupUser

//获得结点结尾的值
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"cim"]) {
		[MyNotificationCenter postNotification:HttpGroupUserDataComplete setParam:groupId];
	}
}

//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"group"]) {
		groupId = [attributeDict objectForKey:@"id"];
	}
	
	
	if ([elementName isEqualToString:@"user"]) {
		UserData *user = [UserData alloc];
		user.userId = [attributeDict objectForKey:@"id"];
		user.loginId = [attributeDict objectForKey:@"loginId"];
		user.nickname = [attributeDict objectForKey:@"nickname"];
		user.idiograph = [attributeDict objectForKey:@"idiograph"];
		[[GroupDataManage getGroup:groupId] addUser:user];
		//[GroupUserManage addGroupUser:user groupId:groupId];
	}
}


@end
