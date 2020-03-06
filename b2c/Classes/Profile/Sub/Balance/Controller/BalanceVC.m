//
//  BalanceVC.m
//  b2c
//
//  Created by wangyuanfei on 4/1/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BalanceVC.h"

@interface BalanceVC ()
/**图片*/
@property (nonatomic, strong) UIImageView *backImage;
/**余额*/
@property (nonatomic, strong) UILabel *balanceNumber;
@end

@implementation BalanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originURL = self.keyParamete[@"paramete"];
    
//    [self configmentNa];
//    [self configmentMainUI];
    
    // Do any additional setup after loading the view.
}
#pragma mark -- 定制导航栏
//- (void)configmentNa{
//    UILabel *rithtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
//    rithtLabel.userInteractionEnabled = YES;
//    [rithtLabel configmentfont:[UIFont boldSystemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"余额明细"];
//    UITapGestureRecognizer *balanceDetailTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(balanceDetailTap:)];
//    [rithtLabel addGestureRecognizer:balanceDetailTap];
//    self.navigationBarRightActionViews = @[rithtLabel];
//}
//#pragma mark --跳转到余额详情
//- (void)balanceDetailTap:(UITapGestureRecognizer *)balanceDetailTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"跳转到余额详情")
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"BalanceDetailVC"];
//}
//
//- (UIImageView *)backImage{
//    if (_backImage == nil) {
//        _backImage = [[UIImageView alloc] init];
//        [self.view addSubview:_backImage];
//    }
//    return _backImage;
//}
//
//- (UILabel *)balanceNumber{
//    if (_balanceNumber == nil) {
//        _balanceNumber = [[UILabel alloc] init];
//        [self.view addSubview:_balanceNumber];
//    }
//    return _balanceNumber;
//}
//
//
//
//#pragma mark -- 搭建主要UI
//- (void)configmentMainUI{
//    //布局图片
//    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(self.startY + 80);
//         make.width.equalTo(@(screenW/3.0 * 2.0));
//        make.height.equalTo(@(screenH/3.0));
//    }];
//    [self.backImage sd_setImageWithURL:[NSURL URLWithString:@"http://pic25.nipic.com/20121108/9252150_160744284000_2.jpg"] placeholderImage:[UIImage imageNamed:@"zhekouqu"]];
//    /**布局余额*/
//    [self.balanceNumber configmentfont:[UIFont boldSystemFontOfSize:20] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"$100.00"];
//    [self.balanceNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.backImage.mas_bottom).offset(10);
//        make.centerX.equalTo(self.view);
//    }];
//    [self.balanceNumber sizeToFit];
//    
//    //布局充值
//    UILabel *recharge = [[UILabel alloc] init];
//    [self.view addSubview:recharge];
//    [recharge mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
//        make.left.equalTo(self.view.mas_left).offset(10);
//        make.right.equalTo(self.view.mas_right).offset(-10);
//        make.height.equalTo(@(40));
//    }];
//    recharge.userInteractionEnabled = YES;
//    UITapGestureRecognizer *rechargeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rechargeTap:)];
//    [recharge addGestureRecognizer:rechargeTap];
//    [recharge configmentfont:[UIFont boldSystemFontOfSize:18] textColor:[UIColor whiteColor] backColor:[UIColor redColor] textAligement:1 cornerRadius:6 text:@"充值"];
//}
//
//#pragma mark -- 充值
//- (void)rechargeTap:(UITapGestureRecognizer *)rechargeTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"充值")
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}


@end
