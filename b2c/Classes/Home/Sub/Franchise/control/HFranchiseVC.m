//
//  HFranchiseVC.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

/**hotbrand的布局属性*/
#define brandleft 0
#define brandright 0
#define brandline 1
#define brandinter 1
#define brandtop 2
#define brandbottom 2
#define brandWidth (screenW - brandleft - brandright - 3 * brandinter)/4.0f
#define brandheight 46 *SCALE
/**优质厂家推荐布局*/
#define heightSellLeft 0
#define heightSeellRight 0
#define heightSellInter 1
#define heightSellLine 1
#define heightSellTop 2
#define heightSellBottom 2
#define heightSellWidth (screenW - heightSeellRight - heightSellLeft - 2 * heightSellInter)/3.0f
#define heightSellHeight 166 *SCALE
/**优惠券布局*/
#define couponLeft 0
#define couponright 0
#define couponInter 1
#define couponLine 1
#define couponTop 2
#define couponBottom 2
#define couponwidth (screenW - couponLeft - couponright -  couponInter)/2.0f
#define couponHeight 75.5 * SCALE
/**猜你喜欢*/
#define guessLeft 10
#define guessright 10
#define guessinter 10
#define guessline 10
#define guessTop 0
#define guessBottem 0
#define guesswidth (screenW - guessLeft - guessright - guessinter)/2.0f
#define guessheght 234 * SCALE
#pragma mark -- 超值特卖
#define overSellHeight 160
#define overSellTop 2
#define overSellBottom 2
#pragma 轮播图
#define bannerHeight 150 * SCALE
#import "GuessYouLikeHeader.h"
#import "HFranchiseVC.h"
///**baner*/
//#import "HFranBannerCell.h"
///**组头*/
//#import "HFranchiseHeader.h"
///**热门品牌*/
//#import "HFranHotBrandCell.h"
///**超值特卖*/
//#import "HFranOverflowSellCell.h"
///**优质厂家推荐*/
//#import "HFranHeightSellCommentCell.h"
///**优惠券*/
//#import "HFranCouponCell.h"
//#import "HFGuessYouLikeCell.h"
//#import "HFranchiseBaseModel.h"
//#import "CustomFRefresh.h"
@interface HFranchiseVC ()
//<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, HFranBannerCellDelegate,HFranOverflowSellCellDelegate>
///**数据源数组*/
//@property (nonatomic, strong) NSMutableArray *dataArray;
///**临时数组存放cell*/
//@property (nonatomic, strong) NSMutableArray *cellArray;
//@property (nonatomic, weak) HFranBannerCell *bannerCell;


@end

@implementation HFranchiseVC

//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
//
//
//
//- (NSMutableArray *)cellArray{
//    if (_cellArray == nil) {
//        _cellArray = [[NSMutableArray alloc] init];
//        
//    }
//    return _cellArray;
//}
//#pragma mark -- 加载更多
//- (void)upRefresh{
//    
//    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"100" PageNum:self.pageNumber success:^(ResponseObject *responseObject) {
//        NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);
//
//        [self dealGuessYoulikeDataUnusualWith:responseObject];
//        self.pageNumber++;
//    } failure:^(NSError *error) {
//        [self.col.mj_footer endRefreshing];
//        [self.col.mj_footer endRefreshing];
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarRightActionViews:@[self.shopCarBtn]];
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];
}
//- (void)downRefresh{
//    self.pageNumber = 1;
//    
//    [[UserInfo shareUserInfo] gotFranchisesuccess:^(ResponseObject *response) {
//        [self.dataArray removeAllObjects];
//        [self.cellArray removeAllObjects];
//        [self dealDataUnusualWith:response];
//         self.col.mj_footer.state = MJRefreshStateIdle;
//        
//    } failure:^(NSError *error) {
//        //请求猜你喜欢
//        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
//    }];
//}
//
//
//- (void)reconnectClick:(UIButton *)sender{
//    self.pageNumber = 1;
//    [[UserInfo shareUserInfo] gotFranchisesuccess:^(ResponseObject *response) {
//        [self.dataArray removeAllObjects];
//        [self.cellArray removeAllObjects];
//
//        [self dealDataUnusualWith:response];
//        [self removeTheViewWhenConnect];
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}
///**排除数据异常*/
//- (void)dealDataUnusualWith:(ResponseObject *)response{
//    NSLog(@"%@, %d ,%@",[self class],__LINE__,response.data);
//
//    //判断是否返回数据
//    if (response.data) {
//        self.col.mj_footer = self.refreshFooter;
//        //返回值是数组的形式
//        if ([response.data isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in response.data) {
//                HFranchiseBaseModel *baseModel = [HFranchiseBaseModel mj_objectWithKeyValues:dic];
//                //不存在的话
//                if ([self selectWantDataAddDataArrayWithKey:baseModel.key]) {
//                    if (baseModel.items && (baseModel.items.count >0)) {
//                        [self selectCellByKey:baseModel.key];
//                        [self.dataArray addObject:baseModel];
//                    }
//                }
//                
//
//            }
//            HFranchiseBaseModel *guessLike = [[HFranchiseBaseModel alloc] init];
//            [self selectCellByKey:@"guesslike"];
//            guessLike.items =  [NSMutableArray array];
//            [self.dataArray addObject:guessLike];
//            [self.col.mj_header endRefreshing];
//        }
//    }else{
//        [self.col.mj_header endRefreshing];
//        
//        
//    }
//    [self.col reloadData];
//    
//}
///**处理猜你喜欢数据的异常*/
//- (void)dealGuessYoulikeDataUnusualWith:(ResponseObject *)responseObject{
//    self.col.mj_footer = self.refreshFooter;
//    if (responseObject.status > 0) {
//        if (!responseObject.data) {
//            [self.col.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            HFranchiseBaseModel *guessLike = [HFranchiseBaseModel mj_objectWithKeyValues:responseObject.data];
//            if (!guessLike.items) {
//                
//            }else{
//
//                HFranchiseBaseModel *baseModel = [self.dataArray lastObject];
//                [baseModel.items addObjectsFromArray:guessLike.items];
//            }
//            
//            //如果数组的值不再改变那么就是没有数据了
//            
//            [self.col.mj_footer endRefreshing];
//            
//           
//            
//        }
//    }else{
//        [self.col.mj_footer endRefreshingWithNoMoreData];
//    }
//    
//    
//    
//    [self.col reloadData];
//}
///**有选择的挑选数据加入数据源中*/
//- (BOOL)selectWantDataAddDataArrayWithKey:(NSString *)key{
//    if ([key isEqualToString:@"banner"]) {
//        return YES;
//    }else if ([key isEqualToString:@"brand"]) {
//        return YES;
//    }else if ([key isEqualToString:@"overvalue"]) {
//        return YES;
//    } if ([key isEqualToString:@"recommend"]) {
//        return YES;
//    }
//    if ([key isEqualToString:@"coupons"]) {
//        return YES;
//    } if ([key isEqualToString:@"guesslike"]) {
//        return YES;
//    }
//    return NO;
//}
//
//
//#pragma --mark根据key值确定需要的cell
//- (void)selectCellByKey:(NSString *)key{
//  
//    if ([key isEqualToString:@"banner"]) {
//        [self.cellArray addObject:@"HFranBannerCell"];
//    }
//    if ([key isEqualToString:@"brand"]) {
//        [self.cellArray addObject:@"HFranHotBrandCell"];
//    }
//    if ([key isEqualToString:@"overvalue"]) {
//        [self.cellArray addObject:@"HFranOverflowSellCell"];
//    }
//    if ([key isEqualToString:@"recommend"]) {
//        [self.cellArray addObject:@"HFranHeightSellCommentCell"];
//    }
//    if ([key isEqualToString:@"coupons"]) {
//        [self.cellArray addObject:@"HFranCouponCell"];
//    }
//    if ([key isEqualToString:@"guesslike"]) {
//        [self.cellArray addObject:@"HFGuessYouLikeCell"];
//    }
//}
//
//
//#pragma mark --
//- (void)actionToSearch:(ActionBaseView *)searchView{
//    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
//}
//
//
//
//#pragma mark --  底层主视图
//- (void)configmentUI{
//    self.col.delegate = self;
//    self.col.dataSource = self;
//    [self.col registerClass:[HFranBannerCell class] forCellWithReuseIdentifier:@"HFranBannerCell"];
//    [self.col registerClass:[HFranHotBrandCell class] forCellWithReuseIdentifier:@"HFranHotBrandCell"];
//    [self.col registerClass:[HFranOverflowSellCell class] forCellWithReuseIdentifier:@"HFranOverflowSellCell"];
//    [self.col registerClass:[HFranHeightSellCommentCell class] forCellWithReuseIdentifier:@"HFranHeightSellCommentCell"];
//    [self.col registerClass:[HFranCouponCell class] forCellWithReuseIdentifier:@"HFranCouponCell"];
//    [self.col registerClass:[HFGuessYouLikeCell class] forCellWithReuseIdentifier:@"HFGuessYouLikeCell"];
//    [self.col registerClass:[HFranchiseHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HFranchiseHeader"];
//    [self.col registerClass:[GuessYouLikeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader"];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    // Dispose of any resources that can be recreated.
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.dataArray.count;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    
//    if ([self.cellArray[section] isEqualToString:@"HFranHotBrandCell"]){
//        HFranchiseBaseModel *model = self.dataArray[section];
//        return model.items.count;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranHeightSellCommentCell"]){
//        HFranchiseBaseModel *model = self.dataArray[section];
//        return model.items.count;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranCouponCell"]){
//        HFranchiseBaseModel *model = self.dataArray[section];
//        return model.items.count;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]){
//        HFranchiseBaseModel *model = self.dataArray[section];
//        return model.items.count;
//    }
//    
//    
//    
//    
//    return 1;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    HFranchiseBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellArray[indexPath.section] forIndexPath:indexPath];
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHotBrandCell"]) {
//        HFranchiseBaseModel *baseModel = self.dataArray[indexPath.section];
//        
//        cell.customModel = baseModel.items[indexPath.row];
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHeightSellCommentCell"]){
//        HFranchiseBaseModel *baseModel = self.dataArray[indexPath.section];
//        cell.customModel = baseModel.items[indexPath.row];
//    } else if ([self.cellArray[indexPath.section] isEqualToString:@"HFranCouponCell"]) {
//        HFranchiseBaseModel *baseModel = self.dataArray[indexPath.section];
//        cell.customModel = baseModel.items[indexPath.row];
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HFGuessYouLikeCell"]) {
//        HFranchiseBaseModel *baseModel = self.dataArray[indexPath.section];
//        cell.customModel = baseModel.items[indexPath.row];
//    } else{
//        cell.baseModel = self.dataArray[indexPath.section];
//    }
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranBannerCell"]) {
//        HFranBannerCell *bannerCell = (HFranBannerCell*)cell;
//        if (self.bannerCell != cell) {
//            [self.bannerCell removeTiemr];
//            self.bannerCell = nil;
//            self.bannerCell = bannerCell;
//        }
//        bannerCell.delegate = self;
//        
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranOverflowSellCell"]) {
//        HFranOverflowSellCell *overCell = (HFranOverflowSellCell *)cell;
//        overCell.delegate = self;
//    }
//    
//    
//    return cell;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//   
//    
//    
//    if ([self.cellArray[section] isEqualToString:@"HFranHotBrandCell"]){
//        
//        return brandinter;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranHeightSellCommentCell"]){
//        return heightSellInter;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranCouponCell"]){
//        return couponInter;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]){
//        return guessinter;
//    }
//    return 0;
//}
////
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    
//    if ([self.cellArray[section] isEqualToString:@"HFranHotBrandCell"]){
//        return brandline;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranHeightSellCommentCell"]){
//        return heightSellLine;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranCouponCell"]){
//        return couponLine;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]){
//        return guessline;
//    }
//    return 0;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//   
//    if ([self.cellArray[section] isEqualToString:@"HFranHotBrandCell"]){
//        return UIEdgeInsetsMake(brandtop, brandleft, brandbottom, brandright);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranHeightSellCommentCell"]){
//        return UIEdgeInsetsMake(heightSellTop, heightSellLeft, heightSellBottom, heightSeellRight);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranCouponCell"]){
//        return UIEdgeInsetsMake(couponTop, couponLeft, couponBottom, couponright);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]){
//        return UIEdgeInsetsMake(guessTop, guessLeft, guessBottem, guessright);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranOverflowSellCell"]) {
//        return UIEdgeInsetsMake(overSellTop, 0, overSellBottom, 0);
//    }
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranBannerCell"]) {
//        return CGSizeMake(screenW, bannerHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHotBrandCell"]) {
//        return CGSizeMake(brandWidth, brandheight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranOverflowSellCell"]){
//        return CGSizeMake(screenW , overSellHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHeightSellCommentCell"]) {
//        return CGSizeMake(heightSellWidth,heightSellHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranCouponCell"]){
//        return CGSizeMake(couponwidth, couponHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFGuessYouLikeCell"]) {
//        return CGSizeMake(guesswidth, guessheght);
//    }
//    
//    return CGSizeMake(0, 0);
//    
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"%@, %d ,%@",[self class],__LINE__,self.cellArray[indexPath.section]);
//
////    UICollectionReusableView *reusableview;
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHotBrandCell"]) {
//        HFranchiseHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        return header;
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HFranOverflowSellCell"]) {
//        HFranchiseHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        return header;
//        
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHeightSellCommentCell"]) {
//        HFranchiseHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        return header;
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HFranCouponCell"]) {
//        HFranchiseHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        return header;
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HFGuessYouLikeCell"]) {
//        
//        GuessYouLikeHeader *likeHeader =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
//        return likeHeader;
//    }
//    
//    return nil;
//
//}
//- (HFranchiseHeader *)collectionview:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath{
//    HFranchiseHeader *header =[collectionview dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HFranchiseHeader" forIndexPath:indexPath];
//    HFranchiseBaseModel *baseModel = self.dataArray[indexPath.section];
//    header.baseModel = baseModel;
//    return header;
//
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//    CGSize size = CGSizeMake(0, 0);
//    if ([self.cellArray[section] isEqualToString:@"HFranHotBrandCell"]) {
//        size = CGSizeMake(screenW, 36 * SCALE);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranOverflowSellCell"]) {
//        size = CGSizeMake(screenW, 36 * SCALE);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranHeightSellCommentCell"]) {
//        size = CGSizeMake(screenW, 36 * SCALE);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFranCouponCell"]) {
//        
//        size = CGSizeMake(screenW, 36 * SCALE);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]) {
//        
//        size = CGSizeMake(screenW, 44 * SCALE);
//    }
//    return size;
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    HFranchiseBaseModel *baseModel = self.dataArray[indexPath.section];
//    CustomCollectionModel *subModel = baseModel.items[indexPath.item];
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranBannerCell"]) {
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHotBrandCell"]) {
//        subModel.actionKey = @"HShopVC";
//        subModel.keyParamete = @{@"paramete":subModel.shop_id};
//        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranOverflowSellCell"]){
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranHeightSellCommentCell"]) {
//        subModel.keyParamete = @{@"paramete":subModel.ID};
//        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFranCouponCell"]){
//        subModel.actionKey = @"CouponsDetailVC";
//        subModel.keyParamete = @{@"paramete":subModel.ID};
//        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HFGuessYouLikeCell"]) {
//        subModel.keyParamete = @{@"paramete":subModel.ID};
//        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//    }
//}
//#pragma mark -- 跳转到活动页面
//- (void)HFranBannerCellActionToActiveWithSubModel:(CustomCollectionModel *)subModel{
//    if ([subModel.actionKey isEqualToString:@"HGoodsVC"]) {
//        subModel.actionKey = @"HGoodsVC";
//    }
//    if ([subModel.actionKey isEqualToString:@"HShopVC"]) {
//        subModel.actionKey = @"HShopVC";
//    }
//    if ([subModel.actionKey isEqualToString:@"webpage"]) {
//        subModel.actionKey = @"HDirectActiveVC";
//        
//    }
//    if (subModel.link) {
//        if (subModel.link.length > 0) {
//            subModel.keyParamete = @{@"paramete":subModel.link};
//            
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//        }
//    }
//}
//#pragma mark -- 跳转到商品详情页面
//- (void)HFranOverflowSellCellActionToGoodsDetailWithSubModel:(CustomCollectionModel *)subModel{
//    subModel.keyParamete = @{@"paramete":subModel.ID};
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//    
//}
//

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.bannerCell removeTiemr];
//    self.bannerCell = nil;
}

@end
