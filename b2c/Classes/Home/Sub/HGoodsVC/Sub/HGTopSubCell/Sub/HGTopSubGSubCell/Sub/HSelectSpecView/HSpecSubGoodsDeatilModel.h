//
//  HSpecSubGoodsDeatilModel.h
//  b2c
//
//  Created by 0 on 16/5/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface HSpecSubGoodsDeatilModel : BaseModel
/**第一级规格*/
@property (nonatomic, copy) NSString *spec1;
/**二级规格*/
@property (nonatomic, copy) NSString *spec2;
/**三级规格*/
@property (nonatomic, copy) NSString *spec3;
/**四级规格*/
@property (nonatomic, copy) NSString *spec4;
/**五级规格*/
@property (nonatomic, copy) NSString *spec5;
/**库存*/
@property (nonatomic, copy) NSString *reserced;
/**价格*/
@property (nonatomic, copy) NSString *price;
/**图片*/
@property (nonatomic, copy) NSString *image;
/**规格id*/
@property (nonatomic, copy) NSString *sub_id;
@end
