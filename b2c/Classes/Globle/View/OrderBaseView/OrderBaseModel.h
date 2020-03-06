//
//  OrderBaseModel.h
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"
typedef enum {
    /**等待买家付款，付款，取消订单，朋友代付*/
    orderStatusWaitingForBuyerToPay = 0,
    /**买家已付款等待快递,延长收货，查看物流，确认收货*/
    orderStatusWaitingForDelivery,
    /**交易关闭显示删除订单*/
    orderStatusClose,
    /**交易成功显示评价，分享，再次购买*/
    orderStatusSuccessed,
    /**交易成功且评价之后再再次追评*/
    orderStatusChaseRatings,
    /**买家已付款，提醒卖家发货*/
    orderStatusRemindSellerShip,
    /**退款成功*/
    orderStatusRefundSuccess,
    /**正在退款中*/
    orderStatusInRefund
    
}orderStatus;
@interface OrderBaseModel : BaseModel
@property (nonatomic, assign) orderStatus orderState;
@end
