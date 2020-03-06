//
//  HAllBuyCollectionCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/15.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAllBuyCollectionCell.h"

#import "HPostCellComposeView.h"

@interface HAllBuyCollectionCell()
@property(nonatomic,weak)HCellBaseComposeView * container ;
@end

@implementation HAllBuyCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        HPostCellComposeView * container = [[HPostCellComposeView alloc]init];
        [container addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
        self.container = container;
        [self.contentView  addSubview:self.container];
        
    
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.container.frame = self.bounds;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
    self.container.composeModel = composeModel;
}
@end
