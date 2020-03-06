//
//  ShopCarCollectoinCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/19.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShopCarCollectoinCell.h"
#import "ShopCarCollectionCellCompose.h"

@interface ShopCarCollectoinCell ()

@property(nonatomic,weak)ShopCarCollectionCellCompose * compose ;

@end

@implementation ShopCarCollectoinCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        ShopCarCollectionCellCompose * compose= [[ShopCarCollectionCellCompose alloc]init];
        [self.contentView addSubview:compose];
        self.compose = compose;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.compose.frame = self.bounds;
}
-(void)setComposeModel:(HCellComposeModel *)composeModel{
//    _composeModel=composeModel;
    self.compose.composeModel = composeModel;
}
@end
