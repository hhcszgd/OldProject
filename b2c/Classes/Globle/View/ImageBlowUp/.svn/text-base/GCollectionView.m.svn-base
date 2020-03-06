//
//  GCollectionView.m
//  b2c
//
//  Created by 0 on 16/4/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GCollectionView.h"
#import "GCollectionCell.h"
#import "HStoreAptitudeModel.h"
@interface GCollectionView()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource,GestureRecognizerActionDelegate>
/**滑动视图*/
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**当前是第几页*/
@property (nonatomic, strong) UILabel *currentLabel;
/**数据源*/
@property (nonatomic, strong) NSArray *dataArr;


@end
@implementation GCollectionView

- (instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexPath withArr:(NSArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr = arr;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH) collectionViewLayout:flowLayout];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = collectionView;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[GCollectionCell class] forCellWithReuseIdentifier:@"GCollectionCell"];
        [self addSubview:collectionView];
        UILabel *number = [UILabel new];
        [self addSubview:number];
        
        [number mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.equalTo(@(60));
            make.height.equalTo(@(30));
        }];
        _currentLabel = number;
        [_currentLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] backColor:[UIColor colorWithWhite:0.5 alpha:0.5] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"%ld/%lu",indexPath.item + 1, (unsigned long)arr.count]];
        
        NSIndexPath *willIndex = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
        [collectionView scrollToItemAtIndexPath:willIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(screenW, screenH);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GCollectionCell" forIndexPath:indexPath];
    ;
    cell.model = _dataArr[indexPath.row];
    cell.delegate = self;
    return cell;
    
    
}
- (void)singleAction{
    if ([self.delegate respondsToSelector:@selector(hindleView:)]) {
        [self.delegate performSelector:@selector(hindleView:) withObject:self];
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger indexPath = scrollView.contentOffset.x/screenW;
    [_currentLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] backColor:[UIColor blackColor] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"%d / %d",indexPath + 1,_dataArr.count]];
}


@end
