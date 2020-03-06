//
//  SpecModel.h
//  b2c
//
//  Created by wangyuanfei on 7/1/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**购物车商品中的单个规格模型*/

#import "BaseModel.h"

@interface SpecModel : BaseModel
@property(nonatomic,copy)NSString * spec_name ;
@property(nonatomic,copy)NSString * spec_val ;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
