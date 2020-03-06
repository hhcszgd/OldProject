//
//  ErrorParam.h
//  IOSCim
//
//  Created by apple apple on 11-8-8.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ErrorParam : NSObject {
	NSString *errorCode;
	NSString *errorInfo;
}


@property (nonatomic, retain) NSString *errorCode;
@property (nonatomic, retain) NSString *errorInfo;

@end
