//
//  OldBaseModel.m
//  zjlao
//
//  Created by WY on 16/11/12.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

#import "OldBaseModel.h"

@implementation OldBaseModel
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
