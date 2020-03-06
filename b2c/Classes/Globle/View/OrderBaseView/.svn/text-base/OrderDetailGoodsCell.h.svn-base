//
//  OrderDetailGoodsCell.h
//  b2c
//
//  Created by 0 on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


@class OrderDetailModel;
@protocol refundDelegate <NSObject>

- (void)refundModel:(OrderDetailModel *)orderDetailModel;

@end

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface OrderDetailGoodsCell : UITableViewCell

/**商品图片*/
@property (nonatomic, strong) UIImageView *goodImage;
/**商品介绍*/
@property (nonatomic, strong) UILabel *goodTitle;
/**价格*/
@property (nonatomic, strong) UILabel *priceLabel;
/**数量*/
@property (nonatomic, strong) UILabel *countLabel;
/**申请售后*/
@property (nonatomic, strong) UILabel *afterCostLabel;
/**申请售后的手势*/
@property (nonatomic, strong) UITapGestureRecognizer  *applicateACTap;
/**申请售后的手势*/
- (void)applicateACTap:(UITapGestureRecognizer *)applicateACTap;
/**申请退款，退货*/
@property (nonatomic, strong) UITapGestureRecognizer *refundReumTap;
/**申请退款，退货*/
- (void)refundReumTap:(UITapGestureRecognizer *)refundReumTap;

@property (nonatomic, strong) OrderDetailModel *orderTailModel;

/**退款的代理方法*/
@property (nonatomic, assign) id <refundDelegate>delegate;
/**用于分割效果的view*/
@property (nonatomic, strong) UIView *lineView;

@end
