//
//  SearchPageModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface SearchPageModel : BaseModel
/**
 channel = 默认关键词;
 key = hotkeywords;
 items =
 */
@property(nonatomic,copy)NSString * channel ;
@property(nonatomic,copy)NSString * key ;
@property(nonatomic,strong)NSArray * items ;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
