//
//  ChatLogCell.m
//  IOSCim
//
//  Created by apple apple on 11-5-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "ChatLogCell.h"
#import "UserChatData.h"
#import "UserDataManage.h"
#import "RegexKitLite.h"

@implementation ChatLogCell
@synthesize myUserName, mySendTime, myContent;

- (void)buildChatCell:(UserChatData*)chatData 
{
	CGFloat contentWidth = self.frame.size.width;
	CGFloat bubbleWidth = contentWidth - 80.0f;
	CGFloat leftPoint = contentWidth - bubbleWidth - 10.0f;
	UIFont *font = [UIFont systemFontOfSize:14];
    
    
    

	NSError *err = nil;
	NSString *realContent = [chatData.content
							 stringByReplacingOccurrencesOfRegex:@"<img\/?[^>]+>"
													  withString:@" "];
	realContent = [realContent stringByReplacingOccurrencesOfRegex:@"<IMG\/?[^>]+>"
													withString:@" "];
 
	
	CGSize size = [realContent sizeWithFont:[UIFont systemFontOfSize:18]
						  constrainedToSize:CGSizeMake(bubbleWidth - 10, 1000)
						  lineBreakMode:UILineBreakModeWordWrap];
	
	if (myUserName == nil)
	{
		//根据上面选择的气泡背景图片创建ＵIImageView对象
		bubbleImageView = [[UIImageView alloc] initWithImage:
										[[UIImage imageNamed:chatData.isSelf ? @"bubble.png" : @"bubbleSelf.png"] 
										 stretchableImageWithLeftCapWidth:21
															 topCapHeight:14]];
		bubbleImageView.backgroundColor = [UIColor clearColor];
		
		//自己的消息靠左显示
		if (chatData.isSelf)
		{
			bubbleImageView.frame = CGRectMake(10.0f, 10.0f, bubbleWidth, size.height + 30.0f);
			myContent = [[UITextView alloc] initWithFrame:CGRectMake(20, 30, bubbleWidth - 10, size.height + 10)];
			myUserName = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 130, 20)];
			mySendTime = [[UILabel alloc] initWithFrame:CGRectMake(bubbleWidth - 60, 15, 60, 20)];
		} 
		else
		{
			bubbleImageView.frame = CGRectMake(leftPoint, 10.0f, bubbleWidth, size.height + 30.0f);
			myContent = [[UITextView alloc]
						 initWithFrame:CGRectMake(leftPoint, 30, bubbleWidth - 10, size.height + 10)];
			myUserName = [[UILabel alloc] initWithFrame:CGRectMake(leftPoint + 10.f, 15, 130, 20)];
			mySendTime = [[UILabel alloc] initWithFrame:CGRectMake(bubbleWidth - 15, 15, 60, 20)];
		}
		
		myUserName.backgroundColor = [UIColor clearColor];
		mySendTime.backgroundColor = [UIColor clearColor];
		myUserName.font = font;
		mySendTime.font = font;
		myContent.editable = NO;
		myContent.scrollEnabled = NO;
		myContent.font = font;

		[self addSubview:bubbleImageView];
		[self addSubview:myUserName];
		[self addSubview:mySendTime];
		[self addSubview:myContent];
	} 
	else
	{
		if (chatData.isSelf) 
		{
			myContent.frame = CGRectMake(20, 30, bubbleWidth - 10.0f, size.height + 10);
			myUserName.frame = CGRectMake(25, 15, 130, 20);
			mySendTime.frame = CGRectMake(bubbleWidth - 60, 15, 60, 20);

			bubbleImageView.image = [UIImage imageNamed:@"bubble.png"];
			bubbleImageView.frame = CGRectMake(10.0f, 10.0f, bubbleWidth, size.height + 30.0f);
		} 
		else
		{
			myContent.frame = CGRectMake(leftPoint + 10.0f, 30, bubbleWidth - 10, size.height + 10);
			myUserName.frame = CGRectMake(leftPoint + 10.0f, 15, 130, 20);
			mySendTime.frame = CGRectMake(bubbleWidth - 15, 15, 60, 20);
			bubbleImageView.image = [UIImage imageNamed:@"bubbleSelf.png"];
			bubbleImageView.frame = CGRectMake(leftPoint, 10.0f, bubbleWidth, size.height + 30.0f);
		}	
	}

	NSString *selfName = [[UserDataManage getSelfUser] getUserName];
	
	if (chatData.isSelf)
	{
		myUserName.textColor = [UIColor blueColor];
	} 
	else
	{
		myUserName.textColor = [UIColor whiteColor];
	}

	[myUserName setText:chatData.userName];
	mySendTime.text = chatData.sendTime;
	//[myContent setText:chatData.content];
	NSString *htmlContent = [[NSString alloc] initWithFormat:@"%@", [chatData getContent]];
	
    NSLog(@"----@%" ,htmlContent);
    myContent.text=htmlContent;
       myContent.backgroundColor = [UIColor clearColor];
	self.backgroundColor = [UIColor clearColor];
}




//计算行高
+ (CGFloat)getCellHeight:(UserChatData*)chatData contentWidth:(CGFloat)contentWidth 
{
	NSString *content = chatData.content;
	NSString *realContent = [content stringByReplacingOccurrencesOfRegex:@"<IMG\/?[^>]+>"
															  withString:@" "];
	realContent = [realContent stringByReplacingOccurrencesOfRegex:@"<img\/?[^>]+>"
															  withString:@" "];
	CGFloat bubbleWidth = contentWidth - 80.0f;
	CGSize size = [realContent sizeWithFont:[UIFont systemFontOfSize:18]
							   constrainedToSize:CGSizeMake(bubbleWidth - 10, 1000)
								   lineBreakMode:UILineBreakModeWordWrap];
	
	NSLog(@"过滤后的内容: %@ 高度为: %f  屏幕宽度: %f", realContent, size.height + 20 + 20, contentWidth);
	return size.height + 20 + 20;
}


@end
