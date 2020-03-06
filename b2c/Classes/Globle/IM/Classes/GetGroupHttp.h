//
//  GetGroupHttp.h
//  IOSCim
//
//  Created by apple apple on 11-8-9.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallCIMHttp.h"
#import "GroupStruct.h"

@interface GetGroupHttp : CallCIMHttp {
	id delegate;
	GroupStruct *_group;
}
- (void)initWithGourpId:(NSString*)groupId;
- (void)init:(NSString*)groupCode;
@property (nonatomic, retain) id delegate;

@end
