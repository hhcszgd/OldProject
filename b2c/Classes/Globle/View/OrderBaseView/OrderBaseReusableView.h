//
//  OrderBaseReusableView.h
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
@class OrderBaseModel;
@protocol editOrderDelegate <NSObject>
/**删除订单*/
- (void)deleteOrder:(OrderBaseModel *)model section:(id)section;
/**点击取消订单，订单状态变成交易关闭,并且显示*/

@end
#import <UIKit/UIKit.h>
#import "OrderBaseModel.h"
@interface OrderBaseReusableView : UICollectionReusableView

/**订单状态*/
@property (nonatomic, assign) orderStatus orderStatus;
/**订单Model*/
@property (nonatomic, strong) OrderBaseModel *orderModel;

@property (nonatomic, strong) NSArray *gesDataArr;
@property (nonatomic, strong) UICollectionView *superView;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id <editOrderDelegate>delegate;




/**店铺图标*/
@property (nonatomic, strong) UIImageView *logoImage;
/**店铺名称*/
@property (nonatomic, strong) UILabel *storeNameLabel;
/**指示箭头*/
@property (nonatomic, strong) UIImageView *arrowImage;
/**卖家，买家的状态*/
@property (nonatomic, strong) UILabel *stateLabel;

/**总共数量，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UILabel *totalCountLabel;
/**合计价格，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UILabel *totalPriceLabel;
/**运费，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UILabel *freghtLabel;
/**从右边开始第一个label，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UILabel *rightFirstLabel;
/**从右边开始第二个label，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UILabel *rightSecondLabel;
/**从右边开始第三个个label，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UILabel *rightThirdLabel;
/**朋友代付Tap，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *friendPayTap;
/**取消订单Tap，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *cancleOrderTap;
/**付款Tap，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *payTap;
/**查看物流Tap，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *seeLogisticsTap;
/**确认收货Tap，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *tureReceiptTap;
/**删除订单，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *deleteOrderTap;
/**延迟收货，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *delayedReceiptTap;
/**分享，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *sharTap;
/**评价，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *evaluateTap;
/**提醒卖家，组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *remindSellTap;
/**追评组尾懒加载中没有添加到父视图上*/
@property (nonatomic, strong) UITapGestureRecognizer *chaseRatingsTap;
/**再次购买*/
@property (nonatomic, strong) UITapGestureRecognizer *buyAgainTap;
/**退款中Tap*/
@property (nonatomic, strong) UITapGestureRecognizer *refundTap;
/**找相似Tap*/
@property (nonatomic, strong) UITapGestureRecognizer *findSimilarTap;


/**退款中*/
//- (void)refundTap:(UITapGestureRecognizer *)refundTap;
/**找相似*/
//- (void)findSimilarTap:(UITapGestureRecognizer *)findSimilarTap;

/**退款中*/
- (void)refundTap:(UITapGestureRecognizer *)refundTap;
/**找相似*/
- (void)findSimilarTap:(UITapGestureRecognizer *)findSimilarTap;




/**再次购买*/
- (void)buyAgainTap:(UITapGestureRecognizer *)buyAgainTap;
/**追评*/
- (void)chaseRatingsTap:(UITapGestureRecognizer *)chaseRatingsTap;
/**提醒卖家*/
- (void)remindSellTap:(UITapGestureRecognizer *)remindSellTap;
/**评价*/
- (void)evaluateTap:(UITapGestureRecognizer *)evaluateTap;
/**分享*/
- (void)sharTap:(UITapGestureRecognizer *)sharTap;
/**确认收货*/
- (void)tureReceiptTap:(UITapGestureRecognizer *)tureReceiptTap;
/**延迟收货*/
- (void)delayedReceiptTap:(UITapGestureRecognizer *)delayedReceiptTap;
/**朋友代付*/
- (void)friendPayTap:(UITapGestureRecognizer *)friendPayTap;
/**查看物流*/
- (void)seeLogisticsTap:(UITapGestureRecognizer *)seeLogisticsTap;
/**取消订单*/
- (void)cancleOrderTap:(UITapGestureRecognizer *)cancleOrderTap;
/**删除订单*/
- (void)deleteOrderTap:(UITapGestureRecognizer *)deleteOrderTap;
/**付款*/
- (void)payTap:(UITapGestureRecognizer *)payTap;
@end
