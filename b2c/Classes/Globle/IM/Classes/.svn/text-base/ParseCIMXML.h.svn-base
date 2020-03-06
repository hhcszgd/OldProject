//
//  ParseCIMXML.h
//  IOSCim
//
//  Created by apple apple on 11-8-8.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLElementParam.h"

@interface ParseCIMXML : NSObject<NSXMLParserDelegate> {
	id _delegate;
	SEL _parseXMLFunction;
	SEL _postEndFunction;
	SEL _errorFunction;
	NSString *_httpType;
	BOOL isCorrect;
	XMLElementParam *param;
}
- (ParseCIMXML*)init:(id)delegate parseXMLFunction:(SEL)parseXMLFunction postEndFunction:(SEL)postEndFunction errorFunction:(SEL)errorFunction httpType:(NSString*)httpType;
- (void)parseXML:(NSData*)xmlData;
@end
