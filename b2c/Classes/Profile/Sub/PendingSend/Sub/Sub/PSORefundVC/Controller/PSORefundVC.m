//
//  PSORefundVC.m
//  b2c
//
//  Created by 0 on 16/4/15.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PSORefundVC.h"
#import "RefundReturnView.h"
#import "SelectRefundReturnVC.h"
@interface PSORefundVC ()

@end

@implementation PSORefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTitle = @"选择退货款";
    self.view.backgroundColor = BackgroundGray;
    [self configmentAction];
    // Do any additional setup after loading the view.
}
- (void)configmentAction{
    RefundReturnView *refundReturn = [[RefundReturnView alloc] initWithFrame:CGRectMake(0, self.startY + 10, screenW, 80)];
    [self.view addSubview:refundReturn];
    refundReturn.leftImageView.image = [UIImage imageNamed:@"bg_coupon"];
    refundReturn.titleLabel.text = @"退货退款";
    refundReturn.detailLabel.text = @"已收到货，需要退还已收到的货物";
    [refundReturn addTarget:self action:@selector(refundReturn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    RefundReturnView *onlyReturn = [[RefundReturnView alloc] initWithFrame:CGRectMake(0, refundReturn.frame.origin.y + refundReturn.frame.size.height + 10, screenW, 80)];
    [self.view addSubview:onlyReturn];
    onlyReturn.leftImageView.image = [UIImage imageNamed:@"bg_collocation"];
    onlyReturn.titleLabel.text = @"仅退款";
    onlyReturn.detailLabel.text = @"未收到货，或与卖家协商同意前提下申请";
    [onlyReturn addTarget:self action:@selector(onlyReturn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//退货退款
- (void)refundReturn:(RefundReturnView *)refundReturn{
    _orderDetailModel.refundState = refundStateRefundReturn;
   
    SelectRefundReturnVC *selectRRVC = [[SelectRefundReturnVC alloc] initWithModel:_orderDetailModel];
    
    [self.navigationController pushViewController:selectRRVC animated:YES];
}

/**仅退款*/
- (void)onlyReturn:(RefundReturnView *)onlyReturn{
    _orderDetailModel.refundState = refundStateOnlyRefund;
    
    SelectRefundReturnVC *selectRRVC = [[SelectRefundReturnVC alloc] initWithModel:_orderDetailModel];
    
    [self.navigationController pushViewController:selectRRVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
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
