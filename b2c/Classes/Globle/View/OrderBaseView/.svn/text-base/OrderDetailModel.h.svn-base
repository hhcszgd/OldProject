//
//  OrderDetailModel.h
//  b2c
//
//  Created by 0 on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//





#import "OrderBaseModel.h"
typedef enum {
    /**退款退货*/
    refundStateRefundReturn = 0,
    /**只是退款*/
    refundStateOnlyRefund
}refundState;
@interface OrderDetailModel : OrderBaseModel
/**选择退款方式*/
@property (nonatomic, assign) refundState refundState;

/**不同订单状态下背景图片的url*/
@property (nonatomic, copy) NSString *backGroundImageStr;
/**不买的原因,（还剩多少时间自动确认收货）*/
@property (nonatomic, copy) NSString *reasonStr;


/**收货人*/
@property (nonatomic, copy) NSString *receiptName;
/**收货人电话*/
@property (nonatomic, copy) NSString *receiptPhone;
/**收货人地址*/
@property (nonatomic, copy) NSString *receiptAddress;
/**地位小图标*/
@property (nonatomic, copy) NSString *locationImage;

/**店铺名*/
@property (nonatomic, copy) NSString *storeName;
/**店铺logo*/
@property (nonatomic, copy) NSString *storeLogoImage;

/**商品图片*/
@property (nonatomic, copy) NSString *goodImage;
/**商品介绍*/
@property (nonatomic, copy) NSString *goodTitle;
/**价格*/
@property (nonatomic, copy) NSString *priceLabel;
/**数量*/
@property (nonatomic, copy) NSString *countLabel;
/**申请售后*/
@property (nonatomic, copy) NSString *afterCostLabel;
/**运费*/
@property (nonatomic, copy) NSString *freightLabel;
/**实付款*/
@property (nonatomic, copy) NSString *realPaymentLabel;

/**联系卖家需要的URL*/
@property (nonatomic, copy) NSString *sellerUrl;
/**商品详情数组*/
@property (nonatomic, strong) NSArray *goodsDetail;



@end
