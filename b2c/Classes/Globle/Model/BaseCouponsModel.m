//
//  BaseCouponsModel.m
//  b2c
//
//  Created by 0 on 16/5/23.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseCouponsModel.h"

@implementation BaseCouponsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"coupons_id":@"id",
             @"actionKey":@"actionkey"};
}
@end
