//
//  HVPurchaseSubView.m
//  b2c
//
//  Created by 张凯强 on 2016/12/23.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HVPurchaseSubView.h"
@interface HVPurchaseSubView()
@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIImageView *subImage;
@end
@implementation HVPurchaseSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.goodsImage = [[UIImageView alloc] init];
        [self addSubview:self.goodsImage];
        [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self);
            make.height.equalTo(self.goodsImage.mas_width);
        }];
        self.descripLabel = [[UILabel alloc] init];
        self.descripLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.descripLabel.font = [UIFont systemFontOfSize:12 * SCALE];
        [self.descripLabel sizeToFit];
        self.descripLabel.numberOfLines = 2;
        [self addSubview:self.descripLabel];
        [self.descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsImage.mas_bottom).offset(2);
            make.left.equalTo(self.mas_left).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            
        }];
        
        
        self.priceLabel = [[UILabel alloc] init];
        [self addSubview:self.priceLabel];
        self.priceLabel.font = [UIFont systemFontOfSize:14 * SCALE];
        [self.priceLabel sizeToFit];
        self.priceLabel.textColor = [UIColor redColor];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        
        self.subImage = [[UIImageView alloc] init];
        [self addSubview:self.subImage];
        self.subImage.image = [UIImage imageNamed:@"icon_hot"];
        [self.subImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.equalTo(@(17 * SCALE));
            make.height.equalTo(@(12.5 * SCALE));
        }];
        
        
        
        
    }
    return self;
}


- (void)setComposeModel:(HCellComposeModel *)composeModel{
    _privateModel = composeModel;
    _composeModel = composeModel;
    NSURL *url;
    if ([composeModel.imgStr hasPrefix:@"http"]) {
        url = [NSURL URLWithString:composeModel.imgStr];
    } else {
        url = ImageUrlWithString(composeModel.imgStr);
    }
    if (composeModel.isRefreshImageCached) {
        [self.goodsImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRefreshCached];
        composeModel.isRefreshImageCached = NO;
    } else {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        if ([manager cachedImageExistsForURL:url]) {
            [self.goodsImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:nil];
        } else {
            [self.goodsImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.goodsImage.alpha = 0.0;
                [UIView transitionWithView:self.goodsImage duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    self.goodsImage.alpha = 1.0;
                    if (image) {
                        self.goodsImage.image = image;
                    }else{
                        self.goodsImage.image = placeImage;
                    }
                } completion:nil];
            }];
        }
    }
    
    self.descripLabel.text = composeModel.short_name;
 
    
    
    
    self.priceLabel.attributedText = [composeModel.showPrice dealhomePricefirstFont:[UIFont systemFontOfSize:10] lastfont:[UIFont systemFontOfSize:8]];
    
}





@end
