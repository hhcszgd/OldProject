//
//  SocketOb.h
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SocketOb : NSObject {
	id myClass;
	SEL method;
}

@property (nonatomic, retain) id myClass;
@property (nonatomic) SEL method;

@end
