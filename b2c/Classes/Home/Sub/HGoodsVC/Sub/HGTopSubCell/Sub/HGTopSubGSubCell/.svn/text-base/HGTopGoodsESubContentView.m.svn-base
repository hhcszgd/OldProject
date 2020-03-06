//
//  HGTopGoodsESubContentView.m
//  b2c
//
//  Created by 0 on 16/5/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGTopGoodsESubContentView.h"

@implementation HGTopGoodsESubContentView

- (UIImageView *)nikeImage{
    if (_nikeImage == nil) {
        _nikeImage = [[UIImageView alloc] init];
        [self addSubview:_nikeImage];
    }
    return _nikeImage;
}
- (UILabel *)nikeLabel{
    if (_nikeLabel == nil) {
        _nikeLabel = [[UILabel alloc] init];
        [self addSubview:_nikeLabel];
        [_nikeLabel configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
        
    }
    return _nikeLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        [_contentLabel configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@""];
    }
    return _contentLabel;
}




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.nikeImage.backgroundColor = randomColor;
        self.nikeImage.frame = CGRectMake(20, 5, 25 * zkqScale, 25 *zkqScale);
        self.nikeImage.layer.masksToBounds = YES;
        self.nikeImage.layer.cornerRadius = 25 * zkqScale/2.0;
        self.nikeLabel.frame = CGRectMake(10, self.nikeImage.frame.size.height + self.nikeImage.frame.origin.y , 55 *zkqScale, 14 * zkqScale);
//        self.contentLabel.frame = CGRectMake(self.nikeLabel.frame.origin.x + self.nikeLabel.frame.size.width +21, 0, frame.size.width - (self.nikeLabel.frame.origin.x + self.nikeLabel.frame.size.width +21), frame.size.height);
        
    }
    return self;
}
- (void)layoutSubviews{
     self.contentLabel.frame = CGRectMake(self.nikeLabel.frame.origin.x + self.nikeLabel.frame.size.width +21, 0, self.frame.size.width - (self.nikeLabel.frame.origin.x + self.nikeLabel.frame.size.width +21) - 10, self.frame.size.height);
}
- (void)setSubModel:(HGTopSubGoodsESubModel *)subModel{
    [self.nikeImage sd_setImageWithURL:ImageUrlWithString(subModel.img) placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    self.nikeLabel.text = subModel.nick;
    self.contentLabel.text = subModel.content;
}

@end
