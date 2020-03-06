//
//  ParseGeneration.m
//  IOSCim
//
//  Created by apple apple on 11-5-20.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseGeneration.h"
@implementation ParseGeneration

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
		[myDelegate performSelector:mySelector withObject:password];
	}
}

//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"encrypt"]) {
		password = [attributeDict objectForKey:@"password"];
	}
}

@end
