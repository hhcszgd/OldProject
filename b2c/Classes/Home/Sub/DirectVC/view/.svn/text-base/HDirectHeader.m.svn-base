//
//  HDirectHeader.m
//  b2c
//
//  Created by 0 on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HDirectHeader.h"
@interface HDirectHeader()

@end
@implementation HDirectHeader
- (UIImageView *)channelImage{
    if (_channelImage == nil) {
        _channelImage = [[UIImageView alloc] init];
        [self addSubview:_channelImage];
    }
    return _channelImage;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.channelImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
             make.width.equalTo(@(screenW));
            make.height.equalTo(@(14));
        }];
        
    }
    return self;
}
- (void)setBaseModel:(HFactoryBaseModel *)baseModel{
    
}
- (void)setHeaderImage:(UIImage *)headerImage{
    self.channelImage.image = headerImage;
    [self.channelImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
         make.width.equalTo(@(headerImage.size.width * SCALE));
        make.height.equalTo(@(headerImage.size.height * SCALE));
    }];
}


@end
