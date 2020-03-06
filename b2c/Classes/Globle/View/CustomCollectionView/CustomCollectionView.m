//
//  CustomCollectionView.m
//  TTmall
//
//  Created by 0 on 16/3/24.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CustomCollectionCell.h"
@interface CustomCollectionView()

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSArray *data;



@end
@implementation CustomCollectionView

- (UIPageControl *)page{
    if (_page == nil) {
        _page = [[UIPageControl alloc] init];
        [self addSubview:_page];
    }
    return _page;
}
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        [self addSubview:_col];
    }
    return _col;
}

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor bottom:(CGFloat)bottom right:(CGFloat)right width:(CGFloat)width height:(CGFloat)height{
    self = [super initWithFrame:frame];
    if (self) {
        
        LOG(@"%@,%d,%ld",[self class], __LINE__,self.retainCount)
       
        self.col.backgroundColor = [UIColor blackColor];
        
        [self.col registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
        self.col.showsHorizontalScrollIndicator = NO;
        self.col.showsVerticalScrollIndicator = NO;
        self.col.pagingEnabled = YES;
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        self.col.dataSource = self;
        self.col.delegate = self;
        
        
        
        
        self.page.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        self.page.pageIndicatorTintColor = pageIndicatorTintColor;
        
        [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-bottom);
            make.centerX.equalTo(self.mas_centerX).offset(right);
             make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
        
        self.page.backgroundColor = [UIColor clearColor];
        
//        [self addTimer];
        LOG(@"%@,%d,%ld",[self class], __LINE__,self.retainCount)
        
        
    }
    return self;
}
#pragma collectionDelegate,collectionDatasource,flowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    self.page.numberOfPages = _data.count;//每次刷新都会重置
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    cell.model = _data[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(_col.bounds.size.width, _col.bounds.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//添加定时器
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startScro) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes ];
}
- (void)startScro{
    NSIndexPath *currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    LOG(@"%@,%d,%@",[self class], __LINE__,currentIndexPath)
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
//    LOG(@"%@,%d,%@",[self class], __LINE__,currentIndexPathReset)
    [self.col scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == _data.count) {
        nextItem = 0;
        nextSection++;
    }
    //设置当先page显示的点
    self.page.currentPage = nextItem;
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.col scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
    

    
    
    
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
    
}
//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
        [self removeTimer];
    
    
}
//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
        [self addTimer];
    
    
}
//减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSIndexPath *currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.col scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    self.page.currentPage = currentIndexPath.item;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    __weak typeof(self) Myself = self;
//    
//    if (Myself.customBlock) {
//        Myself.customBlock(Myself.data[indexPath.row]);
//    }
}

- (void)setDataArr:(NSArray *)dataArr{
    _data = dataArr;
    [self.col reloadData];
    self.page.numberOfPages = dataArr.count;
    if (dataArr.count == 1) {
        [self removeTimer];
        [self.col setScrollEnabled:NO];
        self.page.hidden = YES;
    }
    
}

- (void)dealloc{
    [self removeTimer];
    LOG(@"%@,%d,%@",[self class], __LINE__,@"循环关东销毁")
}





@end
