//
//  HColorfulSubItem.m
//  b2c
//
//  Created by 张凯强 on 2016/12/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HColorfulSubItem.h"

@implementation HColorfulSubItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.BCImageView];
        [self.BCImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setComposeModel:(HCellComposeModel *)composeModel{
    NSURL *url;
    if ([composeModel.imgStr hasPrefix:@"http"]) {
        url = [NSURL URLWithString:composeModel.imgStr];
    }else {
        url = ImageUrlWithString(composeModel.imgStr);
    }
    
    
    
    if (composeModel.isRefreshImageCached) {
        [self.BCImageView sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRefreshCached];
        composeModel.isRefreshImageCached = NO;
    } else {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        if ([manager cachedImageExistsForURL:ImageUrlWithString(composeModel.imgStr)]) {
            [self.BCImageView sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        } else {
            [self.BCImageView sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.BCImageView.alpha = 0.0;
                [UIView transitionWithView:self.BCImageView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    self.BCImageView.alpha = 1.0;
                    if (image) {
                        self.BCImageView.image = image;
                    }else{
                        self.BCImageView.image = placeImage;
                    }
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }
    }
    
}

@end
