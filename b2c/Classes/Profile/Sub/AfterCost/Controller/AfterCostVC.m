//
//  AfterCostVC.m
//  b2c
//
//  Created by wangyuanfei on 4/1/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AfterCostVC.h"
//#import "AfterCostCell.h"
//#import "AfterCostHeader.h"
//#import "AfterCostFooter.h"
//#import "AfterCostModel.h"
//#import "TotalOrderRefreshHeader.h"
//#import "TotalOrderRefreshAutoFooter.h"
@interface AfterCostVC ()//<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,editOrderDelegate>
//@property (nonatomic, strong) UICollectionView *col;
//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation AfterCostVC

//- (NSMutableArray *)dataArr{
//    if (_dataArr == nil) {
//        _dataArr = [[NSMutableArray alloc] init];
//        
//    }
//    return _dataArr;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originURL = self.keyParamete[@"paramete"];
//    for (NSInteger i = 0; i < 10; i++) {
//        AfterCostModel  *model = [[AfterCostModel alloc] init];
//        model.orderState = orderStatusRefundSuccess;
//        NSMutableArray *array = [NSMutableArray array];
//        NSInteger count = arc4random()%2 + 1;
//        for (NSInteger i = 0; i < count; i++) {
//            [array addObject:@"1"];
//        }
//        model.dataArr = array;
//        [self.dataArr addObject:model];
//    }
//    
//
//    
//    [self configmentCol];
    // Do any additional setup after loading the view.
}

//
//- (UICollectionViewFlowLayout *)flowLayout{
//    if (_flowLayout == nil) {
//        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        
//    }
//    return _flowLayout;
//}
//- (UICollectionView *)col{
//    if (_col == nil) {
//        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) collectionViewLayout:self.flowLayout];
//        [self.view addSubview:_col];
//    }
//    return _col;
//}
//
//
//
//- (void)configmentCol{
//    
//    self.col.backgroundColor = [UIColor whiteColor];
//    self.col.delegate = self;
//    self.col.dataSource = self;
//    [self.col registerClass:[AfterCostCell class] forCellWithReuseIdentifier:@"AfterCostCell"];
//    
//    [self.col registerClass:[AfterCostFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AfterCostFooter"];
//    [self.col registerClass:[AfterCostHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AfterCostHeader"];
//
//    [self.col setShowsVerticalScrollIndicator:NO];
//    self.col.backgroundColor = [UIColor whiteColor];
//    TotalOrderRefreshHeader *refreseHeader = [TotalOrderRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)] ;
//    self.col.mj_header = refreseHeader;
//    
//    TotalOrderRefreshAutoFooter *refreFooter = [TotalOrderRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
//    self.col.mj_footer = refreFooter;
//    
//}
//#pragma mark -- 下拉刷新
//- (void)refreshHeader{
//    [self.col.mj_header endRefreshing];
//}
//#pragma mark -- 上拉刷新
//- (void)refreshFooter{
//    [self.col.mj_footer endRefreshingWithNoMoreData];
//}
//- (void)footerRefresh{
//    [self.col.mj_footer endRefreshingWithNoMoreData];
//}
//
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.dataArr.count;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//   
//    
//    AfterCostModel *model = self.dataArr[section];
//    return model.dataArr.count;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//    
//    
//    
//    
//    AfterCostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AfterCostCell" forIndexPath:indexPath];
//    return cell;
//        
//   
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 2;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return CGSizeMake(screenW, 100);
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableView = nil;
//    
//    
//   
//        AfterCostModel *model = self.dataArr[indexPath.section];
//        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//            AfterCostHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AfterCostHeader" forIndexPath:indexPath];
//            header.section = indexPath.section;
//            header.orderModel = model;
//            reusableView = header;
//            
//        }else{
//            AfterCostFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AfterCostFooter" forIndexPath:indexPath];
//            footer.section = indexPath.section;
//            footer.orderModel = model;
//            footer.superView = collectionView;
//            
//            footer.delegate = self;
//            reusableView = footer;
//            
//        }
//    
//    
//    
//    
//    return  reusableView;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//   
//    if (section == (self.dataArr.count - 1 )) {
//            return CGSizeMake(screenW, 82);
//        }
//   
//    
//    
//    
//    
//    return CGSizeMake(screenW, 102);
//    
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(screenW, 40);
//}
//
//- (void)deleteOrder:(OrderBaseModel *)model section:(id)section{
//    NSInteger index = [section integerValue];
//    LOG(@"%@,%d,%ld",[self class], __LINE__,index)
//    
//    [self.dataArr removeObject:model];
//    
//    [self.col deleteSections:[NSIndexSet indexSetWithIndex:index]];
//    
//    for (NSInteger i = 0; i < self.dataArr.count; i++) {
//        [self.col reloadSections:[NSIndexSet indexSetWithIndex:i]];
//    }
//    
//    
//}
//

@end
