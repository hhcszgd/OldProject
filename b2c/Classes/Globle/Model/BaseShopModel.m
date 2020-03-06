//
//  BaseShopModel.m
//  b2c
//
//  Created by 0 on 16/5/23.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseShopModel.h"

@implementation BaseShopModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"shopID":@"id",
             @"actionKey":@"actionkey"};
}
@end
