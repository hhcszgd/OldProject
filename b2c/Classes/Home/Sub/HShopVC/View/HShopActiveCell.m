//
//  HShopActiveCell.m
//  b2c
//
//  Created by 0 on 16/5/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//



#import "HShopActiveCell.h"
#import "HShopActiveSubCell.h"
@interface HShopActiveCell()

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSMutableArray *dataArray;




@end
@implementation HShopActiveCell
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
}

- (UIPageControl *)page{
    if (_page == nil) {
        _page = [[UIPageControl alloc] init];
        [self addSubview:_page];
        [_page setValue:[UIImage imageNamed:@"icon_carousel_shop_nor"] forKey:@"pageImage"];
        [_page setValue:[UIImage imageNamed:@"icon_carousel_shop_sel"] forKey:@"currentPageImage"];

    }
    return _page;
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
        _col.pagingEnabled = YES;
        _col.delegate =self;
        _col.dataSource =self;
        [_col registerClass:[HShopActiveSubCell class] forCellWithReuseIdentifier:@"HShopActiveSubCell"];
        _col.showsHorizontalScrollIndicator = NO;
        
        
    }
    return _col;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.dataArray.count == 0) {
        [self removeTiemr];
    }
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HShopActiveSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HShopActiveSubCell" forIndexPath:indexPath];
    cell.subModel = self.dataArray[indexPath.row];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加col
        self.col.backgroundColor = [UIColor whiteColor];
        //添加page
        [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.equalTo(@(30));
        }];
        
    }
    return self;
}
#pragma mark -- 添加定时器
- (void)addTimer{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startScroll) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    }
}



#pragma mark -- 移除定时器
- (void)removeTiemr{
    do {
        [self.timer invalidate];
    } while (self.timer.valid);
  self.timer = nil;
    
}
#pragma mark -- 开始滚动
- (void)startScroll{
    NSIndexPath *currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    //滑动到第一组
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.col scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger  nextSection = currentIndexPathReset.section;
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    self.page.currentPage = nextItem;
    [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
   
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTiemr];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{//只有手动拖的时候才会被调用
    NSInteger i = self.dataArray.count * 2;
    if (scrollView.contentOffset.x >= (i * screenW)) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.col scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    NSInteger j = self.dataArray.count - 1;
    if (scrollView.contentOffset.x <= (j * screenW)) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:j inSection:1];
        [self.col scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    NSInteger k = (NSInteger)(scrollView.contentOffset.x/screenW) - self.dataArray.count;
    self.page.currentPage = k;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HStoreSubModel *activeModel = self.dataArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(HShopActiveCellActionToShopActiveWith:)]) {
        [self.delegate performSelector:@selector(HShopActiveCellActionToShopActiveWith:) withObject:activeModel];
    }
}




- (void)setBaseModel:(HStoreDetailModel *)baseModel{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:baseModel.items];
    [self.col reloadData];
    [self.col setScrollEnabled:NO];
    if (self.dataArray.count > 1) {
        [self addTimer];
        [self.col setScrollEnabled:YES];
        NSInteger i = self.dataArray.count;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.col.contentOffset = CGPointMake(i * screenW, 0);
        });
        self.page.numberOfPages = baseModel.items.count;
    }else {
        [self removeTiemr];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.col.contentOffset = CGPointMake(0, 0);
        });
        self.page.numberOfPages = baseModel.items.count;
    }
    
    
    
}



- (void)dealloc{
    self.col.delegate = nil;
    LOG(@"%@,%d,%@",[self class], __LINE__,@"销毁")
    
   
}



@end
