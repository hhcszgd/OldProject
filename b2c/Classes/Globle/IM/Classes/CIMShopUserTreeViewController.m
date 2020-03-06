//
//  CIMShopUserTreeViewController.m
//  IOSCim
//
//  Created by apple apple on 11-8-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMShopUserTreeViewController.h"
#import "ShopUserNavigation.h"
#import "CimGlobal.h"


@implementation CIMShopUserTreeViewController


//加载完成回调
- (void)viewDidLoad 
{
	cimUserListDataStruct = [CimGlobal getClass:@"CIMShopListDataStruct"];
	windowTitle = @"团队";
	className = @"CIMShopUserTreeViewController";
	lookInfoSelector = @selector(lookShopUserInfo:);
	[self loadInit];
}



//跳转到查看企业用户详细信息窗口
- (void)lookShopUserInfo:(UIButton*)sender 
{
	ShopUserNavigation *shopUserNavigation = [ShopUserNavigation alloc];
	shopUserNavigation.optUserId = [sender titleForState:UIControlStateNormal];
	[self.navigationController pushViewController:shopUserNavigation animated:YES];
}


@end
