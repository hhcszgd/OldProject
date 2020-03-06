//
//  PTOGoodModel.h
//  b2c
//
//  Created by 0 on 16/6/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface PTOGoodModel : BaseModel
/**图片*/
@property (nonatomic, copy) NSString *img;
/**全名*/
@property (nonatomic, copy) NSString *full_name;
/**支出*/
@property (nonatomic, copy) NSString *disbursements;

@end
