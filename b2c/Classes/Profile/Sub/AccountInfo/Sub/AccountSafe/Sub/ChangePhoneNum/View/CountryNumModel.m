//
//  CountryNumModel.m
//  b2c
//
//  Created by wangyuanfei on 6/19/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "CountryNumModel.h"

@implementation CountryNumModel
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];

}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
