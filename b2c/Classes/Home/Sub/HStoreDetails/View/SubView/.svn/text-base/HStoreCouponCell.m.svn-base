//
//  HStoreCouponCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreCouponCell.h"
#import "CouponCell.h"
#define CouponCellHeight 60
@interface HStoreCouponCell()
/**滑动col*/
@property (nonatomic, strong) UICollectionView *col;
/**数据源*/
@property (nonatomic, strong) NSArray *dataArray;
@end
@implementation HStoreCouponCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenW, CouponCellHeight) collectionViewLayout:flowlayout];
    [collectionView registerClass:[CouponCell class] forCellWithReuseIdentifier:@"CouponCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.minimumLineSpacing = 5;
    collectionView.showsHorizontalScrollIndicator = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionView.contentSize = CGSizeMake(0, CouponCellHeight);
    _col = collectionView;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(CouponCellHeight));
    }];
    collectionView.backgroundColor = [UIColor whiteColor];
}



#pragma mark --- collection优惠券的滑动代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CouponCell" forIndexPath:indexPath];
    cell.dic = _dataArray[indexPath.item];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake( screenW * 0.45f, CouponCellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)setModel:(id)model{
    NSDictionary *dic = @{@"price":@"￥10", @"time":@"2016.01.22-2016.03.30", @"limit":@"满198元使用"};
    NSArray *arr = @[dic,dic,dic,dic,dic,dic,dic];
    _dataArray = arr;
    
    [_col reloadData];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%ld",[self class], __LINE__,indexPath.item)
}

- (void)setCollectionView:(UICollectionView *)collectionView{
    
}
@end
