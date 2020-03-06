//
//  PendingAppraiseVC.m
//  b2c
//
//  Created by wangyuanfei on 4/1/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PendingAppraiseVC.h"


//#import "PendingAppraiseCell.h"
//#import "PendingAppraiseFooter.h"
//#import "PendingAppraiseHeader.h"
//#import "PendingAppraiseModel.h"
//#import "GoodsModel.h"
//#import "GoodsCell.h"
//#import "GuessYouLikeHeader.h"
//#import "TotalOrderRefreshAutoFooter.h"
//#import "TotalOrderRefreshHeader.h"

@interface PendingAppraiseVC ()//<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,editOrderDelegate>
//@property (nonatomic, strong) UICollectionView *col;
//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//@property (nonatomic, strong) NSMutableArray *dataArr;



//@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation PendingAppraiseVC
//
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
//    _pageNumber = 1;
//    [[UserInfo shareUserInfo] gotGuessLikeDataWithPageNum:1 success:^(ResponseObject *responseObject) {
//        for (NSInteger i = 0; i < 10; i++) {
//            PendingAppraiseModel  *model = [[PendingAppraiseModel alloc] init];
//            model.orderState = orderStatusSuccessed;
//            NSMutableArray *array = [NSMutableArray array];
//            NSInteger count = arc4random()%2 + 1;
//            for (NSInteger i = 0; i < count; i++) {
//                [array addObject:@"1"];
//            }
//            model.dataArr = array;
//            [self.dataArr addObject:model];
//        }
//        NSArray *array = responseObject.data[@"items"];
//        NSMutableArray *arr = [NSMutableArray array];
//        for (NSDictionary *dic in array) {
//            
//            HCellComposeModel *goodsModel = [[HCellComposeModel alloc] initWithDict:dic];
//            [arr addObject:goodsModel];
//        }
//        [self.dataArr addObject:arr];
//        [self.col reloadData];
//    } failure:^(NSError *error) {
//        LOG(@"%@,%d,%@",[self class], __LINE__,error)
//    }];
//
//    
//    [self configmentCol];
    // Do any additional setup after loading the view.
}


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
//    [self.col registerClass:[PendingAppraiseCell class] forCellWithReuseIdentifier:@"PendingAppraiseCell"];
//    [self.col registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"GoodsCell"];
//    [self.col registerClass:[PendingAppraiseFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PendingAppraiseFooter"];
//    [self.col registerClass:[PendingAppraiseHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PendingAppraiseHeader"];
//    [self.col registerClass:[GuessYouLikeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader"];
//    [self.col setShowsVerticalScrollIndicator:NO];
//    self.col.backgroundColor = [UIColor whiteColor];
//    TotalOrderRefreshHeader *refreseHeader = [TotalOrderRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)] ;
//    self.col.mj_header = refreseHeader;
//    
//    TotalOrderRefreshAutoFooter *refreFooter = [TotalOrderRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
//    self.col.mj_footer = refreFooter;
//    
//}
//
///**下拉刷新*/
//- (void)refreshHeader{
//    
//    [[UserInfo shareUserInfo] gotGuessLikeDataWithPageNum:1 success:^(ResponseObject *responseObject) {
//        for (NSInteger i = 0; i < 2; i++) {
//            PendingAppraiseModel *model = [[PendingAppraiseModel alloc] init];
//            model.orderState = orderStatusSuccessed;
//            NSMutableArray *array = [NSMutableArray array];
//            NSInteger count = arc4random()%2 + 1;
//            for (NSInteger i = 0; i < count; i++) {
//                [array addObject:@"1"];
//            }
//            model.dataArr = array;
//            [self.dataArr insertObject:model atIndex:0];
//        }
//        [self.col.mj_header endRefreshing];
//        [self.col reloadData];
//    } failure:^(NSError *error) {
//        LOG(@"%@,%d,%@",[self class], __LINE__,error)
//    }];
//}
///**上拉刷新*/
//- (void)refreshFooter{
//    [[UserInfo shareUserInfo] gotGuessLikeDataWithPageNum:_pageNumber++ success:^(ResponseObject *responseObject) {
//        NSArray *array = responseObject.data[@"items"];
//        NSMutableArray *arr = [NSMutableArray array];
//        for (NSDictionary *dic in array) {
//            
//            HCellComposeModel *goodsModel = [[HCellComposeModel alloc] initWithDict:dic];
//            [arr addObject:goodsModel];
//        }
//        NSInteger index = self.dataArr.count- 1;
//        NSMutableArray *mutableArr = self.dataArr[index];
//        [mutableArr addObjectsFromArray:arr];
//        [self.col.mj_footer endRefreshing];
//        [self.col reloadData];
//    } failure:^(NSError *error) {
//        LOG(@"%@,%d,%@",[self class], __LINE__,error)
//    }];
//}
//
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.dataArr.count;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    if ((self.dataArr.count - 1) == section) {
//        NSMutableArray *mutableArr =  self.dataArr[section];
//        return mutableArr.count;
//    }
//    
//    
//    PendingAppraiseModel *model = self.dataArr[section];
//    return model.dataArr.count;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewCell *modelcell = nil;
//    
//    
//    
//    if ((self.dataArr.count - 1) == indexPath.section) {
//        GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
//        NSMutableArray *arr = self.dataArr[indexPath.section];
//        
//        cell.composeModel = arr[indexPath.row];
//        modelcell = cell;
//        
//    }else{
//        PendingAppraiseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PendingAppraiseCell" forIndexPath:indexPath];
//        
//        modelcell = cell;
//    }
//    return modelcell;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    if ((self.dataArr.count - 1)== section) {
//        return UIEdgeInsetsMake(0, 10, 0, 10);
//    }
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ((self.dataArr.count - 1)== indexPath.section) {
//        return CGSizeMake((screenW - 3 * 10)/2.0, 243 * SCALE);
//    }
//    return CGSizeMake(screenW, 100);
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableView = nil;
//    
//    
//    if ((self.dataArr.count - 1)== indexPath.section) {
//        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//            GuessYouLikeHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
//            reusableView = header;
//            
//        }else{
//            
//            
//        }
//    }else{
//        PendingAppraiseModel *model = self.dataArr[indexPath.section];
//        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//            PendingAppraiseHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PendingAppraiseHeader" forIndexPath:indexPath];
//            header.section = indexPath.section;
//            header.orderModel = model;
//            reusableView = header;
//            
//        }else{
//            PendingAppraiseFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PendingAppraiseFooter" forIndexPath:indexPath];
//            footer.section = indexPath.section;
//            footer.orderModel = model;
//            footer.superView = collectionView;
//            
//            footer.delegate = self;
//            reusableView = footer;
//            
//        }
//    }
//    
//    
//    
//    return  reusableView;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    if ((self.dataArr.count - 1)== section) {
//        return CGSizeMake(0, 0);
//    }else{
//        if (section == (self.dataArr.count - 2 )) {
//            return CGSizeMake(screenW, 82);
//        }
//    }
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
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ((self.dataArr.count - 1)== indexPath.section) {
//        return;
//#pragma mark 跳转到商品详情页面
//    }
////    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:@"订单详情" action:@"PAOrderDetailVC"];
//}


@end
