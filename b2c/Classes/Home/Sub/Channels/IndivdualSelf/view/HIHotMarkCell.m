//
//  HIHotMarkCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HIHotMarkCell.h"
/**小cell*/
#import "HHotMarkSmallCell.h"
/**大cell*/
#import "HHotMarkSubBigCell.h"

@interface HIHotMarkCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/**布局类*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *col;
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSArray *cellArr;
/**大cell的宽度*/
@property (nonatomic, assign) CGFloat bigWidth;
/**小cell的宽度*/
@property (nonatomic, assign) CGFloat smallWidth;
@end
@implementation HIHotMarkCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _bigWidth = (screenW - 2 *10 )/2.0;
        _smallWidth = (screenW - 2 *10)/4.0;
        _cellArr = @[@"HHotMarkSubBigCell",@"HHotMarkSubBigCell",@"HHotMarkSmallCell",@"HHotMarkSmallCell",@"HHotMarkSmallCell",@"HHotMarkSmallCell",@"HHotMarkSmallCell",@"HHotMarkSmallCell",@"HHotMarkSmallCell",@"HHotMarkSmallCell"];
        [self configmentUI];
    }
    return self;
}
/**懒加载*/
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , self.contentView.bounds.size.width, self.contentView.bounds.size.height) collectionViewLayout:self.flowLayout];
        _col.delegate = self;
        _col.dataSource = self;
        [_col registerClass:[HHotMarkSmallCell class] forCellWithReuseIdentifier:@"HHotMarkSmallCell"];
        [_col registerClass:[HHotMarkSubBigCell class] forCellWithReuseIdentifier:@"HHotMarkSubBigCell"];
        _col.backgroundColor = [UIColor whiteColor];
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
    [self.col setScrollEnabled:NO];
    
    
    

}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cellArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellArr[indexPath.row] forIndexPath:indexPath];
    cell.model = [NSObject new];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_cellArr[indexPath.row] isEqualToString:@"HHotMarkSubBigCell"]) {
        
        
        return CGSizeMake(_bigWidth, _bigWidth);
    }
    
    if ([_cellArr[indexPath.row] isEqualToString:@"HHotMarkSmallCell"]) {
        
        return CGSizeMake(_smallWidth, _smallWidth);
    }
    return CGSizeMake(0, 0);
}

- (void)setModel:(id)model{
    [self.col reloadData];
}
@end
