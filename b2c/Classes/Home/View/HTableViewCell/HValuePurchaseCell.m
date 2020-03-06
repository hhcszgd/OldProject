//
//  HValuePurchaseCell.m
//  b2c
//
//  Created by 张凯强 on 2016/12/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HValuePurchaseCell.h"
#import "HVPurchaseSubView.h"
@interface HValuePurchaseCell()
@property (nonatomic, strong) UIImageView *topImage;
@property (nonatomic, strong) NSMutableArray *mutableArr;
@property (nonatomic, weak) HCellModel *privateModel;
@end
@implementation HValuePurchaseCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 33 * SCALE)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        self.topImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.topImage];
        
        self.topImage.frame = CGRectMake((screenW - (303/2.0 * SCALE))/2.0, (33 - 21.5)/2.0 * SCALE, 303/2.0 * SCALE, 21.5 * SCALE);
        self.topImage.image = [UIImage imageNamed:@"title_06"];
        CGFloat otherWidth = (screenW - 4.0)/3.0;
        CGFloat otherHeight = 385.0/246.0 * otherWidth;
        CGFloat height = 33 * SCALE + 2;
        self.mutableArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 6; i++) {
            HVPurchaseSubView *subView = [[HVPurchaseSubView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [self.contentView addSubview:subView];
            [self.mutableArr addObject:subView];
            [subView addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
            subView.tag = i;
            NSInteger line = i / 3;
            NSInteger row = i % 3;
            subView.frame = CGRectMake(row * (otherWidth + 2), height + line * (otherHeight + 2), otherWidth, otherHeight);
            
            
            
            
        }
    }
    return self;
}


- (void)tapClick:(HVPurchaseSubView *)subView{
    

    if (subView.composeModel) {
        HCellComposeModel *model = subView.composeModel;
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
//    NSURL *url;
//    if ([cellModel.imgStr hasPrefix:@"http"]) {
//        url = [NSURL URLWithString:cellModel.imgStr];
//    } else {
//        url = ImageUrlWithString(cellModel.imgStr);
//    }
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
            HVPurchaseSubView *purchase = self.mutableArr[i];
            HCellComposeModel *model = cellModel.items[i];
            purchase.composeModel = model;
            
        }
    }
}



@end
