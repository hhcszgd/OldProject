//
//  HGTopGoodsInfoSub.m
//  b2c
//
//  Created by 0 on 16/8/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGTopGoodsInfoSub.h"

@implementation HGTopGoodsInfoSub
- (UIImageView *)titleImage{
    if (_titleImage == nil) {
        _titleImage = [[UIImageView alloc] init];
        
        [self addSubview:_titleImage];
    }
    return _titleImage;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [_titleLabel configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
    }
    return _titleLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleImage.backgroundColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@(12));
            make.height.equalTo(@(12));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.titleImage.mas_right).offset(5);
        }];
        [self.titleLabel sizeToFit];
        
    }
    return self;
}

- (void)setSecurityModel:(HGoodsSecurityModel *)securityModel{
    NSURL *url = ImageUrlWithString(securityModel.icon);
    [self.titleImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    self.titleLabel.text = securityModel.title;
}

@end
