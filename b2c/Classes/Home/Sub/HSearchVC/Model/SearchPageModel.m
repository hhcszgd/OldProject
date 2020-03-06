//
//  SearchPageModel.m
//  b2c
//
//  Created by wangyuanfei on 16/5/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SearchPageModel.h"

@implementation SearchPageModel

-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    
       if ([key isEqualToString:@"actionkey"]) {
        
        NSString * temp =value;

        self.actionKey = temp;
        return;
    }
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



@end