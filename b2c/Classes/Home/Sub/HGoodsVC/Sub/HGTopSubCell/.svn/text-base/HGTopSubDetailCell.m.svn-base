//
//  HGTopSubDetailCell.m
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGTopSubDetailCell.h"
#import "HGoodsBottomModel.h"
#import "HGoodsBottomSubModel.h"
#import "HGBSeeAndSeeHeader.h"
#import "CustomFRefresh.h"
#import "CustomFRefresh.h"
#import "GuessYouLikeHeader.h"
#import "HGBSellShowItem.h"
#import "HGBSeeAndSeeItem.h"
@interface HGTopSubDetailCell()
//@property (nonatomic, assign) NSInteger goodID;
//@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) NSMutableArray *cellArr;
//@property (nonatomic, strong) CustomFRefresh *refreshF;
//
//@property (nonatomic, assign) NSInteger page;
//@property (nonatomic, strong) CustomFRefresh *footerR;
//@property (nonatomic, strong) UIButton *scrowTop;
//
//
//@property (nonatomic, strong) UICollectionView *col;
//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end
@implementation HGTopSubDetailCell
//- (CustomFRefresh *)footerR{
//    if (_footerR == nil) {
//        _footerR = [CustomFRefresh footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    }
//    return _footerR;
//}
//
//- (UICollectionViewFlowLayout *)flowLayout{
//    if (_flowLayout == nil) {
//        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    }
//    return _flowLayout;
//}
//
//- (UICollectionView *)col{
//    if (_col == nil) {
//        _col = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
//        _col.delegate = self;
//        _col.dataSource = self;
//        [_col registerClass:[HGBSellShowItem class] forCellWithReuseIdentifier:@"HGBSellShowItem"];
//        [_col registerClass:[HGBSeeAndSeeItem class] forCellWithReuseIdentifier:@"HGBSeeAndSeeItem"];
//        [_col registerClass:[GuessYouLikeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader"];
//        [self.contentView addSubview:_col];
//    }
//    return _col;
//}
//
//- (UIButton *)scrowTop{
//    if (_scrowTop == nil) {
//        _scrowTop = [[UIButton alloc] init];
//        [self.contentView addSubview:_scrowTop];
//        [_scrowTop addTarget:self action:@selector(scrowToTop:) forControlEvents:UIControlEventTouchUpInside];
//        [_scrowTop setBackgroundImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
//        _scrowTop.hidden = YES;
//    }
//    return _scrowTop;
//}
///**滑动到顶部*/
//- (void)scrowToTop:(UIButton *)btn{
//    
//    [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//}
//
//
//
//- (NSMutableArray *)cellArr{
//    if (_cellArr == nil) {
//        _cellArr = [[NSMutableArray alloc] init];
//        
//    }
//    return _cellArr;
//}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.dataArray.count;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    HGoodsBottomModel *baseModel = self.dataArray[section];
//    if ([baseModel.key isEqualToString:@"deatil"]) {
//        return baseModel.items.count;
//    }
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        return baseModel.items.count;
//    }
//    return 0;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *myCell = nil;
//    HGoodsBottomModel *baseModel = self.dataArray[indexPath.section];
//    if ([baseModel.key isEqualToString:@"deatil"]) {
//        HGBSellShowItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HGBSellShowItem" forIndexPath:indexPath];
//        
//        cell.subModel = baseModel.items[indexPath.item];
//        myCell = cell;
//    }
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        HGBSeeAndSeeItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HGBSeeAndSeeItem" forIndexPath:indexPath];
//        cell.subModel = baseModel.items[indexPath.item];
//        myCell = cell;
//    }
//    
//    return myCell;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    HGoodsBottomModel *baseModel = self.dataArray[indexPath.section];
//    if ([baseModel.key isEqualToString:@"deatil"]) {
//        HGoodsBottomSubModel *subModel = baseModel.items[indexPath.row];
//        if (subModel.width && subModel.height) {
//            CGFloat width = [subModel.width floatValue];
//            CGFloat height = [subModel.height floatValue];
//            CGFloat proport = height/width;
//            return CGSizeMake(screenW, proport * screenW);
//        }else{
//            return CGSizeMake(screenW, screenW);
//        }
//        
//    }
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        return CGSizeMake((screenW -30)/2.0, 234 * SCALE);
//    }
//    return CGSizeMake(0, 0);
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    HGoodsBottomModel *baseModel = self.dataArray[section];
//    if ([baseModel.key isEqualToString:@"deatil"]) {
//        return 1;
//    }
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        return 10;
//    }
//    return 0;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    HGoodsBottomModel *baseModel = self.dataArray[section];
//    if ([baseModel.key isEqualToString:@"deatil"]) {
//        return 0;
//    }
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        return 10;
//    }
//    return 0;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    HGoodsBottomModel *baseModel = self.dataArray[section];
//    if ([baseModel.key isEqualToString:@"deatil"]) {
//        return UIEdgeInsetsMake(10, 0, 10, 0);
//    }
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        return UIEdgeInsetsMake(10, 10, 10, 10);
//    }
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    HGoodsBottomModel *baseModel = self.dataArray[indexPath.section];
//    
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        HGoodsBottomSubModel *subModel = baseModel.items[indexPath.item];
//        subModel.actionKey = @"HGoodsVC";
//        subModel.keyParamete = @{@"paramete":subModel.good_id};
//        if ([self.delegate respondsToSelector:@selector(clickGoodsActionToTheGoodsDetailVCWith:)]) {
//            [self.delegate performSelector:@selector(clickGoodsActionToTheGoodsDetailVCWith:) withObject:subModel];
//        }
//    }
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        HGoodsBottomModel *baseModel = self.dataArray[indexPath.section];
//        if ([baseModel.key isEqualToString:@"deatil"]) {
//            GuessYouLikeHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
//            header.backgroundColor = [UIColor whiteColor];
//            header.guessLabel.text = @"图文详情";
//            return header;
//        }
//        if ([baseModel.key isEqualToString:@"lookagain"]) {
//            GuessYouLikeHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
//            header.backgroundColor = [UIColor whiteColor];
//            return header;
//        }
//        
//    }
//    return nil;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    HGoodsBottomModel *baseModel = self.dataArray[section];
//    if ([baseModel.key isEqualToString:@"deatil"]) {
//        return CGSizeMake(screenW, 40);
//    }
//    if ([baseModel.key isEqualToString:@"lookagain"]) {
//        return CGSizeMake(screenW, 40);
//    }
//    return CGSizeMake(0, 0);
//}
//
//
//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.page = 1;
//        self.isFirst = YES;
//        self.col.backgroundColor = BackgroundGray;
//        [self.scrowTop mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView.mas_right).offset(-10);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-40);
//            make.width.equalTo(@(44));
//            make.height.equalTo(@(44));
//        }];
//        
//    }
//    return self;
//}
//
//
//
//
//#pragma mark -- 赋值
//- (void)setData:(NSMutableArray *)data{
//    self.dataArray = data;
//    if (self.dataArray.count > 0) {
//        self.col.mj_footer = self.footerR;
//    }
//    [self.col reloadData];
//}
//
//
//- (void)setGoods_id:(NSInteger)goods_id{
//    //存放商品ID
//    self.goodID = goods_id;
//    
//}
//- (void)loadMoreData{
//    self.page++;
//    [[UserInfo shareUserInfo] gotProductSeeAndSeeWithGoodid:self.goodID page:self.page success:^(ResponseObject *responseObjec) {
//        [self anlayseWithData:responseObjec];
//    } failure:^(NSError *error) {
//#pragma mark 添加请求失败处理
//    }];
//}
//
////#pragma  mark -- 处理数据
//
//#pragma mark -- 处理数据
//- (void)anlayseWithData:(ResponseObject*)response{
//    LOG(@"%@,%d,%@",[self class], __LINE__,response.data)
//    
//    HGoodsBottomModel *seconModel = [self.dataArray lastObject];
//    NSInteger count = seconModel.items.count;
//    if ([response.data isKindOfClass:[NSArray class]]) {
//        
//        
//    }
//    if ([response.data isKindOfClass:[NSDictionary class]]) {
//        
//        HGoodsBottomModel *baseModel = [HGoodsBottomModel mj_objectWithKeyValues:response.data];
//        HGoodsBottomModel *seconModel = [self.dataArray lastObject];
//        [seconModel.items addObjectsFromArray:baseModel.items];
//        
//    }
//    HGoodsBottomModel *baseModel = [self.dataArray lastObject];
//        [self.col.mj_footer endRefreshing];
//        if (baseModel.items.count == count) {
//            [self.col.mj_footer endRefreshingWithNoMoreData];
//        }
//    [self.col reloadData];
//    
//    
//}
//
//
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (self.col.contentOffset.y >   self.contentView.bounds.size.height) {
//        self.scrowTop.hidden = NO;
//    }else{
//        self.scrowTop.hidden = YES;
//    }
//}

@end
