//
//  HGBSeeAndSeeHeader.m
//  b2c
//
//  Created by 0 on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGBSeeAndSeeHeader.h"

@implementation HGBSeeAndSeeHeader

- (UILabel *)guessLabel{
    if (_guessLabel == nil) {
        _guessLabel = [[UILabel alloc] init];
        [self addSubview:_guessLabel];
        [_guessLabel configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
    }
    return _guessLabel;
}
- (UIView *)rightLineView{
    if (_rightLineView == nil) {
        _rightLineView = [[UIView alloc] init];
        [self addSubview:_rightLineView];
    }
    return _rightLineView;
}
- (UIView *)leftLineView{
    if (_leftLineView == nil) {
        _leftLineView= [[UIView alloc] init];
        [self addSubview:_leftLineView];
    }
    return _leftLineView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.guessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@(1));
            make.left.equalTo(self.guessLabel.mas_right).offset(10);
            make.width.equalTo(@(50* SCALE));
        }];
        
        [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.guessLabel.mas_left).offset(-10);
            make.width.equalTo(@(50 * SCALE));
            make.height.equalTo(@(1));
        }];
        self.leftLineView.backgroundColor = [UIColor colorWithHexString:@"999999"];
        self.rightLineView.backgroundColor = [UIColor colorWithHexString:@"999999"];
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}

@end
