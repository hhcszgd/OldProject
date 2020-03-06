//
//  HStoreSubModel.m
//  b2c
//
//  Created by 0 on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreSubModel.h"

@implementation HStoreSubModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"goodsID":@"id",
             @"actionKey":@"actionkey"};
}
@end
