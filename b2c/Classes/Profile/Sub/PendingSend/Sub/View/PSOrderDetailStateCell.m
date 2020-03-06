//
//  PSOrderDetailStateCell.m
//  b2c
//
//  Created by 0 on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PSOrderDetailStateCell.h"

@implementation PSOrderDetailStateCell

- (void)setOrderTailModel:(OrderDetailModel *)orderTailModel{
    [super setOrderTailModel:orderTailModel];

    self.backGroundImage.image = [UIImage imageNamed:orderTailModel.backGroundImageStr];
}

@end
