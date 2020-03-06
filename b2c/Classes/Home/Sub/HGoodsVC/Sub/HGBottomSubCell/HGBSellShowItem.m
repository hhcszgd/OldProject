//
//  HGBSellShowItem.m
//  b2c
//
//  Created by 0 on 16/6/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGBSellShowItem.h"

@implementation HGBSellShowItem
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.BCImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setSubModel:(HGoodsBottomSubModel *)subModel{
    NSURL *url = ImageUrlWithString(subModel.img);
    [self.BCImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
}

@end
