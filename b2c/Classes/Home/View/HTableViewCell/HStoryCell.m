//
//  HStoryCell.m
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HStoryCell.h"
#import "HStroyCollectCell.h"
//#import "HStroyCellCollectComposeView.h"
@interface HStoryCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UIView * container ;
@property(nonatomic,weak)UIImageView * hotImageView ;
@property(nonatomic,weak)UIView  * grayLine ;
@property(nonatomic,weak)UICollectionView * collectView ;
@property(nonatomic,strong)NSTimer * timer ;
@end

@implementation HStoryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * container = [[UIView alloc]init];
        self.container = container;
        container.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:container];
        
        //        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.top.right.equalTo(self.contentView);
        //            make.height.equalTo(@(35*SCALE));
        //        }];
        //        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(self);
        //            make.bottom.equalTo(self.container.mas_bottom);
        //        }];
        
        UIImageView * hotImageView = [[UIImageView alloc]init];
        self.hotImageView = hotImageView;
        [self.container addSubview:hotImageView];
        
        
        UIView * grayLine = [[UIView alloc]init];
        grayLine.backgroundColor = [UIColor colorWithRed:178/256.0 green:178/256.0 blue:178/256.0 alpha:1];
        self.grayLine = grayLine;
        [self.container addSubview:grayLine];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing=0;
        UICollectionView * collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        collectView.dataSource = self;
        collectView.delegate = self;
        //        collectView.userInteractionEnabled=NO;
        collectView.scrollEnabled=NO;
        [collectView registerClass:[HStroyCollectCell class] forCellWithReuseIdentifier:@"HStroyCollectCell"];
        collectView.pagingEnabled =YES;
        collectView.showsVerticalScrollIndicator=NO;
        collectView.backgroundColor = [UIColor whiteColor];
        self.collectView = collectView;
        [self.container addSubview:collectView];
        
        [self addTimer];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.container.frame  = self.bounds ;
    NSLog(@"\n\n\n\n\n\n\n\n\n\n\n\n");
    NSLog(@"%@", NSStringFromCGRect(self.frame)) ;
    CGFloat leftMargin = 10 ;
    CGFloat hotImgW  =  152/2.0 * SCALE;
    CGFloat hotImgH = 23 * SCALE;
    self.hotImageView.bounds =CGRectMake(0, 0, hotImgW, hotImgH);
    self.hotImageView.center = CGPointMake(leftMargin+hotImgW/2, self.bounds.size.height/2);
    
    CGFloat imgToGaryline = 7.5*SCALE;
    CGFloat lineW = 0.5 ;
    CGFloat lineH = 14*SCALE ;
    CGFloat lineX = CGRectGetMaxX(self.hotImageView.frame)+imgToGaryline ;
    CGFloat lineY = (self.bounds.size.height-lineH)/2 ;
    self.grayLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat lintToCollectView = imgToGaryline;
    CGFloat toRightScreenMargin = 20*SCALE;
    CGFloat collectViewW = self.bounds.size.width - CGRectGetMaxX(self.grayLine.frame)-lintToCollectView-toRightScreenMargin;
    CGFloat collectViewH = self.bounds.size.height;
    CGFloat collectViewX =CGRectGetMaxX(self.grayLine.frame)+lintToCollectView;
    CGFloat collectViewY = 0 ;
    self.collectView.frame = CGRectMake(collectViewX, collectViewY, collectViewW, collectViewH);
    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout * ) self.collectView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.collectView.bounds.size.width, self.collectView.bounds.size.height);
    
}

-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
    NSURL *url;
    if ([cellModel.imgStr hasPrefix:@"http"]) {
        url = [NSURL URLWithString:cellModel.imgStr];
    } else {
        url = ImageUrlWithString(cellModel.imgStr);
    }
    UIImage *image = [UIImage imageNamed:@"icon_new"];
    if (cellModel.isRefreshImageCached) {
        [self.hotImageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageRefreshCached completed:nil];
        cellModel.isRefreshImageCached = NO;
    }else {
        [self.hotImageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageRetryFailed completed:nil];
    }
    
    [self.collectView reloadData];
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
}

/** collectionView 的数据源方法 */

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{return 3;}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{return self.cellModel.items.count;}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HStroyCollectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HStroyCollectCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (cell == nil) {
        LOG(@"_%d_%@",__LINE__,@"未知错误");
    }
    cell.composeModel = self.cellModel.items[indexPath.item];
    //    cell.backgroundColor = randomColor;
    return cell;
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(startRoll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer=nil;
}
-(void)startRoll
{
    NSInteger currentIndex = (NSInteger)(self.collectView.contentOffset.y+1)/(NSInteger)self.collectView.bounds.size.height;
    NSInteger currentRowInSection  = currentIndex%self.cellModel.items.count;
    NSInteger currentSection = currentIndex/self.cellModel.items.count;
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:currentRowInSection inSection:currentSection];  //[[self.collectView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.collectView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.cellModel.items.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
#pragma mark crash sometimes('attempt to scroll to invalid index path: <NSIndexPath: 0xc000000000600116> {length = 2, path = 1 - 3}')
    [self.collectView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentIndex = (NSInteger)(self.collectView.contentOffset.y+1)/(NSInteger)self.collectView.bounds.size.height;
    NSInteger currentRowInSection  = currentIndex%self.cellModel.items.count;
    
    NSInteger currentSection = currentIndex/self.cellModel.items.count;
    LOG(@"_%@_%d_第%ld组,第%ld行",[self class] , __LINE__,currentSection,currentRowInSection)
    //    LOG(@"_%@_%d_第%ld组,第%ld行",[self class] , __LINE__,currentIndex,currentSection,
    
    
}
//-(void)didMoveToSuperview{
//     NSLog(@"🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱🌱_%d_%@",__LINE__,@"故事cell移入父控件了");
//}
/**
 fLayout.itemSize = CGSizeMake(screenW-leftViewW, leftViewH);
 fLayout.minimumLineSpacing = 0;
 fLayout.minimumInteritemSpacing=0;
 UICollectionView * rollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenW-leftViewW, leftViewH) collectionViewLayout:fLayout];
 _rollView = rollView;
 
 [rollView registerClass:[HotCellView class] forCellWithReuseIdentifier:@"updddown"];
 rollView.pagingEnabled =YES;
 rollView.dataSource=self;
 rollView.backgroundColor=[UIColor whiteColor];
 rollView.delegate = self;
 rollView.userInteractionEnabled=NO;
 */
@end























































////
////  HStoryCell.m
////  b2c
////
////  Created by wangyuanfei on 4/11/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "HStoryCell.h"
//#import "HStroyCollectCell.h"
////#import "HStroyCellCollectComposeView.h"
//@interface HStoryCell()<UICollectionViewDataSource,UICollectionViewDelegate>
//@property(nonatomic,weak)UIView * container ;
//@property(nonatomic,weak)UIImageView * hotImageView ;
//@property(nonatomic,weak)UIView  * grayLine ;
//@property(nonatomic,weak)UICollectionView * collectView ;
//@property(nonatomic,strong)NSTimer * timer ;
//@end
//
//@implementation HStoryCell
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        UIView * container = [[UIView alloc]init];
//        self.container = container;
//        container.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:container];
//        
//        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.equalTo(self.contentView);
//            make.height.equalTo(@(35*SCALE));
//        }];
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self);
//            make.bottom.equalTo(self.container.mas_bottom);
//        }];
//        
//        UIImageView * hotImageView = [[UIImageView alloc]init];
//        self.hotImageView = hotImageView;
//        [self.container addSubview:hotImageView];
//        hotImageView.image = [UIImage imageNamed:@"Shop story"];
//    
//        
//        UIView * grayLine = [[UIView alloc]init];
//        grayLine.backgroundColor = [UIColor colorWithRed:178/256.0 green:178/256.0 blue:178/256.0 alpha:1];
//        self.grayLine = grayLine;
//        [self.container addSubview:grayLine];
//        
//        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing=0;
//        UICollectionView * collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
//        collectView.dataSource = self;
//        collectView.delegate = self;
////        collectView.userInteractionEnabled=NO;
//        collectView.scrollEnabled=NO;
//        [collectView registerClass:[HStroyCollectCell class] forCellWithReuseIdentifier:@"HStroyCollectCell"];
//        collectView.pagingEnabled =YES;
//        collectView.showsVerticalScrollIndicator=NO;
//        collectView.backgroundColor = [UIColor whiteColor];
//        self.collectView = collectView;
//        [self.container addSubview:collectView];
//        
//        [self addTimer];
//    }
//    return self;
//}
//
//
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//    
//    CGFloat leftMargin = 10 ;
//    CGFloat hotImgW  =  68 * SCALE;
//    CGFloat hotImgH = 23 * SCALE;
//    self.hotImageView.bounds =CGRectMake(0, 0, hotImgW, hotImgH);
//    self.hotImageView.center = CGPointMake(leftMargin+hotImgW/2, self.bounds.size.height/2);
//    
//    CGFloat imgToGaryline = 7.5*SCALE;
//    CGFloat lineW = 0.5 ;
//    CGFloat lineH = 14*SCALE ;
//    CGFloat lineX = CGRectGetMaxX(self.hotImageView.frame)+imgToGaryline ;
//    CGFloat lineY = (self.bounds.size.height-lineH)/2 ;
//    self.grayLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
//    
//    CGFloat lintToCollectView = imgToGaryline;
//    CGFloat toRightScreenMargin = 20*SCALE;
//    CGFloat collectViewW = self.bounds.size.width - CGRectGetMaxX(self.grayLine.frame)-lintToCollectView-toRightScreenMargin;
//    CGFloat collectViewH = self.bounds.size.height;
//    CGFloat collectViewX =CGRectGetMaxX(self.grayLine.frame)+lintToCollectView;
//    CGFloat collectViewY = 0 ;
//    self.collectView.frame = CGRectMake(collectViewX, collectViewY, collectViewW, collectViewH);
//    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout * ) self.collectView.collectionViewLayout;
//    layout.itemSize = CGSizeMake(self.collectView.bounds.size.width, self.collectView.bounds.size.height);
//    
//}
//
//-(void)setCellModel:(HCellModel *)cellModel{
//    [super setCellModel:cellModel];
//    [self.collectView reloadData];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
//}
//
///** collectionView 的数据源方法 */
//
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{return 3;}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{return self.cellModel.items.count;}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    HStroyCollectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HStroyCollectCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//    if (cell == nil) {
//        LOG(@"_%d_%@",__LINE__,@"未知错误");
//    }
//    cell.composeModel = self.cellModel.items[indexPath.item];
////    cell.backgroundColor = randomColor;
//    return cell;
//}
//
//-(void)addTimer{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(startRoll) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
//}
//-(void)removeTimer{
//    [self.timer invalidate];
//    self.timer=nil;
//}
//-(void)startRoll
//{
//    NSInteger currentIndex = (NSInteger)(self.collectView.contentOffset.y+1)/(NSInteger)self.collectView.bounds.size.height;
//    NSInteger currentRowInSection  = currentIndex%self.cellModel.items.count;
//    NSInteger currentSection = currentIndex/self.cellModel.items.count;
//    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:currentRowInSection inSection:currentSection];  //[[self.collectView indexPathsForVisibleItems] lastObject];
//    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
//    [self.collectView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//    
//    NSInteger nextItem = currentIndexPathReset.item +1;
//    NSInteger nextSection = currentIndexPathReset.section;
//    if (nextItem==self.cellModel.items.count) {
//        nextItem=0;
//        nextSection++;
//    }
//    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
//#pragma mark crash sometimes('attempt to scroll to invalid index path: <NSIndexPath: 0xc000000000600116> {length = 2, path = 1 - 3}')
//    [self.collectView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSInteger currentIndex = (NSInteger)(self.collectView.contentOffset.y+1)/(NSInteger)self.collectView.bounds.size.height;
//    NSInteger currentRowInSection  = currentIndex%self.cellModel.items.count;
//    
//    NSInteger currentSection = currentIndex/self.cellModel.items.count;
//    LOG(@"_%@_%d_第%ld组,第%ld行",[self class] , __LINE__,currentSection,currentRowInSection)
////    LOG(@"_%@_%d_第%ld组,第%ld行",[self class] , __LINE__,currentIndex,currentSection,
//
//    
//}
///**
// fLayout.itemSize = CGSizeMake(screenW-leftViewW, leftViewH);
// fLayout.minimumLineSpacing = 0;
// fLayout.minimumInteritemSpacing=0;
// UICollectionView * rollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenW-leftViewW, leftViewH) collectionViewLayout:fLayout];
// _rollView = rollView;
// 
// [rollView registerClass:[HotCellView class] forCellWithReuseIdentifier:@"updddown"];
// rollView.pagingEnabled =YES;
// rollView.dataSource=self;
// rollView.backgroundColor=[UIColor whiteColor];
// rollView.delegate = self;
// rollView.userInteractionEnabled=NO;
// */
//@end
