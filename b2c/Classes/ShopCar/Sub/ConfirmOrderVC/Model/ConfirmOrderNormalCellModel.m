//
//  ConfirmOrderNormalCellModel.m
//  b2c
//
//  Created by wangyuanfei on 16/4/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ConfirmOrderNormalCellModel.h"

@implementation ConfirmOrderNormalCellModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


-(void)setValue:(id)value forKey:(NSString *)key{
//    LOG(@"_%@_%d_  键:%@    值:%@",[self class] , __LINE__,key,value)
    if ([key isEqualToString:@"subtitle"]) {
//        if ([value isKindOfClass:[NSString class]]) {
//            self.subtitle=value;
//        }else if ([value isKindOfClass:[NSNumber class]]){
        //        }
        if ([value isKindOfClass:[NSString class]]||[value isKindOfClass:[NSNumber class]]) {
            LOG(@"_%@_%d_解析subtitle之前的值 --- >  %@",[self class] , __LINE__,value);
            self.subtitle = [NSString stringWithFormat:@"%@",value];
            NSInteger  v = [value integerValue];
            LOG(@"_%@_%d_现在呢%ld",[self class] , __LINE__,v);
            self.subtitle = [NSString stringWithFormat:@"%.02f",v/100.0];
//            self.subtitle =  [self.subtitle  convertToYuan];
            LOG(@"_%@_%d_解析subtitle之后的值 --- >  %@",[self class] , __LINE__,self.subtitle);
            return;
        }
    }
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}









//////////********////////////////


//-(instancetype)initWithDict:(NSDictionary *)dict{
//    if (self=[super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}
//
//
//-(void)setValue:(id)value forKey:(NSString *)key{
//    //    LOG(@"_%@_%d_  键:%@    值:%@",[self class] , __LINE__,key,value)
//    if ([key isEqualToString:@"subtitle"]) {
//        //        if ([value isKindOfClass:[NSString class]]) {
//        //            self.subtitle=value;
//        //        }else if ([value isKindOfClass:[NSNumber class]]){
//        //        }
//        if ([value isKindOfClass:[NSString class]]||[value isKindOfClass:[NSNumber class]]) {
//            LOG(@"_%@_%d_解析subtitle之前的值 --- >  %@",[self class] , __LINE__,value);
//            self.subtitle = [NSString stringWithFormat:@"%@",value];
//            NSInteger  v = [value integerValue];
//            LOG(@"_%@_%d_现在呢%ld",[self class] , __LINE__,v);
//            self.subtitle = [NSString stringWithFormat:@"%.02lf",v/100.0];
//            LOG(@"_%@_%d_解析subtitle之后的值 --- >  %@",[self class] , __LINE__,self.subtitle);
//            return;
//        }
//    }
//    [super setValue:value forKey:key];
//}
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
