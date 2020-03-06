//
//  ClistOfGoodsModel.h
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface ClistOfGoodsModel : BaseModel
/**商品图片*/
@property (nonatomic, copy) NSString *img;
/**商品介绍*/
@property (nonatomic, copy) NSString *full_name;
/**商品销售量*/
@property (nonatomic, copy) NSString *sales_sum;

/**月销量*/
@property (nonatomic, copy) NSString *sales_month;
/**商品价格*/
@property (nonatomic, copy) NSString *price;
/**店铺名称*/
@property (nonatomic, copy) NSString *short_name;

/**运费*/
@property (nonatomic, copy) NSString *freight;
/**发货地点*/
@property (nonatomic, copy) NSString *place;
/**商品id*/
@property (nonatomic, copy) NSString *goodsID;
/**店铺名称*/
@property (nonatomic, copy) NSString *shop_short_name;


@end
