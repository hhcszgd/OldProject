//
//  ParseFriend.m
//  IOSCim
//
//  Created by apple apple on 11-7-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseFriend.h"
#import "MyNotificationCenter.h"

@implementation ParseFriend

//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"result"]) {
		NSString *code = [attributeDict objectForKey:@"code"];
		
		if ([code isEqualToString:@"0"]) {
			//添加成功
			[MyNotificationCenter postNotification:HttpAddFriendDataComplete setParam:@"0"];
		} else {
			//添加失败
			[MyNotificationCenter postNotification:HttpAddFriendDataComplete setParam:[attributeDict objectForKey:@"msg"]];
		}
	}
}


@end
