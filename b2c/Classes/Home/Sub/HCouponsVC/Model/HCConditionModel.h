//
//  HCConditionModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface HCConditionModel : BaseModel
/** 筛选条件  用来显示的 */
@property(nonatomic,copy)NSString * name ;
/** 对应的当做参数传递的id */
@property(nonatomic,copy)NSString * ID ;

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
/**
 name = 户外运动;
 id = 3005;
 actionkey = coupons;
 */