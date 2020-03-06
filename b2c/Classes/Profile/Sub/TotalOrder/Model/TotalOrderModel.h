//
//  TotalOrderModel.h
//  b2c
//
//  Created by 0 on 16/4/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OrderBaseModel.h"
#import "PTOShopModel.h"
@interface TotalOrderModel : OrderBaseModel

/**订单编号*/
@property (nonatomic, copy) NSString *orderid;
/**订单状态*/
@property (nonatomic, copy) NSString *status;
/**店铺模型*/
@property (nonatomic, strong) PTOShopModel *shop;
/**商品数组*/
@property (nonatomic, strong) NSMutableArray *goods;
@end
