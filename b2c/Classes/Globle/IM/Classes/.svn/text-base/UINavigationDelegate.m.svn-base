//
//  UINavigationDelegate.m
//  IOSCim
//
//  Created by apple apple on 11-6-10.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "UINavigationDelegate.h"
#import "Director.h"

@implementation UINavigationDelegate

- (void)navigationController:(UINavigationController *)navigationController 
	  willShowViewController:(UIViewController *)viewController 
					animated:(BOOL)animated 
{
	//记录当前显示的视图控制器描述
	[Director markCurrentViewController:viewController];
}



- (void)navigationController:(UINavigationController *)navigationController 
	   didShowViewController:(UIViewController *)viewController 
					animated:(BOOL)animated 
{
	
}
@end
