//
//  HFactoryBaseModel.m
//  b2c
//
//  Created by 0 on 16/5/1.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFactoryBaseModel.h"

@implementation HFactoryBaseModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"items":@"CustomCollectionModel"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}


@end
