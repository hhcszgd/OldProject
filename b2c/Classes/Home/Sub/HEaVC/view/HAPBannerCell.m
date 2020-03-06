//
//  HAPBannerCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAPBannerCell.h"
#import "CustomCollectionCell.h"
@interface HAPBannerCell()

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSMutableArray *dataArray;




@end
@implementation HAPBannerCell
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
        _page.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"2fb4ef"];
        _page.pageIndicatorTintColor = [[UIColor colorWithHexString:@"ffffff"] colorWithAlphaComponent:0.7];
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
        [_col registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
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
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
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
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
         LOG(@"%@,%d,%@",[self class], __LINE__,self)
        //添加定时器
        [self addTimer];
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
    LOG(@"_%@_%d_---前---这个fuck定时器是不是有效的%d",[self class] , __LINE__,self.timer.valid);
    do {
        [self.timer invalidate];
        LOG(@"_%@_%d_---中----放在这个循环里来看这个fuck定时器是不是有效的%d",[self class] , __LINE__,self.timer.valid);
    } while (self.timer.valid );
    LOG(@"_%@_%d_-----后----在循环之后再看这个fuck定时器是不是有效的%d",[self class] , __LINE__,self.timer.valid);
    
    self.timer=nil;
    // LOG(@"_%d_%@",__LINE__,@"移除了定时器");
//    [self.timer invalidate];
//    
//    self.timer = nil;
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
    NSIndexPath *currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.col scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    self.page.currentPage =currentIndexPath.item ;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(HAPBannerCellActionToHEaActiveWithSubModel:)]) {
        [self.delegate performSelector:@selector(HAPBannerCellActionToHEaActiveWithSubModel:) withObject:self.dataArray[indexPath.item]];
    }
}

- (void)setBaseModel:(HEaBaseModel *)baseModel{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:baseModel.items];
    [self.col reloadData];
    self.page.numberOfPages = baseModel.items.count;
}

- (void)setChannelCellStyle:(cellStyle)channelCellStyle{
    switch (channelCellStyle) {
        case nationCellStyle:
        {
            self.page.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"ff7800"];
        }
            break;
        case eaCellStyle:
        {
            self.page.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"2fb4ef"];
        }
            break;
        default:
            break;
    }
}
-(void)dealloc{
    self.col.delegate = nil;
    LOG(@"%@,%d,%@",[self class], __LINE__,@"销毁")
}
@end
