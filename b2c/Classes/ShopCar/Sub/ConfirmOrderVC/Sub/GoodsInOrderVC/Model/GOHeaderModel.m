//
//  GOHeaderModel.m
//  b2c
//
//  Created by wangyuanfei on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GOHeaderModel.h"

@implementation GOHeaderModel
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
