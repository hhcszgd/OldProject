//
//  BaseModel.m
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
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
