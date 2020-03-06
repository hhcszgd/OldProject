//
//  AreaModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface AreaModel : BaseModel
@property(nonatomic,copy)NSString * name ;
@property(nonatomic,copy)NSString * ID ;
-(instancetype)initWithdictionary:(NSDictionary*)dict;
@end
