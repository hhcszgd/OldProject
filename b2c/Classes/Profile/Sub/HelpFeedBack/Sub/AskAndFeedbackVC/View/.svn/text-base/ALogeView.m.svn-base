//
//  ALogeView.m
//  b2c
//
//  Created by 张凯强 on 16/7/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#import "ALogeView.h"
@interface ALogeView()
@property (nonatomic, strong) UILabel *titleLable;

@end
@implementation ALogeView
- (UILabel*)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        [self addSubview:_titleLable];
        [_titleLable configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"商品、商家投诉请拨打投诉电话"];
        [_titleLable sizeToFit];
    }
    return _titleLable;
}
- (UILabel *)logePhone{
    if (_logePhone == nil) {
        _logePhone = [[UILabel alloc] init];
        [self addSubview:_logePhone];
        [_logePhone configmentfont:[UIFont systemFontOfSize:15 *SCALE] textColor:[UIColor whiteColor] backColor:THEMECOLOR textAligement:1 cornerRadius:6 text:@""];
        _logePhone.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
        [_logePhone addGestureRecognizer:tap];
        
        
    }
    return _logePhone;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)layoutSubviews{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(109 * SCALE);
        make.centerX.equalTo(self);
    }];
    [self.logePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.mas_bottom).offset(9);
        make.centerX.equalTo(self);
        make.width.equalTo(@(210 * SCALE));
        make.height.equalTo(@(36 * SCALE));
    }];
}

- (void)clickTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(logePhoneToTarget:)]) {
        [self.delegate performSelector:@selector(logePhoneToTarget:) withObject:self.logePhone.text];
    }
}


@end
