//
//  COrderGoodSubModel.h
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface COrderGoodSubModel : BaseModel
/**描述*/
@property (nonatomic, copy) NSString *short_name;
/**商品号*/
@property (nonatomic, copy) NSString *goods_id;
/**购买数量*/
@property (nonatomic, copy) NSString *num;
/**图片*/
@property (nonatomic, copy) NSString *img;
/**价格*/
@property (nonatomic, copy) NSString *price;
/**规格id*/
@property (nonatomic, copy) NSString *sub_id;
/**规格*/
@property (nonatomic, strong) NSMutableArray *sub_items;
@end
