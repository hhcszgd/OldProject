//
//  LaoStoryCellModel.h
//  b2c
//
//  Created by wangyuanfei on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface LaoStoryCellModel : BaseModel
@property(nonatomic,copy)NSString * shopLogo ;
@property(nonatomic,copy)NSString * shopName ;
@property(nonatomic,copy)NSString * bigIcon ;
@property(nonatomic,copy)NSString * longTitle ;
@property(nonatomic,copy)NSString * url ;
@property(nonatomic,copy)NSString * shopID ;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
