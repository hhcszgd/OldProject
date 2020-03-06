//
//  SystemChatRequestAddFriend.h
//  IOSCim
//
//  Created by apple apple on 11-8-4.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatUserStruct.h"
#import "CIMSocketLogicExt.h"
#import "CommViewController.h"

@interface SystemChatRequestAddFriend : CommViewController {
	IBOutlet UIImageView *userHeadImage;
	IBOutlet UILabel *userLoginId;
	IBOutlet UILabel *userSignature;
	IBOutlet UIButton *verificationMessage;
	ChatUserStruct *currentChatUser;
	CIMSocketLogicExt *cimSocketLogicExt;
}

@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UIButton *buttonTwo;
@property (retain, nonatomic) IBOutlet UIButton *buttonOne;
@property (nonatomic, retain) IBOutlet UIImageView *userHeadImage;
@property (nonatomic, retain) IBOutlet UILabel *userLoginId;
@property (nonatomic, retain) IBOutlet UILabel *userSignature;
@property (nonatomic, retain) IBOutlet UIButton *verificationMessage;
@property (nonatomic, retain) ChatUserStruct *currentChatUser;

- (IBAction)agreeAddFriend:(id)sender;
- (IBAction)refuseAddFriend:(id)sender;

@end
