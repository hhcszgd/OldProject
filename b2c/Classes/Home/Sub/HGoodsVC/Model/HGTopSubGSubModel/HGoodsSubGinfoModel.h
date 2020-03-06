//
//  HGoodsSubGinfoModel.h
//  b2c
//
//  Created by 0 on 16/5/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//商品信息

#import "BaseModel.h"
#import "HGoodsBaseModel.h"
@interface HGoodsSubGinfoModel : HGoodsBaseModel
/**发货地点*/
@property (nonatomic, copy) NSString *area;
/**价格*/
@property (nonatomic, copy) NSString *price;
/**运费*/
@property (nonatomic, copy) NSString *freight;
/**售后服务*/
@property (nonatomic, strong) NSMutableArray *security_range;
@property (nonatomic, copy) NSString *short_name;
@property (nonatomic, copy) NSString *sales_month;

/**商品状态*/
@property (nonatomic,  assign) NSInteger goods_status;
/**预售时间*/
@property (nonatomic, copy) NSString  *shelves_at;
@property (nonatomic, copy) NSString *sea;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *flag;
@end
