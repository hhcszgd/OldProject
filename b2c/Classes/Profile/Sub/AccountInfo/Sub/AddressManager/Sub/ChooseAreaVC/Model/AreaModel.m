//
//  AreaModel.m
//  b2c
//
//  Created by wangyuanfei on 16/5/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel
-(instancetype)initWithdictionary:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
        return;
    }
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
