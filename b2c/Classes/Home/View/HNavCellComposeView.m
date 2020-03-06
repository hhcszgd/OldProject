//
//  HNavCellComposeView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HNavCellComposeView.h"

#import "HCellComposeModel.h"

@interface HNavCellComposeView ()

@property(nonatomic,weak)UILabel * composeTitle ;
@end

@implementation HNavCellComposeView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {

        UIImageView * composeImage = [[UIImageView alloc]init];
        self.composeImage=composeImage;
        [self addSubview:composeImage];
//        composeImage.backgroundColor = randomColor;
        
        UILabel * composeTitle = [[UILabel alloc]init];
//        composeTitle.backgroundColor = randomColor;
        composeTitle.font = [UIFont systemFontOfSize:12*SCALE];
        composeTitle.textColor = MainTextColor;//[UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        
        composeTitle.textAlignment = NSTextAlignmentCenter;
        self.composeTitle = composeTitle;
        [self addSubview:composeTitle];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftRightMargin = 17*SCALE;
//    CGFloat bottomMargin = 7 ;
    CGFloat topMargin = 10*SCALE ;
    CGFloat txtToImgMargin = 5*SCALE;
    CGFloat imgX = leftRightMargin ;
    CGFloat imgY = topMargin ;
    CGFloat imgW = self.bounds.size.width-leftRightMargin*2 ;
    CGFloat imgH = imgW ;
   
    self.composeImage.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGSize txtSize = [self.composeModel.title stringSizeWithFont:12];
    CGFloat txtX = 0 ;
    CGFloat txtY = CGRectGetMaxY(self.composeImage.frame)+txtToImgMargin ;
    CGFloat txtW = self.bounds.size.width ;
    CGFloat txtH = txtSize.height+1 ;
    
    self.composeTitle.frame = CGRectMake(txtX, txtY, txtW, txtH);


}



-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
//    [self.composeImage sd_setImageWithURL:[NSURL URLWithString:composeModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    NSURL *url;
    if ([composeModel.imgStr hasPrefix:@"http"]) {
        url = [NSURL URLWithString:composeModel.imgStr];
    } else {
        url = ImageUrlWithString(composeModel.imgStr);
    }
    
    if (composeModel.isRefreshImageCached) {
        [self.composeImage sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
        composeModel.isRefreshImageCached = NO;
    } else {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        if ([manager cachedImageExistsForURL:url]) {
            [self.composeImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:nil];
        } else {
            [self.composeImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.composeImage.alpha = 0.0;
                [UIView transitionWithView:self.composeImage duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    if (image) {
                        self.composeImage.image = image;
                    }else{
                        self.composeImage.image = placeImage;
                    }
                    self.composeImage.alpha = 1.0;
                } completion:^(BOOL finished) {
                    
                }];
                
            }];
        }
        
    }
    
    
    self.composeTitle.text=composeModel.short_name;
}
@end
