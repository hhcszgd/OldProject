//
//  UITabBarDelegate.m
//  IOSCim
//
//  Created by apple apple on 11-6-10.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "UITabBarDelegate.h"
#import "Director.h"

@implementation UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController 
	shouldSelectViewController:(UIViewController *)viewController 
{
	if ([viewController isMemberOfClass:[UINavigationController class]]) 
	{
		UINavigationController *nav = (UINavigationController*)viewController;
		[Director markCurrentViewController:nav.topViewController];
	} 
	else 
	{
		[Director markCurrentViewController:viewController];
	}
	
	return YES;
}



- (void)tabBarController:(UITabBarController *)tabBarController 
 didSelectViewController:(UIViewController *)viewController 
{
	
}



- (void)tabBarController:(UITabBarController *)tabBarController 
willBeginCustomizingViewControllers:(NSArray *)viewControllers 
{
	
}



- (void)tabBarController:(UITabBarController *)tabBarController 
willEndCustomizingViewControllers:(NSArray *)viewControllers 
				 changed:(BOOL)changed 
{
}



- (void)tabBarController:(UITabBarController *)tabBarController 
didEndCustomizingViewControllers:(NSArray *)viewControllers 
				 changed:(BOOL)changed 
{
}

@end
