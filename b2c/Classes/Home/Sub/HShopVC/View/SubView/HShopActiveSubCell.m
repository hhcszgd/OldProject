//
//  HShopActiveSubCell.m
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HShopActiveSubCell.h"
@interface HShopActiveSubCell()
@property (nonatomic, strong) UIImageView *activeImage;
@end



@implementation HShopActiveSubCell
- (UIImageView *)activeImage{
    if (_activeImage == nil) {
        _activeImage = [[UIImageView alloc] init];
        _activeImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_activeImage];
    }
    return _activeImage;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.activeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setSubModel:(HStoreSubModel *)subModel{
    NSURL *url = ImageUrlWithString(subModel.img);
    
    [self.activeImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    
}

@end
