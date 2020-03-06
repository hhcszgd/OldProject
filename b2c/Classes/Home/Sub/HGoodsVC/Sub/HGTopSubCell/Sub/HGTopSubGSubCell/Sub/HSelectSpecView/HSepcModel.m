//
//  CategaryModel.m
//  TTmall
//
//  Created by 0 on 16/1/28.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "HSepcModel.h"

@implementation HSepcModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"spec":@"HSepcSubModel",
             @"goodsDeatil":@"HSpecSubGoodsDeatilModel"};
}
@end
