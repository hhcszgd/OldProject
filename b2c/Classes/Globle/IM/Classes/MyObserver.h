//
//  MyObserver.h
//  IOSCim
//
//  Created by apple apple on 11-6-14.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyObserver : NSObject {
	id myClass;
	SEL mySelector;
	NSString *obServerId;
}

@property (nonatomic, retain) id myClass;
@property (nonatomic) SEL mySelector;
@property (nonatomic, retain) NSString *obServerId;

@end
