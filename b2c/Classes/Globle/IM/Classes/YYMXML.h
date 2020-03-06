//
//  YYMXML.h
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLElementParam.h"


@interface YYMXML : NSObject<NSXMLParserDelegate> {
	id _delegate;
	SEL _parseXMLFunction;
	SEL _postEndFunction;
	SEL _errorFunction;
	NSString *_httpType;
	BOOL isCorrect;
	XMLElementParam *param;
}

@end
