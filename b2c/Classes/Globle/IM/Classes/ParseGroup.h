//
//  ParseGroup.h
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseXMLString.h"

@interface ParseGroup : ParseXMLString {
	id myDelegate;
	SEL mySelector;
}

- (void)setDelegate:(id)delegate selector:(SEL)selector;

@end
