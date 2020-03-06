//
//  HGTopSubGoodsShopSubView.m
//  b2c
//
//  Created by 0 on 16/5/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGTopSubGoodsShopSubView.h"

@implementation HGTopSubGoodsShopSubView
- (UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] init];
        [self addSubview:_numLabel];
        [_numLabel configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
        [_numLabel sizeToFit];
    }
    return _numLabel;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [_titleLabel configmentfont:[UIFont systemFontOfSize:12 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
        [_titleLabel sizeToFit];
    }
   
    return _titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.right.equalTo(self).offset(0);
            
            
        }];
        
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.right.equalTo(self);
            
        }];
        
    }
    return self;
}



- (void)setSubModel:(HGTopSubGoodsShopSubModel *)subModel{
    _subModel = subModel;
    self.numLabel.text = subModel.num;
    self.titleLabel.text = subModel.name;
    
    
    
}



@end
