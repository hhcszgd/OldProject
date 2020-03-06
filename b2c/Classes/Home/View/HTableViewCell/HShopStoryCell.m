//
//  HShopStoryCell.m
//  b2c
//
//  Created by 张凯强 on 2016/12/23.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HShopStoryCell.h"
#import "HColorfulSubItem.h"
@interface HShopStoryCell()<UICollectionViewDelegate, UICollectionViewDataSource>
/**头部视图*/
@property (nonatomic, strong) UIImageView *topImage;
/***/
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) HCellModel *privateModel;
@end
@implementation HShopStoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 33 * SCALE)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.topImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.topImage];
        self.topImage.frame = CGRectMake((screenW - (347/2.0 * SCALE))/2.0, (33 - 23.5)/2.0 * SCALE, 347/2.0 * SCALE, 23.5 * SCALE);
        self.topImage.image = [UIImage imageNamed:@"title_07"];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat collHeight = 372.0/750.0 * screenW;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 33 * SCALE, screenW, collHeight) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = BackgroundGray;
        [self.contentView addSubview:self.collectionView];
        flowLayout.minimumLineSpacing = 15;
        CGFloat width = 420 * SCALE * 0.5;
        CGFloat height = 290.0/420.0 * width;
        CGFloat margin = (collHeight - height)/2.0;
        flowLayout.sectionInset = UIEdgeInsetsMake(2, margin, 2, margin);
        
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[HColorfulSubItem class] forCellWithReuseIdentifier:@"HColorfulSubItem"];
        
        
        
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.privateModel.items && ![self.privateModel.items isKindOfClass:[NSNull class]]) {
        return self.privateModel.items.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HColorfulSubItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"HColorfulSubItem" forIndexPath:indexPath];
    if (self.privateModel.items && ![self.privateModel.items isKindOfClass:[NSNull class]]) {
        item.composeModel = self.privateModel.items[indexPath.item];
    }
    return item;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.privateModel.items && ![self.privateModel.items isKindOfClass:[NSNull class]]) {
        HCellComposeModel *model = self.privateModel.items[indexPath.item];
        if (model.value.length > 0) {
            model.keyParamete = @{@"paramete": model.value};
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:@{@"HCellComposeViewModel": model}];
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
        [self.collectionView reloadData];
    }
}


@end
