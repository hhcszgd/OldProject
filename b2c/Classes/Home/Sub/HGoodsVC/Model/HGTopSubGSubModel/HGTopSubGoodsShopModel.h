//
//  HGTopSubGoodsShopModel.h
//  b2c
//
//  Created by 0 on 16/5/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGoodsBaseModel.h"
@interface HGTopSubGoodsShopModel : HGoodsBaseModel

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *shop_name;
@property (nonatomic, copy) NSString *shop_id;
/**店铺卖家用户名*/
@property (nonatomic, copy) NSString *seller_login_name;

/**是否显示该cell*/
@property (nonatomic, copy) NSString *sea;


@end
