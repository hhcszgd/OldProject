//
//  HSuperHeader.m
//  b2c
//
//  Created by 0 on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HSuperHeader.h"

@interface HSuperHeader()

@end
@implementation HSuperHeader
- (UIView *)leftView{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        [self addSubview:_leftView];
        _leftView.backgroundColor = THEMECOLOR;
    }
    return _leftView;
}
- (UILabel *)channelLabel{
    if (_channelLabel == nil) {
        _channelLabel = [[UILabel alloc] init];
        [self addSubview:_channelLabel];
        [_channelLabel configmentfont:[UIFont systemFontOfSize: 14 * SCALE] textColor:[UIColor colorWithHexString:@"ff3a30"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_channelLabel sizeToFit];
    }
    return _channelLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@(4));
            make.left.top.bottom.equalTo(self);
        }];
        [self.channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftView.mas_right).offset(18);
            make.centerY.equalTo(self);
        }];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setBaseModel:(HSuperBaseModel *)baseModel{
    self.channelLabel.text = baseModel.channel;
}
@end
