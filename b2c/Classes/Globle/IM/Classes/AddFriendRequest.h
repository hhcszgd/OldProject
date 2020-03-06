//
//  AddFriendRequest.h
//  IOSCim
//
//  Created by apple apple on 11-8-3.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommViewController.h"

@interface AddFriendRequest : CommViewController {
	IBOutlet UILabel *systemTips;
	IBOutlet UITextView *requestContent;
	NSString *tipsMessage;
	NSString *friendId;
}


@property (nonatomic, retain) IBOutlet UILabel *systemTips;
@property (nonatomic, retain) IBOutlet UITextView *requestContent;
@property (nonatomic, retain) NSString *tipsMessage;
@property (nonatomic, retain) NSString *friendId;

@end
