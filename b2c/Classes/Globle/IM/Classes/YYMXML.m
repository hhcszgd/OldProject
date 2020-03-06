//
//  YYMXML.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMXML.h"
#import "XMLElementParam.h"
#import "ErrorParam.h"


@implementation YYMXML

//注册代理
- (YYMXML*)init:(id)delegate parseXMLFunction:(SEL)parseXMLFunction 
	 postEndFunction:(SEL)postEndFunction 
	   errorFunction:(SEL)errorFunction
			httpType:(NSString*)httpType 
{
	
	_delegate = delegate;
	_parseXMLFunction = parseXMLFunction;
	_postEndFunction = postEndFunction;
	_errorFunction = errorFunction;
	_httpType = httpType;
	return self;
}



//解析XML内容
- (void)parseXML:(NSData*)xmlData 
{
	NSXMLParser *xmlRead = [[NSXMLParser alloc] initWithData:xmlData]; //初始化NSXMLParser对象
	[xmlRead setDelegate:self]; //设置NSXMLParser对象的解析方法代理
	[xmlRead parse]; //调用代理解析NSXMLParser对象，看解析是否成功
}



//获得结点结尾的值
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName 
{
	
	if ([elementName isEqualToString:@"cim"] && isCorrect) 
	{
		[_delegate performSelector:_postEndFunction withObject:nil];
	}
}



//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict 
{
	
	if (param == nil) 
	{
		param = [XMLElementParam alloc];
	}
	
	param.elementName = elementName;
	param.attributeDict = attributeDict;
	
	if (isCorrect) 
	{
		[_delegate performSelector:_parseXMLFunction withObject:param];
	}
	
	
	if ([elementName isEqualToString:@"result"]) 
	{
		NSString *code = [attributeDict objectForKey:@"code"];
		
		if ([code isEqualToString:@"0"]) 
		{
			isCorrect = YES;
			[_delegate performSelector:_parseXMLFunction withObject:param];
			return;
		} 
		else 
		{
			ErrorParam *error = [ErrorParam alloc];
			error.errorCode = code;
			error.errorInfo = [attributeDict objectForKey:@"msg"];
			[_delegate performSelector:_errorFunction withObject:error];
			return;
		}
	}
}


@end
