//
//  PPOrdrDetailStateCell.m
//  b2c
//
//  Created by 0 on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PPOrdrDetailStateCell.h"

@implementation PPOrdrDetailStateCell

- (void)setOrderTailModel:(OrderDetailModel *)orderTailModel{
    [super setOrderTailModel:orderTailModel];
    [self.statusLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor whiteColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"等待买家付款"];
    self.backGroundImage.image = [UIImage imageNamed:orderTailModel.backGroundImageStr];
}
@end
