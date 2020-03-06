//
//  MainViewController.h
//  IOSCim
//
//  Created by fei lan on 14-9-24.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommViewController.h"
#import "UINavigationDelegate.h"

@interface MainViewController : CommViewController {
    UINavigationDelegate *navDelegate;
    UIViewController *tempViewController;
}

@end
