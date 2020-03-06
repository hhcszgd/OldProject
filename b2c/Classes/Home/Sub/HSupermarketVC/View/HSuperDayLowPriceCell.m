//
//  HSuperDayLowPriceCell.m
//  b2c
//
//  Created by 0 on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HSuperDayLowPriceCell.h"
#import "HDayLowPriceSubCell.h"
@interface HSuperDayLowPriceCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/**布局类*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *col;
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation HSuperDayLowPriceCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configmentUI];
    }
    return self;
}
/**懒加载*/
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , self.contentView.bounds.size.width, self.contentView.bounds.size.height ) collectionViewLayout:self.flowLayout];
        _col.delegate = self;
        _col.dataSource = self;
        [_col registerClass:[HDayLowPriceSubCell class] forCellWithReuseIdentifier:@"HDayLowPriceSubCell"];
        _col.backgroundColor = BackgroundGray;
        [self.contentView addSubview:_col];
    }
    return _col;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)configmentUI{
    [self.col setShowsHorizontalScrollIndicator:NO];
    [self.col setShowsVerticalScrollIndicator:NO];
    [self.col setScrollEnabled:YES];
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HDayLowPriceSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HDayLowPriceSubCell" forIndexPath:indexPath];
    cell.customModel =self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(141 * SCALE, self.col.bounds.size.height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(HSuperDayLowPriceCellActionToGoodsDetailWithSubModel:)]) {
        [self.delegate performSelector:@selector(HSuperDayLowPriceCellActionToGoodsDetailWithSubModel:) withObject:self.dataArray[indexPath.item]];
    }
}
- (void)setBaseModel:(HSuperBaseModel *)baseModel{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:baseModel.items];
    [self.col reloadData];
}
@end
