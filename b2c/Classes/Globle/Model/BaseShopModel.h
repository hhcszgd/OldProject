//
//  BaseShopModel.h
//  b2c
//
//  Created by 0 on 16/5/23.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface BaseShopModel : BaseModel
/**店铺id*/
@property (nonatomic, copy) NSString *shopID;
/**图片*/
@property (nonatomic, copy) NSString *img;
/**店铺名字*/
@property (nonatomic, copy) NSString *shor_name;
@end
