//
//  HGoodsBottomSubModel.h
//  b2c
//
//  Created by 0 on 16/5/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface HGoodsBottomSubModel : BaseModel
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *full_name;
@property (nonatomic, copy) NSString *good_id;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *price;
/**月销量*/
@property (nonatomic, copy) NSString *sales_month;
@property (nonatomic, copy) NSString *short_name;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@end
