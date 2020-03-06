//
//  Debuger.m
//  IOSCim
//
//  Created by apple apple on 11-5-23.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "Debuger.h"


@implementation Debuger

+ (void)printNSData:(NSData*)data {
	NSString *responseString = [[NSString alloc] initWithData:data 
													 encoding:NSUTF8StringEncoding];
	NSLog(@"%@", responseString);
}

+ (void)systemAlert:(NSString *)content {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:content
													message:nil 
												   delegate:self 
										  cancelButtonTitle:@"确定" 
										  otherButtonTitles:nil];
	
	[alert show];
}

@end
