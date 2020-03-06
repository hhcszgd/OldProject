//
//  HBestCargoCell.m
//  b2c
//
//  Created by 张凯强 on 2016/12/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBestCargoCell.h"
@interface HBestCargoCell()
@property (nonatomic, strong) NSMutableArray *mutableArr;
@property (nonatomic, strong) UIImageView *topImage;
@property (nonatomic, weak) HCellModel *privateModel;
@end

@implementation HBestCargoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 33 * SCALE)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        self.topImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.topImage];
        
        self.topImage.frame = CGRectMake((screenW - (336/2.0 * SCALE))/2.0, 5.5 * SCALE, 336/2.0 * SCALE, 22 * SCALE);
        
        self.mutableArr = [[NSMutableArray alloc] init];
        self.contentView.backgroundColor = BackgroundGray;
        CGFloat perprot = 274.0/248.0;
        CGFloat width = (screenW - 4)/3.0;
        CGFloat height = width * perprot;
        for (NSInteger i = 0; i < 3; i++) {
            
            UIImageView *imageview = [[UIImageView alloc] init];
            [self.contentView addSubview:imageview];
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [imageview addGestureRecognizer:tap];
            imageview.frame = CGRectMake(i * (width + 2), 33 * SCALE + 2, width, height);
           
            imageview.tag = i;
            [self.mutableArr addObject:imageview];
        }
        CGFloat fourthWidth = ((375.0 - 2.0)/2.0/375.0) * screenW;
        CGFloat fourthHeight = (70.0/((375.0-2.0)/2.0)) * fourthWidth;
        
        UIImageView *fourthImage = [[UIImageView alloc] init];
        [self.contentView addSubview:fourthImage];
        fourthImage.tag = 3;
        fourthImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [fourthImage addGestureRecognizer:tap1];
        CGFloat h = 33 * SCALE + 2.0 + height + 2;
        [self.mutableArr addObject:fourthImage];
        fourthImage.frame = CGRectMake(0, h, fourthWidth, fourthHeight);
        
//        CGFloat fifthWidth = 328.0 * 0.5 * SCALE;
//        CGFloat fifthheight = 140.0/328.0 * fifthWidth;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        UIImageView *fifthImage = [[UIImageView alloc] init];
        [self.contentView addSubview:fifthImage];
        [self.mutableArr addObject:fifthImage];
        fifthImage.tag = 4;
        fifthImage.userInteractionEnabled = YES;
        [fifthImage addGestureRecognizer:tap2];
        fifthImage.frame = CGRectMake(screenW - fourthWidth, h, fourthWidth, fourthHeight);
    }
    return self;
}
- (void)setCellModel:(HCellModel *)cellModel{
    NSURL *url;
    if ([cellModel.imgStr hasPrefix:@"http"]) {
        url = [NSURL URLWithString:cellModel.imgStr];
    } else {
        url = ImageUrlWithString(cellModel.imgStr);
    }
    if ([cellModel.imgStr isEqualToString:@"dms/20170122091123355.png"]) {
        self.topImage.frame = CGRectMake((screenW - (336/2.0 * SCALE))/2.0, 5 * SCALE, 336/2.0 * SCALE, 22 * SCALE);
        self.topImage.image = [UIImage imageNamed:@"title_03"];
    }
    if ([cellModel.imgStr isEqualToString:@"dms/20170122084337440.png"]) {
        self.topImage.frame = CGRectMake((screenW - (329/2.0 * SCALE))/2.0, (33 - 21)/2.0 * SCALE, 329/2.0 * SCALE, 21 * SCALE);
        self.topImage.image = [UIImage imageNamed:@"title_04"];
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
    
    self.privateModel = cellModel;
//    [self.topImage sd_setImageWithURL:ImageUrlWithString(cellModel.imgStr) placeholderImage:placeImage options:SDWebImageCacheMemoryOnly];
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
