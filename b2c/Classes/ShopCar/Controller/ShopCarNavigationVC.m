//
//  ShopCarNavigationVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ShopCarNavigationVC.h"
#import "b2c-Swift.h"

@interface ShopCarNavigationVC ()

@end

@implementation ShopCarNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.image = [UIImage imageNamed:@"icon_shopping"];
    self.tabBarItem.selectedImage = [UIImage imageNamed: @"icon_selected_shopping"];
    self.tabBarItem.title  = [GDLanguageManager titleByKeyWithKey:@"tabBar_shopcar"];// GDLanguageManager.titleByKey(key: LTabBar_home) //gotTitleStr(key: "tabBar_home")
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
