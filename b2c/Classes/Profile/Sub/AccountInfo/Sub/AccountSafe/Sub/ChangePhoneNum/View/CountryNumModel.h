//
//  CountryNumModel.h
//  b2c
//
//  Created by wangyuanfei on 6/19/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"
/** 
 regular = ^(86){0,1}1\d{10}$;
	number = 86;
	name = 中国大陆;
 */
@interface CountryNumModel : BaseModel
@property(nonatomic,copy)NSString * name ;
@property(nonatomic,copy)NSString * number ;
@property(nonatomic,copy)NSString * regular ;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
