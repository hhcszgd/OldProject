//
//  TOTableFooter.m
//  b2c
//
//  Created by 0 on 16/4/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "TOTableFooter.h"
@interface TOTableFooter()
//@property (nonatomic, strong) NSArray *gesDataArr;

@end
@implementation TOTableFooter


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
//        _gesDataArr = @[self.deleteOrderTap, self.delayedReceiptTap, self.cancleOrderTap,self.friendPayTap, self.payTap, self.seeLogisticsTap, self.tureReceiptTap,self.buyAgainTap,self.sharTap,self.evaluateTap, self.remindSellTap, self.chaseRatingsTap];
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIView *shangView = [[UIView alloc] init];
        [self.contentView addSubview:shangView];
        UIView *xiaView = [[UIView alloc] init];
        [self.contentView addSubview:xiaView];
        [shangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(82));
        }];
        [xiaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shangView.mas_bottom).offset(0);
            make.left.bottom.right.equalTo(self);
            
        }];
        xiaView.backgroundColor = BackgroundGray;
        //上部的view
        UIView *topView = [[UIView alloc] init];
        [shangView addSubview:topView];
        
        topView.backgroundColor = [UIColor whiteColor];
        
        //间隔线
        UIView *lineView = [[UIView alloc] init];
        [shangView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(shangView);
            make.left.right.equalTo(shangView);
            make.height.equalTo(@(2));
        }];
        lineView.backgroundColor = BackgroundGray;
        //下部的view
        UIView *bottomView =[[UIView alloc] init];
        [shangView addSubview:bottomView];
        bottomView.backgroundColor = [UIColor whiteColor];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(0);
            make.left.right.bottom.equalTo(shangView);
        }];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(shangView);
            make.bottom.equalTo(lineView.mas_top).offset(0);
        }];
        
        //背景色
        self.backgroundColor = [UIColor whiteColor];
        //布局运费
        [topView addSubview:self.freghtLabel];
        [self.freghtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(topView.mas_right).offset(-10);
        }];
        [self.freghtLabel sizeToFit];
        //布局价格
        [topView addSubview:self.totalPriceLabel];
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(self.freghtLabel.mas_left).offset(-5);
        }];
        [self.totalPriceLabel sizeToFit];
        //布局总数量
        [topView addSubview:self.totalCountLabel];
        [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(self.totalPriceLabel.mas_left).offset(-5);
        }];
        [self.totalCountLabel sizeToFit];
        
        //布局第一个label
        [bottomView addSubview:self.rightFirstLabel];
        [self.rightFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bottomView.mas_right).offset(-10);
            make.centerY.equalTo(bottomView);
            make.height.equalTo(@(27));
            make.width.equalTo(@(75 *SCALE));
        }];
        
        //布局第二个label
        [bottomView addSubview:self.rightSecondLabel];
        [self.rightSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightFirstLabel.mas_left).offset(-10);
            make.centerY.equalTo(bottomView);
            make.height.equalTo(@(27));
            make.width.equalTo(@(75 *SCALE));
            
        }];
        
        //布局第三个label
        [bottomView addSubview:self.rightThirdLabel];
        [self.rightThirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightSecondLabel.mas_left).offset(-10);
            make.centerY.equalTo(bottomView);
            make.height.equalTo(@(27));
            make.width.equalTo(@(75 *SCALE));
        }];
        
#pragma mark 假数据
        [self.totalCountLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"共%@件商品 合计:",@"1"]];
        [self.totalPriceLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"$233.00"];
        [self.freghtLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"(含运费%@)",@"￥12.00"]];
        
        self.rightThirdLabel.layer.borderWidth = 1;
    }
    return self;
}

//- (void)setOrderStatus:(orderStatus)orderStatus{
//    _orderStatus = orderStatus;
//    [self removeGesture:_gesDataArr];
//    switch (orderStatus) {
//        case orderStatusClose:
//        {
//            
//            self.rightSecondLabel.hidden = YES;
//            self.rightThirdLabel.hidden = YES;
//            self.rightFirstLabel.hidden = NO;
//            
//            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"删除订单"];
//            self.rightFirstLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightFirstLabel.layer.borderWidth = 1;
//            [self.rightFirstLabel addGestureRecognizer:self.deleteOrderTap];
//            
//            
//            
//        }
//            break;
//        case orderStatusSuccessed:
//        {
//            self.rightFirstLabel.hidden = NO;
//            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"再次购买"];
//            self.rightFirstLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightFirstLabel.layer.borderWidth = 1;
//            [self.rightFirstLabel addGestureRecognizer:self.buyAgainTap];
//            
//            
//            //
//            self.rightSecondLabel.hidden = NO;
//            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"评价"];
//            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightSecondLabel.layer.borderWidth = 1;
//            [self.rightSecondLabel addGestureRecognizer:self.evaluateTap];
//            //
//            self.rightThirdLabel.hidden = NO;
//            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"分享"];
//            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightThirdLabel.layer.borderWidth = 1;
//            [self.rightThirdLabel addGestureRecognizer:self.sharTap];
//            
//        }
//            break;
//        case orderStatusWaitingForBuyerToPay:
//        {
//            self.rightFirstLabel.hidden = NO;
//            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"付款"];
//            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
//            self.rightFirstLabel.layer.borderWidth = 1;
//            [self.rightFirstLabel addGestureRecognizer:self.payTap];
//            //
//            self.rightSecondLabel.hidden = NO;
//            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"取消订单"];
//            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightSecondLabel.layer.borderWidth = 1;
//            [self.rightSecondLabel addGestureRecognizer:self.cancleOrderTap];
//            //
//            self.rightThirdLabel.hidden = NO;
//            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"朋友代付"];
//            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightThirdLabel.layer.borderWidth = 1;
//            [self.rightThirdLabel addGestureRecognizer:self.friendPayTap];
//        }
//            break;
//        case orderStatusWaitingForDelivery:
//        {
//            self.rightFirstLabel.hidden = NO;
//            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"确认收货"];
//            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
//            self.rightFirstLabel.layer.borderWidth = 1;
//            [self.rightFirstLabel addGestureRecognizer:self.tureReceiptTap];
//            //
//            self.rightSecondLabel.hidden = NO;
//            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"查看物流"];
//            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightSecondLabel.layer.borderWidth = 1;
//            [self.rightSecondLabel addGestureRecognizer:self.seeLogisticsTap];
//            //
//            self.rightThirdLabel.hidden = NO;
//            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"延迟收货"];
//            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightThirdLabel.layer.borderWidth = 1;
//            [self.rightThirdLabel addGestureRecognizer:self.delayedReceiptTap];
//        }
//            break;
//        case orderStatusChaseRatings:
//        {
//            self.rightFirstLabel.hidden = NO;
//            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"追评"];
//            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
//            self.rightFirstLabel.layer.borderWidth = 1;
//            [self.rightFirstLabel addGestureRecognizer:self.chaseRatingsTap];
//            
//            //
//            self.rightSecondLabel.hidden = NO;
//            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"分享"];
//            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightSecondLabel.layer.borderWidth = 1;
//            [self.rightSecondLabel addGestureRecognizer:self.sharTap];
//            //
//            self.rightThirdLabel.hidden = YES;
//            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
//            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightThirdLabel.layer.borderWidth = 1;
//        }
//            break;
//        case orderStatusRemindSellerShip:
//        {
//            self.rightFirstLabel.hidden = NO;
//            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"提醒卖家"];
//            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
//            self.rightFirstLabel.layer.borderWidth = 1;
//            [self.rightFirstLabel addGestureRecognizer:self.remindSellTap];
//            //
//            self.rightSecondLabel.hidden = YES;
//            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
//            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightSecondLabel.layer.borderWidth = 1;
//            //
//            self.rightThirdLabel.hidden = YES;
//            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
//            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            self.rightThirdLabel.layer.borderWidth = 1;
//        }
//            break;
//        default:
//            break;
//    }
//    
//}
//- (void)removeGesture:(NSArray *)array{
//    for (NSInteger i = 0; i < _gesDataArr.count; i++) {
//        UITapGestureRecognizer *tap = _gesDataArr[i];
//        [self.rightFirstLabel removeGestureRecognizer:tap];
//        [self.rightSecondLabel removeGestureRecognizer:tap];
//        [self.rightThirdLabel removeGestureRecognizer:tap];
//    }
//}


//- (void)deleteOrderTap:(UITapGestureRecognizer *)deleteOrderTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"删除订单")
//    if ([self.delegate respondsToSelector:@selector(deleteOrder:section:)]) {
//        [self.delegate performSelector:@selector(deleteOrder:section:) withObject:_model withObject:@(_section)];
//    }
//}
//- (void)buyAgainTap:(UITapGestureRecognizer *)buyAgainTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"再次购买")
//}
//- (void)delayedReceiptTap:(UITapGestureRecognizer *)delayedReceiptTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"延迟收货")
//}
//- (void)cancleOrderTap:(UITapGestureRecognizer *)cancleOrderTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"取消订单")
//    _model.orderState = orderStatusClose;
//    [_superView reloadData];
//    
//    
//}
//- (void)friendPayTap:(UITapGestureRecognizer *)friendPayTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"朋友代付")
//}
//- (void)payTap:(UITapGestureRecognizer *)payTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"付款")
//}
//- (void)seeLogisticsTap:(UITapGestureRecognizer *)seeLogisticsTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"c好看物流")
//}
//- (void)tureReceiptTap:(UITapGestureRecognizer *)tureReceiptTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"确认收货")
//}
//- (void)evaluateTap:(UITapGestureRecognizer *)evaluateTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"评价")
//}
//- (void)sharTap:(UITapGestureRecognizer *)sharTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"分享")
//}
//- (void)remindSellTap:(UITapGestureRecognizer *)remindSellTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"提醒卖家")
//}
//- (void)chaseRatingsTap:(UITapGestureRecognizer *)chaseRatingsTap{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"追评")
//}
//
//- (void)setModel:(TotalOrderModel *)model{
//    _model = model;
//}
//- (void)setSection:(NSInteger)section{
//    _section = section;
//   
//}
//- (void)setSuperView:(UITableView *)superView{
//    _superView = superView;
//}




@end
