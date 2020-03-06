//
//  HBabyVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#define SeasonHotTop 2
#define SeasonHotLeft 0
#define SeasonHotBottom 10
#define SeasonHotRight 0
#define SeasonHotInter 1
#define SeasonHotLine 1
#define SeasonHotWidth (screenW -  SeasonHotInter)/2.0
#define SeasonHotHeight 168 * SCALE

/**滚动*/
#define bannerBottom 0
/**好妈妈*/
#define goodsMotherTop  2
#define goodsMotherLeft 0
#define goodsMotherBottom 10
#define goodsMotherRight 0
#define goodsMotherline
#define goodsMotherInter 1
#define goodsMothterWidth (screenW - 2 * goodsMotherInter)/3.0
#define goodsMotherHeight 170 * SCALE
//返现好店
#define reconmentTop 2
#define reconmentLeft 0
#define reconmentBottom 10
#define reconmentRight 0
#define reconmentInter 1
#define goodShopWidth (screenW - 2 *reconmentInter )/3.0
#define goodShopHeight 155 * SCALE
//超值特卖
#define overFellowTop 0
#define overFellowLeft 0
#define overFellowBottom 10
#define overFellowRight 0
#define overFellowWidth screenW
#define overFellowHeight 155 * SCALE
//优惠券
#define couponWidth (screenW - 2)/2.0f
#define couponHeight 75.5 * SCALE
//猜你喜欢
#define guessTop 0
#define guessLeft 10
#define guessBottom 0
#define guessRight 10
#define guessInter 10
#define guessLine 10
#define guessHeight 233 * SCALE
#define guessWidth (screenW - guessLeft -guessRight- guessInter)/2.0
#import "HBabyVC.h"
///**baner*/
//#import "HBBannerCell.h"
///**组头*/
//#import "HBabyGirlHeader.h"
///**好妈妈*/
//#import "HBGoodMothterCell.h"
///**当季热卖*/
//#import "HBSeasonHotSell.h"
///**超值特卖*/
//#import "HBOverflowSellCell.h"
///**推荐好店*/
//#import "HBRecomentGoodShopCell.h"
///**优惠券*/
//#import "HBCouponCell.h"
///**猜你喜欢*/
//#import "GuessYouLikeCollectionCell.h"
//#import "CustomFRefresh.h"
@interface HBabyVC()
//<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HBOverflowSellCellDelegate,HBBannerCellDelegate>
///**数据源数组*/
//@property (nonatomic, strong) NSMutableArray *dataArray;
///**临时数组存放cell*/
//@property (nonatomic, strong) NSMutableArray *cellArray;
///**当季热卖的组头*/
//@property (nonatomic, strong) HBabyGirlHeader *sellHotHeader;
//@property (nonatomic, strong) HBBannerCell *bannerCell;
@end

@implementation HBabyVC


//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
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
//    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"103" PageNum:self.pageNumber success:^(ResponseObject *responseObject) {
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
//    [[UserInfo shareUserInfo] gotBabySuccess:^(ResponseObject *response) {
//        [self.dataArray removeAllObjects];
//        [self.cellArray removeAllObjects];
//        [self dealDataUnusualWith:response];
//         self.col.mj_footer.state = MJRefreshStateIdle;
//        
//    } failure:^(NSError *error) {
//        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
//        
//    }];
//}
//
//
//- (void)reconnectClick:(UIButton *)sender{
//    self.pageNumber =1;
//    [[UserInfo shareUserInfo] gotBabySuccess:^(ResponseObject *response) {
//        [self.dataArray removeAllObjects];
//        [self.cellArray removeAllObjects];
//        [self dealDataUnusualWith:response];
//        [self removeTheViewWhenConnect];
//        
//    } failure:^(NSError *error) {
//        //请求猜你喜欢
//        
//    }];
//}
///**排除数据异常*/
//- (void)dealDataUnusualWith:(ResponseObject *)response{
//    
//    //判断是否返回数据
//    if (response.data) {
//        self.col.mj_footer = self.refreshFooter;
//        //返回值是数组的形式
//        if ([response.data isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in response.data) {
//                HBabyBaseModel *baseModel = [HBabyBaseModel mj_objectWithKeyValues:dic];
//                //不存在的话
//                if ([self selectWantDataAddDataArrayWithKey:baseModel.key]) {
//                    if (baseModel.items && (baseModel.items.count >0)) {
//                        [self selectCellByKey:baseModel.key];
//                        [self.dataArray addObject:baseModel];
//                    }
//
//                }
//                
//            }
//            HBabyBaseModel *guessLike = [[HBabyBaseModel alloc] init];
//            [self selectCellByKey:@"guesslike"];
//            guessLike.items =  [NSMutableArray array];
//            [self.dataArray addObject:guessLike];
//            
//            
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
//            HBabyBaseModel *guessLike = [HBabyBaseModel mj_objectWithKeyValues:responseObject.data];
//            if (!guessLike.items) {
//                
//            }else{
//                HBabyBaseModel *baseModel = [self.dataArray lastObject];
//                [baseModel.items addObjectsFromArray:guessLike.items];
//            }
//            
//            
//            //如果数组的值不再改变那么就是没有数据了
//            
//            [self.col.mj_footer endRefreshing];
//            
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
//
//
//
//
//
//
///**有选择的挑选数据加入数据源中*/
//- (BOOL)selectWantDataAddDataArrayWithKey:(NSString *)key{
//    if ([key isEqualToString:@"banner"]) {
//        return YES;
//    }else if ([key isEqualToString:@"mother"]) {
//        return YES;
//    }else if ([key isEqualToString:@"dangjihot"]) {
//        return YES;
//    }else if ([key isEqualToString:@"tm"]) {
//        return YES;
//    }else if ([key isEqualToString:@"faxianshop"]) {
//        return YES;
//    }else if ([key isEqualToString:@"coupons"]) {
//        return YES;
//    }else if ([key isEqualToString:@"guesslike"]){
//        return YES;
//    }
//    return NO;
//}
//
//- (void)selectCellByKey:(NSString *)key{
//    if ([key isEqualToString:@"banner"]) {
//        [self.cellArray addObject:@"HBBannerCell"];
//    }
//    if ([key isEqualToString:@"mother"]) {
//        [self.cellArray addObject:@"HBGoodMothterCell"];
//    }
//    if ([key isEqualToString:@"dangjihot"]) {
//        [self.cellArray addObject:@"HBSeasonHotSell"];
//    }
//    if ([key isEqualToString:@"tm"]) {
//        [self.cellArray addObject:@"HBOverflowSellCell"];
//    }
//    if ([key isEqualToString:@"faxianshop"]) {
//        [self.cellArray addObject:@"HBRecomentGoodShopCell"];
//    }
//    if ([key isEqualToString:@"coupons"]) {
//        [self.cellArray addObject:@"HBCouponCell"];
//    }
//    if ([key isEqualToString:@"guesslike"]) {
//        [self.cellArray addObject:@"GuessYouLikeCollectionCell"];
//    }
//    
//    
//}
//
//
//
//
//
//- (void)configmentMidleView{
//    self.naviTitle = @"女婴馆";
//}
//
//
//#pragma mark --
//- (void)actionToSearch:(ActionBaseView *)searchView{
//    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
//}
//
//
//#pragma mark --  底层主视图
//- (void)configmentUI{
//
//    self.col.delegate = self;
//    self.col.dataSource = self;
//    [self.col registerClass:[HBBannerCell class] forCellWithReuseIdentifier:@"HBBannerCell"];
//    [self.col registerClass:[HBGoodMothterCell class] forCellWithReuseIdentifier:@"HBGoodMothterCell"];
//    [self.col registerClass:[HBSeasonHotSell class] forCellWithReuseIdentifier:@"HBSeasonHotSell"];
//    [self.col registerClass:[HBOverflowSellCell class] forCellWithReuseIdentifier:@"HBOverflowSellCell"];
//    [self.col registerClass:[HBRecomentGoodShopCell class] forCellWithReuseIdentifier:@"HBRecomentGoodShopCell"];
//    [self.col registerClass:[HBCouponCell class] forCellWithReuseIdentifier:@"HBCouponCell"];
//    [self.col registerClass:[GuessYouLikeCollectionCell class] forCellWithReuseIdentifier:@"GuessYouLikeCollectionCell"];
//    [self.col registerClass:[HBabyGirlHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HBabyGirlHeader"];
//    [self.col registerClass:[GuessYouLikeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader"];
//    
//}
//
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
//    if ([self.cellArray[section] isEqualToString:@"HBSeasonHotSell"]) {
//        HBabyBaseModel *baseModel = self.dataArray[section];
//        return baseModel.items.count;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBGoodMothterCell"]){
//        HBabyBaseModel *baseModel = self.dataArray[section];
//        return baseModel.items.count;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBRecomentGoodShopCell"]) {
//        HBabyBaseModel *baseModel = self.dataArray[section];
//        return baseModel.items.count;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBCouponCell"]) {
//        HBabyBaseModel *baseModel = self.dataArray[section];
//        return baseModel.items.count;
//    }
//    if ([self.cellArray[section] isEqualToString:@"GuessYouLikeCollectionCell"]){
//        HBabyBaseModel *baseModel = self.dataArray[section];
//        return baseModel.items.count;
//    }
//    return 1;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    HBabyBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellArray[indexPath.section] forIndexPath:indexPath];
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBSeasonHotSell"]) {
//        HBabyBaseModel *baseModel = self.dataArray[indexPath.section];
//        //计算cell的所在列数
//        NSInteger row = indexPath.row%2;
//        cell.row = row;
//        cell.customModel = baseModel.items[indexPath.row];
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HBGoodMothterCell"]){
//        HBabyBaseModel *baseModel = self.dataArray[indexPath.section];
//        cell.customModel = baseModel.items[indexPath.row];
//    } else if ([self.cellArray[indexPath.section] isEqualToString:@"HBCouponCell"]) {
//        HBabyBaseModel *baseModel = self.dataArray[indexPath.section];
//        cell.customModel = baseModel.items[indexPath.row];
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HBRecomentGoodShopCell"]) {
//        HBabyBaseModel *baseModel = self.dataArray[indexPath.section];
//        cell.customModel = baseModel.items[indexPath.row];
//    }else if ([self.cellArray[indexPath.section] isEqualToString:@"GuessYouLikeCollectionCell"]) {
//        HBabyBaseModel *baseModel = self.dataArray[indexPath.section];
//        cell.customModel = baseModel.items[indexPath.row];
//    }else{
//        cell.baseModel = self.dataArray[indexPath.section];
//    }
//    
//    
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBOverflowSellCell"]) {
//        HBOverflowSellCell *overCell = (HBOverflowSellCell *)cell;
//        overCell.delegate = self;
//        
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBBannerCell"]) {
//        HBBannerCell *bannerCell = (HBBannerCell *)cell;
//        if (self.bannerCell != bannerCell) {
//            [self.bannerCell removeTiemr];
//            self.bannerCell = nil;
//            self.bannerCell = bannerCell;
//        }
//        bannerCell.delegate = self;
//        
//    }
//    
//    
//    
//    return cell;
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    HBabyBaseModel *baseModel = self.dataArray[indexPath.section];
//        if ([self.cellArray[indexPath.section] isEqualToString:@"HBGoodMothterCell"]) {
//            CustomCollectionModel *subModel = baseModel.items[indexPath.item];
//            subModel.actionKey = @"HGoodsVC";
//            subModel.keyParamete = @{@"paramete":subModel.ID};
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//        }
//        if ([self.cellArray[indexPath.section] isEqualToString:@"HBSeasonHotSell"]) {
//            CustomCollectionModel *subModel = baseModel.items[indexPath.item];
//            subModel.actionKey = @"HGoodsVC";
//            subModel.keyParamete = @{@"paramete":subModel.ID};
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//        
//        }
//        if ([self.cellArray[indexPath.section] isEqualToString:@"HBOverflowSellCell"]) {
//        }
//        if ([self.cellArray[indexPath.section] isEqualToString:@"HBRecomentGoodShopCell"]) {
//            CustomCollectionModel *subModel = baseModel.items[indexPath.item];
//            subModel.actionKey = @"HShopVC";
//            subModel.keyParamete = @{@"paramete":subModel.ID};
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//        
//        }
//        if ([self.cellArray[indexPath.section] isEqualToString:@"HBCouponCell"]) {
//            CustomCollectionModel *subModel = baseModel.items[indexPath.item];
//            subModel.actionKey = @"CouponsDetailVC";
//            subModel.keyParamete = @{@"paramete":subModel.coupons_id};
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//        }
//        if ([self.cellArray[indexPath.section] isEqualToString:@"GuessYouLikeCollectionCell"]) {
//            CustomCollectionModel *subModel = baseModel.items[indexPath.item];
//            subModel.actionKey = @"HGoodsVC";
//            subModel.keyParamete = @{@"paramete":subModel.ID};
//            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//        }
//}
//#pragma mark -- 跳转到商品详情页面
//- (void)HBOverflowSellCellActionToGoodsDeatilWithSubModel:(CustomCollectionModel *)subModel{
//    subModel.keyParamete = @{@"paramete":subModel.ID};
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
//}
//#pragma mark -- 点击跳转到活动页面
//- (void)HBBannerCellActionToBabyActiveWithSubModel:(CustomCollectionModel *)subModel{
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
//
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    
//    if ([self.cellArray[section] isEqualToString:@"HBSeasonHotSell"]) {
//        return SeasonHotInter;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBCouponCell"]) {
//        return 1;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBGoodMothterCell"]){
//        return goodsMotherInter;
//    }
//    if ([self.cellArray[section] isEqualToString:@"GuessYouLikeCollectionCell"]){
//        return guessInter;
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBRecomentGoodShopCell"]) {
//        return reconmentInter;
//    }
//    return 0;
//}
////
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    
//    if ([self.cellArray[section] isEqualToString:@"HBSeasonHotSell"]) {
//        return SeasonHotLine;
//    }
//    
//    if ([self.cellArray[section] isEqualToString:@"HBCouponCell"]) {
//        return 1;
//    }
//    if ([self.cellArray[section] isEqualToString:@"GuessYouLikeCollectionCell"]){
//        return guessLine;
//    }
//    return 0;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    if ([self.cellArray[section] isEqualToString:@"HBSeasonHotSell"]) {
//        return UIEdgeInsetsMake(SeasonHotTop, SeasonHotLeft, SeasonHotBottom, SeasonHotRight);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBGoodMothterCell"]){
//        return UIEdgeInsetsMake(goodsMotherTop, goodsMotherLeft, goodsMotherBottom, goodsMotherRight);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBRecomentGoodShopCell"]) {
//        return UIEdgeInsetsMake(reconmentTop, reconmentLeft, reconmentBottom, reconmentRight);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBOverflowSellCell"]) {
//        return UIEdgeInsetsMake(overFellowTop, overFellowLeft, overFellowBottom,overFellowRight);
//    }
//    if ([self.cellArray[section] isEqualToString:@"GuessYouLikeCollectionCell"]){
//        return UIEdgeInsetsMake(guessTop, guessLeft, guessBottom, guessRight);
//    }
//    if ([self.cellArray[section] isEqualToString:@"HBCouponCell"]) {
//        return UIEdgeInsetsMake(1, 0, 1, 0);
//    }
//    
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBBannerCell"]) {
//        return CGSizeMake(screenW, 150 * SCALE);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBGoodMothterCell"]) {
//        return CGSizeMake(goodsMothterWidth, goodsMotherHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBSeasonHotSell"]) {
//        return CGSizeMake(SeasonHotWidth, SeasonHotHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBOverflowSellCell"]) {
//        return CGSizeMake(overFellowWidth, overFellowHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBRecomentGoodShopCell"]) {
//        return CGSizeMake(goodShopWidth, goodShopHeight);
//    }
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBCouponCell"]) {
//        return CGSizeMake(couponWidth, couponHeight);
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"GuessYouLikeCollectionCell"]){
//        return CGSizeMake(guessWidth, guessHeight);
//    }
//    
//    return CGSizeMake(0, 0);
//    
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBGoodMothterCell"]) {
//        HBabyGirlHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        header.titleImage = [UIImage imageNamed:@"bg_icon_hao"];
//        return header;
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBSeasonHotSell"]) {
//        HBabyGirlHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        
//        header.titleImage = [UIImage imageNamed:@"bg_icon_dang"];
//        return header;
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBOverflowSellCell"]) {
//        HBabyGirlHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        
//        header.titleImage = [UIImage imageNamed:@"bg_icon_chao"];
//        return header;
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBRecomentGoodShopCell"]) {
//        HBabyGirlHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        
//        header.titleImage = [UIImage imageNamed:@"bg_icon_tui"];
//        return header;
//    }
//    
//    if ([self.cellArray[indexPath.section] isEqualToString:@"HBCouponCell"]) {
//        HBabyGirlHeader *header = [self collectionview:collectionView indexPath:indexPath];
//        
//        header.titleImage = [UIImage imageNamed:@"bg_icon_you" ];
//        return header;
//    }
//    if ([self.cellArray[indexPath.section] isEqualToString:@"GuessYouLikeCollectionCell"]){
//        GuessYouLikeHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
//        return header;
//    }
//    return nil;
//}
//- (HBabyGirlHeader *)collectionview:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath{
//    HBabyGirlHeader *header =[collectionview dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HBabyGirlHeader" forIndexPath:indexPath];
//    header.backgroundColor = [UIColor whiteColor];
//    header.babyModel = self.dataArray[indexPath.section];
//    return header;
//
//}
//
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    if ([self.cellArray[section] isEqualToString:@"HBBannerCell"]) {
//        return CGSizeMake(0, 0);
//    }else{
//        return CGSizeMake(screenW, 36 * SCALE);
//    }
//    
//}

-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.bannerCell removeTiemr];

}


@end
