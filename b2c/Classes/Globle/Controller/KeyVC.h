//
//  KeyVC.h
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
 keyWindow的根控制器
 */

#import <UIKit/UIKit.h>
#import "MainTabBarVC.h"
@interface KeyVC : UINavigationController
+(instancetype)shareKeyVC;
-(void)skipToTabbarItemWithIndex:(NSInteger)index ;
@property(nonatomic,strong)MainTabBarVC * rootViewController ;
-(void)resetUI;//被挤掉以后调用一下
@end
