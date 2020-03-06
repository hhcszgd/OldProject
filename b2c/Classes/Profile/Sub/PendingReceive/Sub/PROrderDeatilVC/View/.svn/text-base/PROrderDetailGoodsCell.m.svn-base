//
//  PROrderDetailGoodsCell.m
//  b2c
//
//  Created by 0 on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "PROrderDetailGoodsCell.h"
@interface PROrderDetailGoodsCell()
@property (nonatomic, strong) OrderDetailModel *model;
@end
@implementation PROrderDetailGoodsCell

- (void)setOrderTailModel:(OrderDetailModel *)orderTailModel{
    [super setOrderTailModel:orderTailModel];
    _model = orderTailModel;
    
    self.goodImage.image = [UIImage imageNamed:orderTailModel.goodImage];
    [self.goodTitle configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:orderTailModel.goodTitle];
    [self.priceLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:orderTailModel.priceLabel];
    [self.countLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:orderTailModel.countLabel];
    
}
- (void)refundReumTap:(UITapGestureRecognizer *)refundReumTap{
    if ([self.delegate respondsToSelector:@selector(refundModel:)]) {
        
        [self.delegate performSelector:@selector(refundModel:) withObject:_model];
    }
}

@end
