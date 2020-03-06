//
//  HPrereleaseCell.m
//  b2c
//
//  Created by 张凯强 on 2016/12/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HPrereleaseCell.h"
@interface HPrereleaseCell()
@property (nonatomic, strong) NSMutableArray *mutableArr;
@property (nonatomic, strong) UIImageView *topImage;
@property (nonatomic, weak) HCellModel *privateModel;
@end

@implementation HPrereleaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 33 * SCALE)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        self.topImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.topImage];
        self.topImage.image = [UIImage imageNamed:@"title_02"];
        self.topImage.frame = CGRectMake((screenW - (281/2.0 * SCALE))/2.0, 5.5 * SCALE, 285/2.0 * SCALE, 22 * SCALE);
        self.mutableArr = [[NSMutableArray alloc] init];
        self.contentView.backgroundColor = BackgroundGray;
        CGFloat perprot = 274.0/186.0;
        CGFloat width = (screenW - 6)/4.0;
        CGFloat height = width * perprot;
        for (NSInteger i = 0; i < 8; i++) {
            NSInteger row = i / 4;
            NSInteger line = i % 4;
            UIImageView *imageview = [[UIImageView alloc] init];
            [self.contentView addSubview:imageview];
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [imageview addGestureRecognizer:tap];
            imageview.frame = CGRectMake(line * (width + 2), row * (height + 2) + 2 + 33 * SCALE, width, height);
            
            imageview.tag = i;
            [self.mutableArr addObject:imageview];
//            imageview.backgroundColor = randomColor;
            
        }
    }
    return self;
}
-(void)setCellModel:(HCellModel *)cellModel{
    self.privateModel = cellModel;
    NSURL *url;
    if ([cellModel.imgStr hasPrefix:@"http"]) {
        url = [NSURL URLWithString:cellModel.imgStr];
    } else {
        url = ImageUrlWithString(cellModel.imgStr);
    }
//    CGFloat scale = [[UIScreen mainScreen] scale];
//    if (cellModel.isRefreshImageCached) {
//        
//        [self.topImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.topImage.frame = CGRectMake((screenW - (image.size.width/scale * SCALE))/2.0, (33 * SCALE - (image.size.height/scale * SCALE))/2.0, image.size.width/scale * SCALE, image.size.height/scale * SCALE);
//        }];
//    } else {
//        [self.topImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.topImage.frame = CGRectMake((screenW - (image.size.width/scale * SCALE))/2.0, (33 * SCALE - (image.size.height/scale * SCALE))/2.0, image.size.width/scale * SCALE, image.size.height/scale * SCALE);
//        }];
//    }
    
    if (cellModel.items && ![cellModel.items isKindOfClass:[NSNull class]]) {
        for (NSInteger i = 0; i < cellModel.items.count; i++) {
            UIImageView *myimage = self.mutableArr[i];
            
            
            
            HCellComposeModel *model = cellModel.items[i];
            NSURL *url;
            if ([model.imgStr hasPrefix:@"http"]) {
                url = [NSURL URLWithString:model.imgStr];
            } else {
                url = ImageUrlWithString(model.imgStr);
            }
            if (model.isRefreshImageCached) {
                [myimage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRefreshCached completed:nil];
                model.isRefreshImageCached = NO;
                
            } else {
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                if ([manager cachedImageExistsForURL:url]) {
                    [myimage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:nil];
                } else {
                    [myimage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        myimage.alpha = 0.0;
                        [UIView transitionWithView:myimage duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                            myimage.alpha = 1.0;
                            if (image) {
                                myimage.image = image;
                            }else{
                                myimage.image = placeImage;
                            }
                        } completion:nil];
                    }];
                }
            }
            
            
            
        }
    }
}
- (void)tapClick:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)tap.view;
    if (self.privateModel.items && ![self.privateModel.items isKindOfClass:[NSNull class]]) {
        HCellComposeModel *model = self.privateModel.items[imageView.tag];
        if (model.value.length > 0) {
            model.keyParamete = @{@"paramete": model.value};
        }
        if (model) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:@{@"HCellComposeViewModel": model}];
        }
        
    }
    
}



@end
