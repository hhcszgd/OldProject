//
//  MainTabBar.h
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBar ;

@protocol MainTabBarDelegate <NSObject>

//tabBarItem的点击,将索引传出去
- (void)tabBar:(MainTabBar *)tabBar didClickbtn:(NSInteger)index;
//正中间按钮的点击(预留)
//- (void)tabBarDidPulsBtnClick:(MainTabBar *)tabBar;

@end
@interface MainTabBar : UIView
/** 子控件个数由外面的控制器决定 */
@property (nonatomic, strong) NSArray *GDItems;
@property(nonatomic,assign)NSInteger  itemCount ;
@property (nonatomic, weak) id <MainTabBarDelegate> mainTabBarDelegate;

+(instancetype)shareMainTabBar;
-(void)skipToTabbarItemWithIndex:(NSInteger)index ;
@end
