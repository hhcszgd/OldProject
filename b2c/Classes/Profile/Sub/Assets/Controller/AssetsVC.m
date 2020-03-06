//
//  AssetsVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AssetsVC.h"
#import "AssetsView.h"
@interface AssetsVC ()

@end

@implementation AssetsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.originURL = self.keyParamete[@"paramete"];
    
//    self.view.backgroundColor = BackgroundGray;
//    [self configmentTableView];
    // Do any additional setup after loading the view.
}

//- (void)configmentTableView{
//    AssetsView *balance = [[AssetsView alloc] initWithFrame:CGRectMake(0, self.startY + 20, screenW, 80 *SCALE)];
//    [self.view addSubview:balance];
//    balance.leftTitle = @"余额";
//    balance.TitleImage = [UIImage imageNamed:@"bg_Direct selling"];
//    balance.rightImage = [UIImage imageNamed:@"icon_balance"];
//    UITapGestureRecognizer *balanceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(balanceTap:)];
//    [balance addGestureRecognizer:balanceTap];
//   
//    
//    
//    
//    
//    //布局优惠券
//    AssetsView *coupon = [[AssetsView alloc] initWithFrame:CGRectMake(0, balance.frame.origin.y + balance.frame.size.height  + 10, screenW, 80 *SCALE)];
//    [self.view addSubview:coupon];
//    coupon.leftTitle = @"优惠券";
//    coupon.TitleImage = [UIImage imageNamed:@"bg_Direct selling"];
//    coupon.rightImage = [UIImage imageNamed:@"icon_balance"];
//    UITapGestureRecognizer *couponTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponTap:)];
//    [coupon addGestureRecognizer:couponTap];
//    
//    
//    //布局LB
//    AssetsView *lB = [[AssetsView alloc] initWithFrame:CGRectMake(0, coupon.frame.origin.y +10 + coupon.frame.size.height , screenW, 80 *SCALE)];
//    [self.view addSubview:lB];
//    lB.leftTitle = @"L币";
//    lB.TitleImage = [UIImage imageNamed:@"bg_Direct selling"];
//    lB.rightImage = [UIImage imageNamed:@"icon_balance"];
//    UITapGestureRecognizer *lBTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lBTap:)];
//    [lB addGestureRecognizer:lBTap];
//    
//}
//#pragma mark -- 跳转到余额页面
//- (void)balanceTap:(UITapGestureRecognizer *)balanceTap{
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"BalanceVC"];
//}
//#pragma mark --  跳转到优惠券页面
//- (void)couponTap:(UITapGestureRecognizer *)couponTap{
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"CouponVC"];
//}
//#pragma mark -- 跳转到lb页面
//- (void)lBTap:(UITapGestureRecognizer *)lBTap{
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"LBiVC"];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.networkingStatus)
//}
@end
