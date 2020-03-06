//
//  ParseGroup.m
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseGroup.h"
#import "GroupStruct.h"
#import "GroupDataManage.h"
#import "MyNotificationCenter.h"
#import "SocketManage.h"
#import "SystemConfig.h"

@implementation ParseGroup

- (void)setDelegate:(id)delegate selector:(SEL)selector {
	myDelegate = delegate;
	mySelector = selector;
}

//获得结点结尾的值
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"cim"]) {
		//建立Socket通信
		[SocketManage connectSocket];
		//[MyNotificationCenter postNotification:HttpGroupDataComplete setParam:nil];
	}
}

//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"group"]) {
		GroupStruct *group = [GroupStruct alloc];
		group.groupId = [attributeDict objectForKey:@"id"];
		group.groupName = [attributeDict objectForKey:@"name"];
		group.notes = [attributeDict objectForKey:@"notes"];
		//将硬盘中的设置信息读取的内存中
		group.isRecvMessage = [SystemConfig isRecvGroupMessage:group.groupId];
		[GroupDataManage addGroup:group];
		//[myDelegate performSelector:mySelector withObject:resultData];
	}
}


@end
