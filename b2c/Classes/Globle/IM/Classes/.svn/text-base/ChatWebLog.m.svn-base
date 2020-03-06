//
//  ChatWebLog.m
//  IOSCim
//
//  Created by apple apple on 11-6-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ChatWebLog.h"
#import "UserChatData.h"

@implementation ChatWebLog
@synthesize myUserName, mySendTime, myContent;

- (void)buildChatCell:(UserChatData*)chatData {
	CGFloat contentWidth = self.frame.size.width;
	UIFont *font = [UIFont systemFontOfSize:14];
	CGSize size = [chatData.content sizeWithFont:font 
							   constrainedToSize:CGSizeMake(contentWidth, 1000) 
								   lineBreakMode:UILineBreakModeWordWrap]; 
	
	if (myUserName == nil) {
		myUserName = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 130, 30)];
		myUserName.font = font;
		mySendTime =  [[UILabel alloc]initWithFrame:CGRectMake(100, 2, 160, 30)];
		mySendTime.font = font;
		myContent = [[UIWebView alloc] initWithFrame:CGRectMake(10, 40, 400, 100)];
		//myContent.font = font;
		[self addSubview:myUserName];
		[self addSubview:mySendTime];
		[self addSubview:myContent];
	} else {
		[myContent setFrame:CGRectMake(10, 40, contentWidth, size.height)];
	}
	
	[myUserName setText:chatData.userName];
	myUserName.backgroundColor = [UIColor clearColor];
	[mySendTime setText:chatData.sendTime];
	mySendTime.backgroundColor = [UIColor clearColor];
	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:path];
	NSString *contentString = [[NSString alloc] initWithFormat:@"<html><body style='margin:0px;'>%@</body></html>", chatData.content];

	[myContent loadHTMLString:contentString baseURL:baseURL];
	self.backgroundColor = [UIColor clearColor];
}

@end
