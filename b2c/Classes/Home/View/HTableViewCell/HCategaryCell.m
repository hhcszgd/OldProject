//
//  HCategaryCell.m
//  b2c
//
//  Created by 张凯强 on 2016/12/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCategaryCell.h"
@interface HCategaryCell()
@property (nonatomic, strong) NSMutableArray *mutableArr;
@property (nonatomic, weak) HCellModel *privateModel;
@end

@implementation HCategaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mutableArr = [[NSMutableArray alloc] init];
        self.contentView.backgroundColor = BackgroundGray;
        CGFloat perprot = 295.0/248.0;
        CGFloat width = (screenW - 4)/3.0;
        CGFloat height = width * perprot;
        for (NSInteger i = 0; i < 6; i++) {
            NSInteger row = i / 3;
            NSInteger line = i % 3;
            UIImageView *imageview = [[UIImageView alloc] init];
            [self.contentView addSubview:imageview];
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [imageview addGestureRecognizer:tap];
            imageview.frame = CGRectMake(line * (width + 2), row * (height +2), width, height);
            
            imageview.tag = i;
            [self.mutableArr addObject:imageview];
            
        }
    }
    return self;
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
- (void)setCellModel:(HCellModel *)cellModel{
    self.privateModel = cellModel;
    if (cellModel.items && ![cellModel.items isKindOfClass:[NSNull class]]) {
        for (NSInteger i = 0; i < cellModel.items.count; i++) {
            UIImageView *myimage = self.mutableArr[i];
            HCellComposeModel * model = cellModel.items[i];
            NSURL *url = ImageUrlWithString(model.imgStr);
            if (model.isRefreshImageCached) {
                [myimage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                model.isRefreshImageCached = NO;
            } else {
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                if ([manager cachedImageExistsForURL:url]) {
                    [myimage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                } else {
                    [myimage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        myimage.alpha = 0.0;
                        [myimage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [UIView transitionWithView:myimage duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                myimage.alpha = 1.0;
                                if (image) {
                                    myimage.image = image;
                                }else{
                                    myimage.image = placeImage;
                                }
                            } completion:nil];
                        }];
                    }];
                }
            }
            
        }
    }
}

@end
