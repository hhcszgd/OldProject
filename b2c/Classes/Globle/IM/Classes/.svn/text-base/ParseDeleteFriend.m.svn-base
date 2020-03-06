//
//  ParseDeleteFriend.m
//  IOSCim
//
//  Created by apple apple on 11-7-21.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ParseDeleteFriend.h"
#import "Debuger.h"


@implementation ParseDeleteFriend

//获得结点头的值
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"result"]) {
		NSString *code = [attributeDict objectForKey:@"code"];
		
		if ([code isEqualToString:@"0"]) {
			[Debuger systemAlert:@"删除成功"];
		} else {
			//删除失败
			[Debuger systemAlert:[attributeDict objectForKey:@"msg"]];
		}
	}
}

@end
