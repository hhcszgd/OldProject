//
//  HEaHeader.m
//  b2c
//
//  Created by 0 on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HEaHeader.h"
@interface HEaHeader()


@property (nonatomic, strong) UILabel *titleHeader;

@end
@implementation HEaHeader
- (UIImageView *)backImage{
    if (_backImage == nil) {
        _backImage = [[UIImageView alloc] init];
        [self addSubview:_backImage];
    }
    return _backImage;
}

- (UILabel *)titleHeader{
    if (_titleHeader == nil) {
        _titleHeader = [[UILabel alloc] init];
        [self addSubview:_titleHeader];
        [_titleHeader configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"3167f0"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_titleHeader sizeToFit];
    }
    return _titleHeader;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        [self.titleHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}
- (void)setBaseModel:(HEaBaseModel *)baseModel{
    self.titleHeader.text = baseModel.channel;
    
}

@end
