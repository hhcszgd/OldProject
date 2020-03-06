//
//  HStoreAptiudeItem.m
//  b2c
//
//  Created by 0 on 16/6/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreAptiudeItem.h"

@implementation HStoreAptiudeItem
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.BCImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(@(self.frame.size.width * 0.9));
            make.height.equalTo(@(self.frame.size.height * 0.9));
        }];
        
    }
    return self;
}

- (void)setAptutudeModel:(HStoreAptitudeModel *)aptutudeModel{
    NSURL *iamgeUrl = ImageUrlWithString(aptutudeModel.image);
    [self.BCImageView sd_setImageWithURL:iamgeUrl placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
}

@end
