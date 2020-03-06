//
//  POrderCellComposeModel.m
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "POrderCellComposeModel.h"

@implementation POrderCellComposeModel
-(void)setBotomTitle:(NSString *)botomTitle{
    _botomTitle = botomTitle;
    self.title = botomTitle;
}


-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"num" ]||[key isEqualToString:@"number"]) {
        self.number = value;
        return;
    }
    if ([key isEqualToString:@"actionkey"]) {
        self.actionKey  =  value;
        return;
    }
    if ([key isEqualToString:@"description"]||[key isEqualToString:@"name"]) {
        self.title = value;
        return;
    }
    
    [super setValue:value forKey:key];
}


@end
