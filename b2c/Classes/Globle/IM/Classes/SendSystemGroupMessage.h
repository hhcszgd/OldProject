//
//  SendSystemGroupMessage.h
//  IOSCim
//
//  Created by apple apple on 11-8-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SendSystemGroupMessage : NSObject {
	id delegate;
	SEL selector;
}

@property (nonatomic, retain) id delegate;


@end
