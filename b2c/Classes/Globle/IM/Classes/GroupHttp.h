//
//  GroupHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"

@interface GroupHttp : CallCIMHttp {
	id delegate;
}

@property (nonatomic, retain) id delegate;

@end
