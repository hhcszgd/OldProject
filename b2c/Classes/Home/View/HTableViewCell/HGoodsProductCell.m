//
//  HgoodProductCell.m
//  b2c
//
//  Created by 张凯强 on 2016/12/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGoodsProductCell.h"
@interface HGoodsProductCell()
/**第一张图片*/
@property (nonatomic, strong) UIImageView *firstImage;
@property (nonatomic, strong) UIImageView *secondImage;
@property (nonatomic, strong) UIImageView *thirdImage;
@property (nonatomic, strong) UIImageView *fourthImage;
@property (nonatomic, strong) UIImageView *fifthImage;
@property (nonatomic, strong) UIImageView *sixthImage;
@property (nonatomic, copy) NSArray *mutableArr;
@property (nonatomic, weak) HCellModel *privateModel;
@end
@implementation HGoodsProductCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = BackgroundGray;
        //图片宽度相对于屏幕的宽度比例这是iphone6上面
        CGFloat firthWidth = 239 * SCALE * 0.5;
        CGFloat firthHeight = 472.0/239.0 * firthWidth;
        
        self.firstImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.firstImage];
        
        self.firstImage.frame = CGRectMake(0, 0, firthWidth, firthHeight);
        
        
        CGFloat secondWidth = 499 * SCALE * 0.5;
        CGFloat secondHeight = 230.0/499.0 * secondWidth;
        self.secondImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.secondImage];
        
        self.secondImage.frame = CGRectMake(screenW - secondWidth, 0, secondWidth, secondHeight);
        
        CGFloat thirdWidth = 242 * SCALE * 0.5;
        CGFloat thirdHeight = 230.0/242.0 * thirdWidth;
        self.thirdImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.thirdImage];
        
        self.thirdImage.frame = CGRectMake(screenW - secondWidth, firthHeight - thirdHeight, thirdWidth, thirdHeight);
        
        self.fourthImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.fourthImage];
        
        
        self.fourthImage.frame = CGRectMake(screenW - thirdWidth, firthHeight - thirdHeight, thirdWidth, thirdHeight);
        
        
        self.fifthImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.fifthImage];
        self.sixthImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.sixthImage];
        
        self.mutableArr = @[self.firstImage, self.secondImage, self.thirdImage, self.fourthImage, self.fifthImage, self.sixthImage];
        
        
        NSInteger i = 0;
        for (UIImageView *imageView in self.mutableArr) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [tap addTarget:self action:@selector(tapClick:)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            i++;
            [imageView addGestureRecognizer:tap];
        }
        
        
    }
    return self;
}
- (void)tapClick:(UIGestureRecognizer *)tap{
    UIImageView *image = (UIImageView *)tap.view;
    HCellComposeModel *model = self.privateModel.items[image.tag];
    if (model.value.length > 0) {
        
        model.keyParamete = @{@"paramete": model.value};
    }
    if (model) {
       [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:@{@"HCellComposeViewModel": model}]; 
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.frame.size.height;
    CGFloat fifthWidth = 358 * SCALE * 0.5;
    CGFloat fifthHeight = fifthWidth * 144.0/358;
    self.fifthImage.frame = CGRectMake(6, height - fifthHeight - 6 , fifthWidth, fifthHeight);
    self.sixthImage.frame = CGRectMake(screenW - fifthWidth - 6 , height - fifthHeight - 6, fifthWidth, fifthHeight);
    
}


-(void)setCellModel:(HCellModel *)cellModel{
    
    self.privateModel = cellModel;
    if (cellModel.items) {
        //如果数组存在
        if (![cellModel.items isKindOfClass:[NSNull class]]) {
            for (NSInteger i = 0; i < cellModel.items.count; i++) {
                UIImageView *imagev = self.mutableArr[i];
                HCellComposeModel *model = cellModel.items[i];
                NSURL *url;
                if ([model.imgStr hasPrefix:@"http"]) {
                    url = [NSURL URLWithString:model.imgStr];
                } else {
                    url = ImageUrlWithString(model.imgStr);
                }
                if (model.isRefreshImageCached) {
                   [imagev sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRefreshCached];
                    model.isRefreshImageCached = NO;
                }else {
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    BOOL isExists = [manager cachedImageExistsForURL:url];
                    if (isExists) {
                        [imagev sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed];
                    } else {
                        [imagev sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            imagev.alpha = 0.0;
                            [UIView transitionWithView:imagev duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                if (image) {
                                    imagev.image = image;
                                }else{
                                    imagev.image = placeImage;
                                }
                                
                                imagev.alpha = 1.0;
                            } completion:^(BOOL finished) {
                                
                            }];
                        }];
                    }
                    
                }
                
            }
        }
    }
}



@end
