//
//  SystemChatRequestAddGroup.h
//  IOSCim
//
//  Created by apple apple on 11-8-12.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatUserStruct.h"
#import "CIMSocketLogicExt.h"


@interface SystemChatRequestAddGroup : UIViewController {
	ChatUserStruct *currentChatUser;
	CIMSocketLogicExt *cimSocketLogicExt;
}

@property (nonatomic, retain) ChatUserStruct *currentChatUser;

- (IBAction)agreeAddGroup:(id)sender;

- (IBAction)refuseAddGroup:(id)sender;

@end
