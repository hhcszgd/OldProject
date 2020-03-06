//
//  SystemMessage.m
//  IOSCim
//
//  Created by apple apple on 11-8-5.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "SystemMessage.h"
#import "Tool.h"
#import "SystemVariable.h"

@implementation SystemMessage

@synthesize msgImg, messageContent, content;

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidDisappear:animated];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	title = @"系统消息";
    isShowBackButton = YES;
	messageContent.text = content;
	messageContent.numberOfLines = 0;	
	CGSize labelSize = CGSizeMake(250, 50);
	CGSize theStringSize = [content sizeWithFont:messageContent.font 
							   constrainedToSize:labelSize 
								   lineBreakMode:messageContent.lineBreakMode];
	
	//决绝文字内容动态调整UILabel的大小
	messageContent.frame = CGRectMake(messageContent.frame.origin.x, messageContent.frame.origin.y, theStringSize.width, theStringSize.height);
    
    //全屏大小
    CGRect mainRect = [Tool screenRect];
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //导航栏高度
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    
    //背景图
    CGRect backgroundViewRect = mainRect;
    if (IS_GTE_IOS7) {
        backgroundViewRect.origin.y -= (statusBarHeight + navigationBarHeight);
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:backgroundViewRect];
    backgroundView.image = [UIImage imageNamed:@"appBG"];
    [self.view addSubview:backgroundView];
    
    if (IS_GTE_IOS7) {
    } else {
        CGRect tempRect = messageContent.frame;
        tempRect.origin.y += navigationBarHeight;
        messageContent.frame = tempRect;
        
        tempRect = msgImg.frame;
        tempRect.origin.y += navigationBarHeight;
        msgImg.frame = tempRect;
    }
    [[msgImg superview] bringSubviewToFront:msgImg];
    [[messageContent superview] bringSubviewToFront:messageContent];
    [super viewDidLoad];
}





- (void)viewDidUnload {
    [self setMsgImg:nil];
    [super viewDidUnload];
}
@end
