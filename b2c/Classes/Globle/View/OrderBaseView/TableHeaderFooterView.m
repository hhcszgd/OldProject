//
//  TableHeaderFooterView.m
//  b2c
//
//  Created by 0 on 16/4/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "TableHeaderFooterView.h"

@implementation TableHeaderFooterView
- (NSArray *)gesDataArr{
    if (_gesDataArr == nil) {
        _gesDataArr = [[NSArray alloc] init];
        _gesDataArr = @[self.deleteOrderTap, self.delayedReceiptTap, self.cancleOrderTap,self.friendPayTap, self.payTap, self.seeLogisticsTap, self.tureReceiptTap,self.buyAgainTap,self.sharTap,self.evaluateTap, self.remindSellTap, self.chaseRatingsTap];
    }
    return _gesDataArr;
}


- (UIImageView *)logoImage{
    if (_logoImage == nil) {
        _logoImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_logoImage];
    }
    return _logoImage;
}
- (UILabel *)storeNameLabel{
    if (_storeNameLabel == nil) {
        _storeNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_storeNameLabel];
    }
    return _storeNameLabel;
}
- (UIImageView *)arrowImage{
    if (_arrowImage == nil) {
        _arrowImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_arrowImage];
    }
    return _arrowImage;
}
- (UILabel *)stateLabel{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)totalCountLabel{
    if (_totalCountLabel == nil) {
        _totalCountLabel = [[UILabel alloc] init];
        
    }
    return _totalCountLabel;
}

- (UILabel *)totalPriceLabel{
    if (_totalPriceLabel == nil) {
        _totalPriceLabel = [[UILabel alloc] init];
        
    }
    return _totalPriceLabel;
}
- (UILabel *)freghtLabel{
    if (_freghtLabel == nil) {
        _freghtLabel = [[UILabel alloc] init];
        
    }
    return _freghtLabel;
}
- (UILabel *)rightFirstLabel{
    if (_rightFirstLabel == nil) {
        _rightFirstLabel = [[UILabel alloc] init];
        _rightFirstLabel.userInteractionEnabled = YES;
    }
    return _rightFirstLabel;
}
- (UILabel *)rightSecondLabel{
    if (_rightSecondLabel == nil) {
        _rightSecondLabel = [[UILabel alloc] init];
        _rightSecondLabel.userInteractionEnabled = YES;
    }
    return _rightSecondLabel;
}
- (UILabel *)rightThirdLabel{
    if (_rightThirdLabel == nil) {
        _rightThirdLabel = [[UILabel alloc] init];
        _rightThirdLabel.userInteractionEnabled = YES;
    }
    return _rightThirdLabel;
}
- (UITapGestureRecognizer *)seeLogisticsTap{
    if (_seeLogisticsTap == nil) {
        _seeLogisticsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeLogisticsTap:)];
    }
    return _seeLogisticsTap;
}

- (UITapGestureRecognizer  *)cancleOrderTap{
    if (_cancleOrderTap == nil) {
        _cancleOrderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleOrderTap:)];
        
    }
    return _cancleOrderTap;
}
- (UITapGestureRecognizer *)deleteOrderTap{
    if (_deleteOrderTap == nil) {
        _deleteOrderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteOrderTap:)];
        
    }
    return _deleteOrderTap;
}

- (UITapGestureRecognizer *)friendPayTap{
    if (_friendPayTap == nil) {
        _friendPayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendPayTap:)];
        
    }
    return _friendPayTap;
}

- (UITapGestureRecognizer *)delayedReceiptTap{
    if (_delayedReceiptTap == nil) {
        _delayedReceiptTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delayedReceiptTap:)];
        
    }
    return _delayedReceiptTap;
}


- (UITapGestureRecognizer *)payTap{
    if (_payTap == nil) {
        _payTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payTap:)];
        
    }
    return _payTap;
}
- (UITapGestureRecognizer *)chaseRatingsTap{
    if (_chaseRatingsTap == nil) {
        _chaseRatingsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chaseRatingsTap:)];
        
    }
    return _chaseRatingsTap;
}
- (UITapGestureRecognizer *)remindSellTap{
    if (_remindSellTap == nil) {
        _remindSellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remindSellTap:)];
        
    }
    return _remindSellTap;
}
- (UITapGestureRecognizer *)evaluateTap{
    if (_evaluateTap == nil) {
        _evaluateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(evaluateTap:)];
        
    }
    return _evaluateTap;
}
- (UITapGestureRecognizer *)sharTap{
    if (_sharTap == nil) {
        _sharTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sharTap:)];
        
    }
    return _sharTap;
}
- (UITapGestureRecognizer *)buyAgainTap{
    if (_buyAgainTap == nil) {
        _buyAgainTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buyAgainTap:)];
        
    }
    return _buyAgainTap;
}
- (UITapGestureRecognizer *)tureReceiptTap{
    if (_tureReceiptTap == nil) {
        _tureReceiptTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tureReceiptTap:)];
    }
    return _tureReceiptTap;
}












- (void)setOrderModel:(OrderBaseModel *)orderModel{
    _orderModel = orderModel;
    [self removeGesture:self.gesDataArr];
    switch (orderModel.orderState) {
        case orderStatusClose:
        {
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"交易关闭"];
            self.rightSecondLabel.hidden = YES;
            self.rightThirdLabel.hidden = YES;
            self.rightFirstLabel.hidden = NO;
            
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"删除订单"];
            self.rightFirstLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.deleteOrderTap];
            
            
            
        }
            break;
        case orderStatusSuccessed:
        {
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"交易成功"];
            
            self.rightFirstLabel.hidden = NO;
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"再次购买"];
            self.rightFirstLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.buyAgainTap];
            
            
            //
            self.rightSecondLabel.hidden = NO;
            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"评价"];
            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightSecondLabel.layer.borderWidth = 1;
            [self.rightSecondLabel addGestureRecognizer:self.evaluateTap];
            //
            self.rightThirdLabel.hidden = NO;
            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"分享"];
            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightThirdLabel.layer.borderWidth = 1;
            [self.rightThirdLabel addGestureRecognizer:self.sharTap];
            
        }
            break;
        case orderStatusWaitingForBuyerToPay:
        {
            
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"等待付款"];
            
            
            
            self.rightFirstLabel.hidden = NO;
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"去支付"];
            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.payTap];
            //
            self.rightSecondLabel.hidden = YES;
            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"取消订单"];
            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightSecondLabel.layer.borderWidth = 1;
            [self.rightSecondLabel addGestureRecognizer:self.cancleOrderTap];
            //
            self.rightThirdLabel.hidden = YES;
            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"朋友代付"];
            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightThirdLabel.layer.borderWidth = 1;
            [self.rightThirdLabel addGestureRecognizer:self.friendPayTap];
        }
            break;
        case orderStatusWaitingForDelivery:
        {
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"卖家已发货"];
            
            
            
            self.rightFirstLabel.hidden = NO;
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"确认收货"];
            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.tureReceiptTap];
            //
            self.rightSecondLabel.hidden = NO;
            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"查看物流"];
            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightSecondLabel.layer.borderWidth = 1;
            [self.rightSecondLabel addGestureRecognizer:self.seeLogisticsTap];
            //
            self.rightThirdLabel.hidden = NO;
            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"延迟收货"];
            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightThirdLabel.layer.borderWidth = 1;
            [self.rightThirdLabel addGestureRecognizer:self.delayedReceiptTap];
        }
            break;
        case orderStatusChaseRatings:
        {
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"交易成功"];
            
            
            self.rightFirstLabel.hidden = NO;
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"追加评价"];
            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.chaseRatingsTap];
            
            //
            self.rightSecondLabel.hidden = NO;
            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"删除订单"];
            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightSecondLabel.layer.borderWidth = 1;
            [self.rightSecondLabel addGestureRecognizer:self.deleteOrderTap];
            //
            self.rightThirdLabel.hidden = YES;
            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightThirdLabel.layer.borderWidth = 1;
        }
            break;
        case orderStatusRemindSellerShip:
        {
            
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"提醒卖家发货"];
            
            
            
            self.rightFirstLabel.hidden = NO;
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"提醒发货"];
            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.remindSellTap];
            //
            self.rightSecondLabel.hidden = YES;
            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightSecondLabel.layer.borderWidth = 1;
            //
            self.rightThirdLabel.hidden = YES;
            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightThirdLabel.layer.borderWidth = 1;
        }
            break;
        case orderStatusRefundSuccess:
        {
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"退货成功"];
            
            
            
            self.rightFirstLabel.hidden = NO;
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"找相似"];
            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.findSimilarTap];
            //
            self.rightSecondLabel.hidden = YES;
            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightSecondLabel.layer.borderWidth = 1;
            //
            self.rightThirdLabel.hidden = YES;
            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightThirdLabel.layer.borderWidth = 1;
        }
            break;
        case orderStatusInRefund:
        {
            [self.stateLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"退货成功"];
            
            
            
            self.rightFirstLabel.hidden = NO;
            [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
            self.rightFirstLabel.layer.borderWidth = 1;
            [self.rightFirstLabel addGestureRecognizer:self.refundTap];
            //
            self.rightSecondLabel.hidden = YES;
            [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightSecondLabel.layer.borderWidth = 1;
            //
            self.rightThirdLabel.hidden = YES;
            [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@""];
            self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            self.rightThirdLabel.layer.borderWidth = 1;
        }
            break;
        default:
            break;
    }

    
}


- (void)deleteOrderTap:(UITapGestureRecognizer *)deleteOrderTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"删除订单")
    if ([self.delegate respondsToSelector:@selector(deleteOrder:section:)]) {
        [self.delegate performSelector:@selector(deleteOrder:section:) withObject:_orderModel withObject:@(_section)];
    }
}
- (void)buyAgainTap:(UITapGestureRecognizer *)buyAgainTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"再次购买")
}
- (void)delayedReceiptTap:(UITapGestureRecognizer *)delayedReceiptTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"延迟收货")
}
- (void)cancleOrderTap:(UITapGestureRecognizer *)cancleOrderTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"取消订单")
    _orderModel.orderState = orderStatusClose;
    [_superView reloadData];


}
- (void)friendPayTap:(UITapGestureRecognizer *)friendPayTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"朋友代付")
}
- (void)payTap:(UITapGestureRecognizer *)payTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"付款")
}
- (void)seeLogisticsTap:(UITapGestureRecognizer *)seeLogisticsTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"c好看物流")
}
- (void)tureReceiptTap:(UITapGestureRecognizer *)tureReceiptTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"确认收货")
}
- (void)evaluateTap:(UITapGestureRecognizer *)evaluateTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"评价")
}
- (void)sharTap:(UITapGestureRecognizer *)sharTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"分享")
}
- (void)remindSellTap:(UITapGestureRecognizer *)remindSellTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"提醒卖家")
}
- (void)chaseRatingsTap:(UITapGestureRecognizer *)chaseRatingsTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"追评")
}
- (void)findSimilarTap:(UITapGestureRecognizer *)findSimilarTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"找相似")
}
- (void)refundTap:(UITapGestureRecognizer *)refundTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"退款中")
}


- (void)setSection:(NSInteger)section{
    _section = section;

}
- (void)setSuperView:(UITableView *)superView{
    _superView = superView;
}




- (void)removeGesture:(NSArray *)array{
    for (NSInteger i = 0; i < _gesDataArr.count; i++) {
        UITapGestureRecognizer *tap = _gesDataArr[i];
        [self.rightFirstLabel removeGestureRecognizer:tap];
        [self.rightSecondLabel removeGestureRecognizer:tap];
        [self.rightThirdLabel removeGestureRecognizer:tap];
    }
}


@end
