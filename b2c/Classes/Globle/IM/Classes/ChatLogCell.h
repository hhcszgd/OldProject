//
//  ChatLogCell.h
//  IOSCim
//
//  Created by apple apple on 11-5-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserChatData.h"

@interface ChatLogCell : UITableViewCell {
	UILabel *myUserName;
	UILabel *mySendTime;
	UITextView *myContent;
	UILabel *bgLabel;
	UIImageView *bubbleImageView;
}

@property (nonatomic, retain) UILabel *myUserName;
@property (nonatomic, retain) UILabel *mySendTime;
@property (nonatomic, retain) UITextView *myContent;

- (void)buildChatCell:(UserChatData*)chatData;
+ (CGFloat)getCellHeight:(UserChatData*)chatData contentWidth:(CGFloat)contentWidth;

@end
