//
//  HShopCouponCell.m
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HShopCouponCell.h"
#import "HShopCouponSubCell.h"
@interface HShopCouponCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *col;

@property (nonatomic, strong) NSMutableArray *dataArray;




@end
@implementation HShopCouponCell
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
}


- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
        
        [self.contentView addSubview:_col];
        _col.scrollEnabled = YES;
        _col.delegate =self;
        _col.dataSource =self;
        _col.bounces = NO;
        _col.backgroundColor = [UIColor whiteColor];
        [_col registerClass:[HShopCouponSubCell class] forCellWithReuseIdentifier:@"HShopCouponSubCell"];
        _col.showsHorizontalScrollIndicator = NO;
        
        
    }
    return _col;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HShopCouponSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HShopCouponSubCell" forIndexPath:indexPath];
    cell.subModel = self.dataArray[indexPath.row];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(130 * SCALE , collectionView.frame.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)setBaseModel:(HStoreDetailModel *)baseModel{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:baseModel.items];
    [self.col reloadData];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HStoreSubModel *subModel = self.dataArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(HShopCouponCellActionToCouponsDeatilVCWith:)]) {
        [self.delegate performSelector:@selector(HShopCouponCellActionToCouponsDeatilVCWith:) withObject:subModel];
    }
}







@end
