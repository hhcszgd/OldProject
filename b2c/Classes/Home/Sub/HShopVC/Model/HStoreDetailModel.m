//
//  HStoreDetailModel.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreDetailModel.h"

@implementation HStoreDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",
             @"actionKey":@"actionkey"};
}


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"items":@"HStoreSubModel"};
}
@end
