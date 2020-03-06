//
//  BaseGoodsModel.h
//  b2c
//
//  Created by 0 on 16/5/23.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface BaseGoodsModel : BaseModel
/**商品id*/
@property (nonatomic, copy) NSString *goods_id;
/**商品图片*/
@property (nonatomic, copy) NSString *img;
/**商品价格*/
@property (nonatomic, copy) NSString *price;
/**商品总销量*/
@property (nonatomic, copy) NSString *sales_sum;

@end
