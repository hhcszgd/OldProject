//
//  ParseSocketData.m
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  解析消息的xml结构并分配给响应的处理方法
//

#import "ParseSocketData.h"
#import "SocketObserver.h"
#import "UserDataManage.h"
#import "MessageStruct.h"
#import "MsgSound.h"
#import "RecvSocketMessage.h"
#import "ChatListDataStruct.h"
#import "MyNotificationCenter.h"
#import "Debuger.h"
#import "CIMShopListDataStruct.h"
#import "CimGlobal.h"
#import "SystemConfig.h"

@implementation ParseSocketData


//获得结点结尾的值
- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:@"cim"]) 
	{
		if ([messageType isEqualToString:@"queryStatus"]) 
		{
			sleep(0.1);
			//堆栈 状态消息
			[MyNotificationCenter postNotification:SocketUpdateStatus setParam:nil];
		} 
		else if ([messageType isEqualToString:@"recvMessage"]) 
		{
			[recvSocketMessage recvMessage:chatMessage];
		}
	}
}




//获取消息内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
	if ([messageType isEqualToString:@"recvMessage"]) 
	{
		chatMessage.content = string;
	}
}




//获取消息属性
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict 
{
	
	if ([elementName isEqualToString:@"cim"]) 
	{
		if (chatMessage == nil)
		{
			chatMessage = [MessageStruct alloc];
		}
		
		if (recvSocketMessage == nil) 
		{
			recvSocketMessage = [RecvSocketMessage alloc];
			[CimGlobal addClass:recvSocketMessage name:@"RecvSocketMessage"];
		}
		
		messageType = [attributeDict objectForKey:@"type"];
		
		  //登录消息
		if ([messageType isEqualToString:@"login"])
		{
			[recvSocketMessage loginResult:[attributeDict objectForKey:@"errorCode"]];
		}
	}
	
	
	//联系人状态数据
	if ([elementName isEqualToString:@"user"] && [messageType isEqualToString:@"queryStatus"]) 
	{
		NSString *userId = [attributeDict objectForKey:@"id"];
		NSString *userStatus = [attributeDict objectForKey:@"status"];
		//更新内存中状态数据
		[[UserDataManage getUser:userId] setStatus:userStatus];
	}
	
	
	if ([elementName isEqualToString:@"user"] && [messageType isEqualToString:@"recvMessage"]) 
	{
		chatMessage.userId = [attributeDict objectForKey:@"id"];
		chatMessage.status = [attributeDict objectForKey:@"status"];
	}
	
	
	if ([elementName isEqualToString:@"message"] && [messageType isEqualToString:@"recvMessage"]) 
	{
		chatMessage.type = [attributeDict objectForKey:@"type"];
		chatMessage.groupId = [attributeDict objectForKey:@"groupId"];
		chatMessage.remark = [attributeDict objectForKey:@"remark"];
		chatMessage.time = [attributeDict objectForKey:@"time"];
	}
}


@end
