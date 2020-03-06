//
//  RefundReturnView.m
//  b2c
//
//  Created by 0 on 16/4/15.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "RefundReturnView.h"

@implementation RefundReturnView
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
    }
    return _leftImageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}





- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_The receipt"]];
        [self addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@(20));
             make.width.equalTo(@(20));
        }];
        
        
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
             make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.leftImageView.mas_right).offset(10);
            
            
        }];
        [self.titleLabel configmentfont:[UIFont boldSystemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [self.titleLabel sizeToFit];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.right.equalTo(arrowImageView.mas_left).offset(-10);
            
        }];
        [self.detailLabel sizeToFit];
        [self.detailLabel configmentfont:[UIFont systemFontOfSize:11] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
    }
    return self;
}

@end
