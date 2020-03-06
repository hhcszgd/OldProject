//
//  AddFriendRequest.m
//  IOSCim
//
//  Created by apple apple on 11-8-3.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "AddFriendRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "Debuger.h"
#import "CIMSocketLogicExt.h"
#import "CimGlobal.h"
#import "SystemVariable.h"
#import "Tool.h"

@implementation AddFriendRequest

@synthesize systemTips, requestContent, tipsMessage, friendId;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    title = @"好友验证";
    isShowBackButton = YES;
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
        CGRect tempRect = systemTips.frame;
        tempRect.origin.y += navigationBarHeight;
        systemTips.frame = tempRect;
        
        tempRect = requestContent.frame;
        tempRect.origin.y += navigationBarHeight;
        requestContent.frame = tempRect;
    }
    [[systemTips superview] bringSubviewToFront:systemTips];
    [[requestContent superview] bringSubviewToFront:requestContent];
    
	systemTips.text = [[NSString alloc] initWithFormat:@"希望添加%@为好友", tipsMessage];
	requestContent.layer.cornerRadius = 6;
	requestContent.layer.masksToBounds = YES;
	
	UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] 
									initWithTitle:@"提交"
									style: UIBarButtonItemStyleBordered
									target: self
									action: @selector(submitAddfriend:)];
	self.navigationItem.rightBarButtonItem = submitButton;
    [super viewDidLoad];
}



- (void)submitAddfriend:(id)sender 
{
	//发送添加好友请求	
	CIMSocketLogicExt *cimSocketLogicExt = [CimGlobal getClass:@"CIMSocketLogicExt"];
	[cimSocketLogicExt sendRequestAddFriendMessage:friendId requestContent:requestContent.text];
	[Debuger systemAlert:@"验证信息发送成功"];
	[self.navigationController popViewControllerAnimated:YES];
}



@end
