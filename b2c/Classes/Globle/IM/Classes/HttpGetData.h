//
//  HttpGetData.h
//  IOSCim
//
//  Created by apple apple on 11-5-18.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpGetData : NSObject {
	NSMutableURLRequest *request;
	id myDelegate;
	SEL mySelector;
	int timeoutValue;
	NSURLConnection *connecttion;
	NSMutableData *receivedData;
}


-(void)request:(NSString*)url param:(NSString *)param delegate:(id)delegate selector:(SEL)selector;
@end
