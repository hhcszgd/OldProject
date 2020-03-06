//
//  CCCouponsModel.m
//  b2c
//
//  Created by wangyuanfei on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CCCouponsModel.h"

@interface CCCouponsModel ()

@end

@implementation CCCouponsModel


-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"full_price"]) {
        /**  满多少
//        @property(nonatomic,copy)NSString * full_price ;
         减多少
//        @property(nonatomic,copy)NSString * discount_price ;
        */
    }else if ([key isEqualToString:@"discount_price"]){
    
    }
    if ([key isEqualToString:@"cid"]) {
        return;
    }
    if ([key isEqualToString:@"id"]) {
        self.cid  = value;
    }
    
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(NSString *)timeLimit{
    NSString * startTime =[self.start_time formatterDateString];
    NSString * endTime = [self.end_time  formatterDateString];

    return [NSString stringWithFormat:@"%@-%@",startTime , endTime] ;
//    return [NSString stringWithFormat:@"%@-%@",self.start_time , self.end_time] ;
}
@end
