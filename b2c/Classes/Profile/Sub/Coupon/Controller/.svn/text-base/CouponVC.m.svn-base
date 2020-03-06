//
//  CouponVC.m
//  b2c
//
//  Created by wangyuanfei on 4/1/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "CouponVC.h"
#import "ConponSelectView.h"
#import "CouponBotttomCell.h"
@interface CouponVC ()//<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,ConponScrollToTargetDelegate>
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArr;


@property (nonatomic, weak) ConponSelectView *selectView;


@end

@implementation CouponVC
//- (NSMutableArray *)dataArr{
//    if (_dataArr == nil) {
//        _dataArr = [[NSMutableArray alloc] init];
//        
//    }
//    return _dataArr;
//}




//- (UICollectionViewFlowLayout *)flowLayout{
//    if (_flowLayout == nil) {
//        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        
//        
//    }
//    return _flowLayout;
//}
//- (UICollectionView *)col{
//    if (_col == nil) {
//        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY + 50, screenW, screenH - self.startY - 50) collectionViewLayout:self.flowLayout];
//        [self.view addSubview:_col];
//        [_col registerClass:[CouponBotttomCell class] forCellWithReuseIdentifier:@"CouponBotttomCell"];
//        _col.delegate =self;
//        _col.dataSource = self;
//        _col.pagingEnabled = YES;
//        [_col setShowsHorizontalScrollIndicator:NO];
//    }
//    return _col;
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.originURL = self.keyParamete[@"paramete"];
    
//    ConponSelectView *selectView = [[ConponSelectView alloc] initWithFrame:CGRectMake(0, self.startY + 5, screenW, 45)];
//    selectView.delegate = self;
//    [self.view addSubview:selectView];
//    selectView.leftStr = @"未使用(0)";
//    selectView.midleStr = @"已使用(8)";
//    selectView.rightStr = @"已过期(2)";
//    self.col.backgroundColor = BackgroundGray;
//    self.selectView = selectView;
    
    
    
    // Do any additional setup after loading the view.
}

-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}
#pragma mark -- 跳转到指定的页面
//- (void)scrollToTargetindexPath:(id)index{
//    LOG(@"%@,%d,%ld",[self class], __LINE__,[index integerValue])
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[index integerValue] inSection:0];
//    [self.col scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//}
//
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 3;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CouponBotttomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CouponBotttomCell" forIndexPath:indexPath];
//    switch (indexPath.row) {
//        case 0:
//        {
//            cell.isOrNo = YES;
//        }
//            break;
//         case 1:
//        {
//            cell.isOrNo = NO;
//        }
//            break;
//        case 2:
//        {
//            cell.isOrNo = YES;
//        }
//            break;
//            default:
//            break;
//    }
//    cell.backgroundColor = randomColor;
//    return cell;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return CGSizeMake(screenW, screenH - self.startY - 50);
//}
//#pragma -- mark 滑动cell红线跟随着被选中
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSInteger index = self.col.contentOffset.x/self.col.frame.size.width;
//    switch (index) {
//        case 0:
//        {
//            [self.selectView leftTap:self.selectView.leftTap];
//        }
//            break;
//        case 1:
//        {
//            [self.selectView midleTap:self.selectView.midleTap];
//        }
//            break;
//        case 2:
//        {
//            [self.selectView rightTap:self.selectView.rightTap];
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//}
//



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}



@end
