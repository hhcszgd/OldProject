//
//  HFSHighSellerCommentCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFSHighSellerCommentCell.h"
#import "HFSHCommentCell.h"
@interface HFSHighSellerCommentCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/**布局类*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *col;
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/***/
@property (nonatomic, strong) UIPageControl *page;
@end
@implementation HFSHighSellerCommentCell
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
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , self.contentView.bounds.size.width, self.contentView.bounds.size.height- 30) collectionViewLayout:self.flowLayout];
        _col.delegate = self;
        _col.dataSource = self;
        [_col registerClass:[HFSHCommentCell class] forCellWithReuseIdentifier:@"HFSHCommentCell"];
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
- (UIPageControl *)page{
    if (_page == nil) {
        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [self.contentView addSubview:_page];
    }
    return _page;
}
- (void)configmentUI{
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.col setShowsHorizontalScrollIndicator:NO];
    [self.col setShowsVerticalScrollIndicator:NO];
    [self.col setScrollEnabled:YES];
    [self.col setPagingEnabled:YES];
    
    
#pragma mark -- 设置page
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
         make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    self.page.numberOfPages = 3;
    self.page.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    self.page.pageIndicatorTintColor = [UIColor whiteColor];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HFSHCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HFSHCommentCell" forIndexPath:indexPath];
    cell.dataArr = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(screenW, self.col.frame.size.height);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/screenW;
    self.page.currentPage = index;
}
- (void)setFactoryModel:(HFactoryBaseModel *)factoryModel{
    [self.dataArray removeAllObjects];
    for (NSInteger i = 0; i < 3; i++) {
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        for (NSInteger j = 0; j < 3; j++) {
            [modelArray addObject:factoryModel.items[i + j]];
        }
        [self.dataArray addObject:modelArray];
    }
    
    
    [self.col reloadData];
}
@end
