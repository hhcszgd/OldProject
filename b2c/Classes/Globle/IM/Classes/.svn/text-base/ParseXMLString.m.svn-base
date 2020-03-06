//
//  ParseXMLString.m
//  IOSCim
//
//  Created by apple apple on 11-5-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseXMLString.h"
@implementation ParseXMLString


- (void)create:(NSData *)xmlData 
{
	NSXMLParser *xmlRead = [[NSXMLParser alloc] initWithData:xmlData]; //初始化NSXMLParser对象
	[xmlRead setDelegate:self]; //设置NSXMLParser对象的解析方法代理
	[xmlRead parse]; //调用代理解析NSXMLParser对象，看解析是否成功 
}



//解析器，从两个结点之间读取内容
- (void)parser:(NSXMLParser *)parser 
	foundCharacters:(NSString *)string 
{
	//NSLog(@"%@", string);
}



//获得结点结尾的值
- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName
	namespaceURI:(NSString *)namespaceURI
	qualifiedName:(NSString *)qName 
{
	
}



//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
	didStartElement:(NSString *)elementName
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict 
{
	
}



- (void)myParser:(NSXMLParser *)parser 
	didStartElement:(NSString *)elementName
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict 
{
	
}
@end
