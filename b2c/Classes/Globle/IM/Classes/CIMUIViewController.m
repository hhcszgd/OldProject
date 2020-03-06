    //
//  CIMUIViewController.m
//  IOSCim
//
//  Created by apple apple on 11-8-25.
//  Copyright 2011 CIMForIOS. All rights reserved.
//  系统的UI控制器模板 包含网络状态提示 信息加载提示本系统特有的公共方法
//

#import "CIMUIViewController.h"
#import "MyNotificationCenter.h"
#import "CimGlobal.h"
#import "SystemVariable.h"


@implementation CIMUIViewController


- (void)initLoad  {
	
	[MyNotificationCenter addObserver:self 
							 selector:@selector(netDisConnectAlert:) 
								 name:SystemEventNetError 
						   obServerId:[NSString stringWithFormat:@"%@_netDisConnectAlert", [self description]]];
	
	
	[MyNotificationCenter addObserver:self
							 selector:@selector(netConnectSuccess:) 
								 name:SystemEventReConnectSucess
						   obServerId:[NSString stringWithFormat:@"%@_netConnectSuccess", [self description]]];
}



- (void)viewDidLoad  {
    [super viewDidLoad];
	[self initLoad];
}



//网络中断提示
- (void)netDisConnectAlert:(id)sender 
{
	UITabBarController *myTabBar = (UITabBarController *)[CimGlobal getClass:@"UITabBarController"];
	
	if (tipsLabel == nil) 
	{
		tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 20)]; 
		tipsLabel.textAlignment = UITextAlignmentCenter;
		tipsLabel.backgroundColor = [UIColor clearColor];
		[tipsLabel setTextColor:[UIColor redColor]];
		[myTabBar.view addSubview:tipsLabel];
        UIViewController *currentView = [UIApplication sharedApplication].keyWindow.rootViewController;
        //已经在主页则不需要重复添加
        if (![currentView isKindOfClass:[UITabBarController class]]) {
            [currentView.view addSubview:tipsLabel];
        }
	}
	
	tipsLabel.text = @"网络异常中断 正在尝试重新连接";										
}





//网络连接成功提示
- (void)netConnectSuccess:(id)sender 
{
	[tipsLabel removeFromSuperview];
} 



@end
