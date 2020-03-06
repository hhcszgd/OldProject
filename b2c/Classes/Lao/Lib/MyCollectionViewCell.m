//
//  MyCollectionViewCell.m
//  TestMyScrollView
//
//  Created by WY on 16/2/28.
//  Copyright © 2016年 wy. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIView * containner = [[UIView alloc]init];
        self.containerView=containner;
        [self.contentView addSubview:self.containerView];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.containerView.frame=self.contentView.bounds;
    self.showView.frame=self.containerView.bounds;
}
-(void)setShowView:(UIView *)showView{
    _showView=showView;
    for (UIView * view in self.containerView.subviews) {
        [view removeFromSuperview];
    }
    [self.containerView addSubview:showView];
}
//-(void)setContainerView:(UIView *)containerView{}
@end
