//
//  GCModel.h
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface GCModel : BaseModel
/**商品全名*/
@property (nonatomic, copy) NSString *full_name;
/**商品id*/
@property (nonatomic, copy) NSString *ID;
/**商品图片*/
@property (nonatomic, copy) NSString *img;
/**商品价格*/
@property (nonatomic, copy) NSString *price;
/**店铺logo*/
@property (nonatomic, copy) NSString *shoplogo;
/**店铺名字*/
@property (nonatomic, copy) NSString *shopname;
/**actionkey*/
@property (nonatomic, copy) NSString *actionkey;
/**button*/
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *short_name;
//

@end
