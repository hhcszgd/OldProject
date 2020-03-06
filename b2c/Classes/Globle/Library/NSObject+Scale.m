//
//  NSObject+Scale.m
//  b2c
//
//  Created by wangyuanfei on 16/4/16.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "NSObject+Scale.h"

@implementation NSObject (Scale)
-(CGFloat )scaleHeight{
    if ([UIScreen mainScreen].bounds.size.width>375.0) {
        return 1.104000;
    } else if ([UIScreen mainScreen].bounds.size.width<321) {
        return 0.853333;
    }else {
        return 1 ;
    }
}
@end
