//
//  GoodsModel.m
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
        return;
    }
    if ([key isEqualToString:@"img"] || [key isEqualToString:@"brand_logo"]) {
        self.imgStr = value;
        return;
    }
    
    if ([key isEqualToString:@"actionkey"]) {
        self.actionKey = value;
        return;
    }
    if ([key isEqualToString:@"description"]) {
        self.title = value;//八个导航模块儿的标题 , 网络数据字段是description , 属于关键字
        return;
    }
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
