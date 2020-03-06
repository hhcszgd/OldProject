//
//  HColorfulCell.m
//  b2c
//
//  Created by 张凯强 on 2016/12/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HColorfulCell.h"
#import "HColorfulSubItem.h"
@interface HColorfulCell()<UICollectionViewDelegate, UICollectionViewDataSource>
/**头部视图*/
@property (nonatomic, strong) UIImageView *topImage;
/***/
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) HCellModel *privateModel;
@end
@implementation HColorfulCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.topImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.topImage];
        self.topImage.contentMode = UIViewContentModeScaleAspectFit;
        self.topImage.frame = CGRectMake((screenW - ( 285/2.0 * SCALE))/2.0, (33 * SCALE - (20 * SCALE))/2.0, 285/2.0 * SCALE, 20 * SCALE);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 33 * SCALE, screenW, 101 * SCALE) collectionViewLayout:flowLayout];
        [self.contentView addSubview:self.collectionView];
        CGFloat width = 566.0/750.0 * screenW;
        CGFloat height = 202.0/566.0 * width;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.minimumLineSpacing = 0;
        self.collectionView.showsHorizontalScrollIndicator = false;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[HColorfulSubItem class] forCellWithReuseIdentifier:@"HColorfulSubItem"];
        self.collectionView.backgroundColor = BackgroundGray;
        
        
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.privateModel.items) {
        if (![self.privateModel.items isKindOfClass:[NSNull class]]) {
            return  self.privateModel.items.count;
        }
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HColorfulSubItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"HColorfulSubItem" forIndexPath:indexPath];
    item.composeModel = self.privateModel.items[indexPath.item];
    return item;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.privateModel.items) {
        if (![self.privateModel.items isKindOfClass:[NSNull class]]) {
            HCellComposeModel *model = self.privateModel.items[indexPath.item];
            if (model.value.length > 0) {
                model.keyParamete = @{@"paramete": model.value};
            }
            if (model) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:@{@"HCellComposeViewModel": model}];
            }
            
            
        }
    }
    
}
- (void)setCellModel:(HCellModel *)cellModel{
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
    
    self.topImage.image = [UIImage imageNamed:@"title_01"];
    
    self.privateModel = cellModel;
    if (cellModel.items) {
        //如果数组存在
        if (![cellModel.items isKindOfClass:[NSNull class]]) {
            [self.collectionView reloadData];
        }
    }
}



@end
