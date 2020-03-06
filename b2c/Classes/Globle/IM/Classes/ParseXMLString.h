//
//  ParseXMLString.h
//  IOSCim
//
//  Created by apple apple on 11-5-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParseXMLString : NSObject<NSXMLParserDelegate> {
	
}

- (void)create:(NSData *)xmlData;

@end
