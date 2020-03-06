//
//  MainTabBarVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "MainTabBarVC.h"
#import "MainTabBar.h"
#import "BaseNavigationVC.h"
#import "BaseVC.h"
#import "HomeVC.h"
#import "HomeNavigationVC.h"
#import "ClassifyVC.h"
#import "ClassifyNavigationVC.h"
//#import "LaoVC.h"
#import "TabBarLaoVC.h"
#import "LaoNavigationVC.h"
#import "ShopCarVC.h"
#import "ShopCarNavigationVC.h"
#import "ProfileVC.h"
#import "ProfileNavigationVC.h"
@interface MainTabBarVC ()<MainTabBarDelegate>

@end

@implementation MainTabBarVC


 - (void)viewDidLoad {
     [super viewDidLoad];
     UIImage *lineImage = [UIImage ImageWithColor:[[UIColor alloc]initWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0] frame:CGRectMake(0, 0, screenW, 1)];
     [self.tabBar setShadowImage:lineImage];
     [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
     [self addChildViewController: [self setSubVCWithNavigationVC:@"HomeNavigationVC" subVC:@"HomeVC"]];
    //     dispatch_sync(dispatch_get_global_queue(0, 0), ^{
         
         [self addChildViewController: [self setSubVCWithNavigationVC:@"ClassifyNavigationVC" subVC:@"ClassifyVC"]];
             [self addChildViewController: [self setSubVCWithNavigationVC:@"LaoNavigationVC" subVC:@"TabBarLaoVC"]];
             [self addChildViewController: [self setSubVCWithNavigationVC:@"ShopCarNavigationVC" subVC:@"ShopCarVC"]];
             [self addChildViewController: [self setSubVCWithNavigationVC:@"ProfileNavigationVC" subVC:@"ProfileVC"]];
             
             
    //     });

     [self setuptabBar];
 // Do any additional setup after loading the view.
 }


-(void)resetUI{//被挤掉以后调用一下
    
    for (UIViewController * vc  in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    
    [self setViewControllers:@[[self setSubVCWithNavigationVC:@"HomeNavigationVC" subVC:@"HomeVC"] , [self setSubVCWithNavigationVC:@"ClassifyNavigationVC" subVC:@"ClassifyVC"], [self setSubVCWithNavigationVC:@"LaoNavigationVC" subVC:@"TabBarLaoVC"],[self setSubVCWithNavigationVC:@"ShopCarNavigationVC" subVC:@"ShopCarVC"] , [self setSubVCWithNavigationVC:@"ProfileNavigationVC" subVC:@"ProfileVC"]]animated:YES];
    
//    self.selectedIndex = 0 ;
     [[MainTabBar shareMainTabBar] skipToTabbarItemWithIndex:0];
}


-(BaseNavigationVC*)setSubVCWithNavigationVC:(NSString*)navigationVC subVC:(NSString*)subVC {
    Class NavigationVCClass = NSClassFromString(navigationVC);
    Class SubVcClass = NSClassFromString(subVC);
    BaseNavigationVC *  destinationVC = [[NavigationVCClass alloc]initWithRootViewController:[[SubVcClass alloc]init]] ;
    return destinationVC;
}
//    [[NSNotificationCenter  defaultCenter] addObserver:self  selector:@selector(performNotifacationAction) name:@"PerformNotifacationActionAfterViewLoad" object:nil ];
//初始化自定义tabBar
- (void)setuptabBar
{
    
//    MainTabBar *tabBar = [[MainTabBar alloc] init];
        MainTabBar *tabBar = [MainTabBar shareMainTabBar];
    
    tabBar.frame = self.tabBar.bounds;
    //    tabBar.GDItems = self.tabBarArr;
    //    tabBar.GDItems = self.tabBar.subviews;
    tabBar.itemCount=self.childViewControllers.count;
    tabBar.mainTabBarDelegate = self;
    
    [self.tabBar addSubview:tabBar];
    [self.tabBar bringSubviewToFront:tabBar];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=YES;
    for (UIView *childView in self.tabBar.subviews) {
        
        if ([childView isKindOfClass:[MainTabBar class]] == NO) {
            
            [childView removeFromSuperview];
        }
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    for (UIView *childView in self.tabBar.subviews) {
        
        if ([childView isKindOfClass:[MainTabBar class]] == NO) {
            
            [childView removeFromSuperview];
        }
    }
    
    
}
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [child removeFromSuperview];
            
        }
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(MainTabBar *)tabBar didClickbtn:(NSInteger)index
{
    //把跳之前的导航控制器回归到根控制器
    UIViewController * current = [KeyVC shareKeyVC].rootViewController.selectedViewController ;
    [(BaseNavigationVC*)current popToRootViewControllerAnimated:NO];
    //selectedindex是系统自带的属性,只要将按钮的索引传给它,就能实现点击切换控制器了
    self.selectedIndex = index;
}

@end
