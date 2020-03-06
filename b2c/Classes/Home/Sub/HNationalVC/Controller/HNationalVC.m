//
//  HNationalVC.m
//  b2c
//
//  Created by wangyuanfei on 16/8/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

//
//  HEaVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
/**hotbrand的布局属性*/
#define brandleft 0
#define brandright 0
#define brandline 0
#define brandinter 1
#define brandtop 2
#define brandbottom 2
#define brandWidth (screenW - brandleft - brandright - 2 * brandinter)/3.0f
#define brandheight 162 *SCALE
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
#define overSellHeight 161
#pragma 轮播图
#define bannerHeight 150 * SCALE

#pragma mark -- 热门分类
#define classifyLeft 0
#define classifyright 0
#define classifyinter 1
#define classifyline 1
#define classifyTop 2
#define classifyBottem 2
#define classifywidth 0
#define classifyheght 0
//超值特卖
#define overTop 2
#define overLeft 0
#define overBottom 2
#define overRight 0

#import "HNationalVC.h"
#import "CustomFRefresh.h"
#import "GuessYouLikeHeader.h"

#import "HEaBaseCell.h"
/**baner*/
#import "HAPBannerCell.h"
/**组头*/
#import "HSuperHeader.h"
/**电器王*/
#import "HApplianceKingCell.h"
/**超值特卖*/
#import "HNHotGategotyCell.h"
/**优质厂家推荐*/
#import "HEHeightSellCommentCell.h"
/**优惠券*/
#import "HECouponCell.h"
#import "HEOverflowSellCell.h"
/**商品*/
#import "HEGuessYouLikeCell.h"
#import "HEaBaseModel.h"
#import "HEaBaseCell.h"

@interface HNationalVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HAPBannerCellDelegate,HEOverflowSellCellDelegate>

/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**临时数组存放cell*/
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) HAPBannerCell *banncerCell;
@end

@implementation HNationalVC
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)cellArray{
    if (_cellArray == nil) {
        _cellArray = [[NSMutableArray alloc] init];
        
    }
    return _cellArray;
}
#pragma mark -- 加载更多
- (void)upRefresh{
    
    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"107" PageNum:self.pageNumber success:^(ResponseObject *responseObject) {
        [self dealGuessYoulikeDataUnusualWith:responseObject];
        self.pageNumber++;
    } failure:^(NSError *error) {
        [self.col.mj_footer endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.hidden = YES;
    BaseWebVC *webVC = [[BaseWebVC alloc] init];
    webVC.keyParamete = self.keyParamete;
    
    [self.view addSubview:webVC.view];
    [self addChildViewController:webVC];
    webVC.webview.frame = CGRectMake(0, 0, screenW, screenH);
    
    webVC.navigationView.hidden = YES;
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];
    
}
- (void)downRefresh{
    self.pageNumber = 1;
    [[UserInfo shareUserInfo] gotNationalDataSuccess:^(ResponseObject *responseObject) {
        [self.dataArray removeAllObjects];
        [self.cellArray removeAllObjects];
        [self dealDataUnusualWith:responseObject];
        self.col.mj_footer.state = MJRefreshStateIdle;
    } failure:^(NSError *error) {
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
    }];
    
}


- (void)reconnectClick:(UIButton *)sender{
    self.pageNumber =1;
    [[UserInfo shareUserInfo] gotHomeApplicancesuccess:^(ResponseObject *response) {
        [self.dataArray removeAllObjects];
        [self.cellArray removeAllObjects];
        [self dealDataUnusualWith:response];
        [self removeTheViewWhenConnect];
        
    } failure:^(NSError *error) {
        
    }];
}
/**排除数据异常*/
- (void)dealDataUnusualWith:(ResponseObject *)response{
    //判断是否返回数据
    if (response.status > 0) {
        self.col.mj_footer = self.refreshFooter;
        //返回值是数组的形式
        if ([response.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in response.data) {
                HEaBaseModel *baseModel = [HEaBaseModel mj_objectWithKeyValues:dic];
                //不存在的话
                if (baseModel.items && (baseModel.items.count >0)) {
                    [self selectCellByKey:baseModel.key];
                    [self.dataArray addObject:baseModel];
                }
            }
            HEaBaseModel *guessLike = [[HEaBaseModel alloc] init];
            [self selectCellByKey:@"guesslike"];
            guessLike.items =  [NSMutableArray array];
            [self.dataArray addObject:guessLike];
            
            
            [self.col.mj_header endRefreshing];
        }
    }else{
        [self.col.mj_header endRefreshing];
        
        
    }
    [self.col reloadData];
    
}
/**处理猜你喜欢数据的异常*/
- (void)dealGuessYoulikeDataUnusualWith:(ResponseObject *)responseObject{
    self.col.mj_footer = self.refreshFooter;
    if (responseObject.status > 0) {
        if (!responseObject.data) {
            [self.col.mj_footer endRefreshingWithNoMoreData];
        }else{
            HEaBaseModel *guessLike = [HEaBaseModel mj_objectWithKeyValues:responseObject.data];
            if (!guessLike.items) {
                
            }else{
                HEaBaseModel *baseModel = [self.dataArray lastObject];
                [baseModel.items addObjectsFromArray:guessLike.items];
            }
            
            
            //如果数组的值不再改变那么就是没有数据了
            
            [self.col.mj_footer endRefreshing];
            
            
            
            
        }
    }else{
        [self.col.mj_footer endRefreshingWithNoMoreData];
    }
    
    
    
    [self.col reloadData];
}
/**有选择的挑选数据加入数据源中*/
- (BOOL)selectWantDataAddDataArrayWithKey:(NSString *)key{
    if ([key isEqualToString:@"banner"]) {
        return YES;
    }else if ([key isEqualToString:@"hotgoods"]) {
        return YES;
    }else if ([key isEqualToString:@"hotclassify"]) {
        return YES;
    }else if ([key isEqualToString:@"salegoods"]) {
        return YES;
    }else if ([key isEqualToString:@"goodshop"]) {
        return YES;
    }else if ([key isEqualToString:@"coupons"]) {
        return YES;
    }else if ([key isEqualToString:@"guesslike"]){
        return YES;
    }
    return NO;
}

#pragma --mark根据key值确定需要的cell
- (void)selectCellByKey:(NSString *)key{
    
    if ([key isEqualToString:@"banner"]) {
        [self.cellArray addObject:@"HAPBannerCell"];
    }
    if ([key isEqualToString:@"hotgoods"]) {
        [self.cellArray addObject:@"HApplianceKingCell"];
    }
    if ([key isEqualToString:@"hotclassify"]) {
        [self.cellArray addObject:@"HNHotGategotyCell"];
    }
    if ([key isEqualToString:@"salegoods"]) {
        [self.cellArray addObject:@"HEOverflowSellCell"];
    }
    if ([key isEqualToString:@"goodshop"]) {
        [self.cellArray addObject:@"HEHeightSellCommentCell"];
    }
    if ([key isEqualToString:@"coupons"]) {
        [self.cellArray addObject:@"HECouponCell"];
    }
    if ([key isEqualToString:@"guesslike"]) {
        [self.cellArray addObject:@"HEGuessYouLikeCell"];
    }
    
    
    
}






#pragma mark --  底层主视图
- (void)configmentUI{
    
    self.col.delegate = self;
    self.col.dataSource = self;
    [self.col registerClass:[HAPBannerCell class] forCellWithReuseIdentifier:@"HAPBannerCell"];
    [self.col registerClass:[HApplianceKingCell class] forCellWithReuseIdentifier:@"HApplianceKingCell"];
    [self.col registerClass:[HNHotGategotyCell class] forCellWithReuseIdentifier:@"HNHotGategotyCell"];
    [self.col registerClass:[HEHeightSellCommentCell class] forCellWithReuseIdentifier:@"HEHeightSellCommentCell"];
    [self.col registerClass:[HECouponCell class] forCellWithReuseIdentifier:@"HECouponCell"];
    [self.col registerClass:[HEGuessYouLikeCell class] forCellWithReuseIdentifier:@"HEGuessYouLikeCell"];
    [self.col registerClass:[HEOverflowSellCell class] forCellWithReuseIdentifier:@"HEOverflowSellCell"];
    [self.col registerClass:[HSuperHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HSuperHeader"];
    [self.col registerClass:[GuessYouLikeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader"];}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    HEaBaseModel *model = self.dataArray[section];
    if ([self.cellArray[section] isEqualToString:@"HNHotGategotyCell"]){
        
        
        return model.items.count;
    }
    if ([self.cellArray[section] isEqualToString:@"HApplianceKingCell"]){
        return model.items.count;
    }
    if ([self.cellArray[section] isEqualToString:@"HEHeightSellCommentCell"]){
        return model.items.count;
    }
    if ([self.cellArray[section] isEqualToString:@"HECouponCell"]){
        return model.items.count;
    }
    if ([self.cellArray[section] isEqualToString:@"HEGuessYouLikeCell"]){
        
        return model.items.count;
    }
    
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HEaBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellArray[indexPath.section] forIndexPath:indexPath];
   
    if ([self.cellArray[indexPath.section] isEqualToString:@"HApplianceKingCell"]) {
        HEaBaseModel *baseModel = self.dataArray[indexPath.section];
         cell.channelCellStyle = nationCellStyle;
        cell.customModel = baseModel.items[indexPath.item];
    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HNHotGategotyCell"]){
        HEaBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.channelCellStyle = nationCellStyle;
        cell.customModel = baseModel.items[indexPath.item];
        if (indexPath.item < 2) {
            cell.cellStyle = cellStyleIsBig;
        }else{
            cell.cellStyle = cellStyleIsSmall;
        }
        LOG(@"%@,%d,%@-----%ld",[self class], __LINE__,NSStringFromCGRect(cell.frame),indexPath.item)
        
    } else if ([self.cellArray[indexPath.section] isEqualToString:@"HEHeightSellCommentCell"]) {
        HEaBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.customModel = baseModel.items[indexPath.item];
         cell.channelCellStyle = nationCellStyle;
    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HECouponCell"]) {
        HEaBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.customModel = baseModel.items[indexPath.item];
    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HEGuessYouLikeCell"]) {
        HEaBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.customModel = baseModel.items[indexPath.item];
    } else{
        cell.baseModel = self.dataArray[indexPath.section];
         cell.channelCellStyle = nationCellStyle;
    }
    
    if ([self.cellArray[indexPath.section] isEqualToString:@"HAPBannerCell"]) {
        HAPBannerCell *banner = (HAPBannerCell*)cell;
        if (self.banncerCell != banner) {
            [self.banncerCell removeTiemr];
            self.banncerCell = nil;
            self.banncerCell = banner;
        }
        banner.delegate = self;
        banner.channelCellStyle = nationCellStyle;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEOverflowSellCell"]) {
        HEOverflowSellCell *overCell = (HEOverflowSellCell*)cell;
        cell.channelCellStyle = nationCellStyle;
        overCell.delegate = self;
    }
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    if ([self.cellArray[section] isEqualToString:@"HApplianceKingCell"]){
        
        return brandinter;
    }
    if ([self.cellArray[section] isEqualToString:@"HEHeightSellCommentCell"]){
        return heightSellInter;
    }
    if ([self.cellArray[section] isEqualToString:@"HECouponCell"]){
        return couponInter;
    }
    if ([self.cellArray[section] isEqualToString:@"HEGuessYouLikeCell"]){
        return guessinter;
    }
    if ([self.cellArray[section] isEqualToString:@"HNHotGategotyCell"]){
        return classifyinter;
    }
    return 0;
}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if ([self.cellArray[section] isEqualToString:@"HApplianceKingCell"]){
        
        return brandline;
    }
    if ([self.cellArray[section] isEqualToString:@"HEHeightSellCommentCell"]){
        return heightSellLine;
    }
    if ([self.cellArray[section] isEqualToString:@"HECouponCell"]){
        return couponLine;
    }
    if ([self.cellArray[section] isEqualToString:@"HEGuessYouLikeCell"]){
        return guessline;
    }
    if ([self.cellArray[section] isEqualToString:@"HNHotGategotyCell"]){
        return classifyline;
    }
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([self.cellArray[section] isEqualToString:@"HApplianceKingCell"]){
        return UIEdgeInsetsMake(brandtop, brandleft, brandbottom, brandright);
    }
    if ([self.cellArray[section] isEqualToString:@"HEHeightSellCommentCell"]){
        return UIEdgeInsetsMake(heightSellTop, heightSellLeft, heightSellBottom, heightSeellRight);
    }
    if ([self.cellArray[section] isEqualToString:@"HECouponCell"]){
        return UIEdgeInsetsMake(couponTop, couponLeft, couponBottom, couponright);
    }
    if ([self.cellArray[section] isEqualToString:@"HEGuessYouLikeCell"]){
        return UIEdgeInsetsMake(guessTop, guessLeft, guessBottem, guessright);
    }
    if ([self.cellArray[section] isEqualToString:@"HNHotGategotyCell"]){
        return UIEdgeInsetsMake(classifyTop, classifyLeft, classifyBottem, classifyright);
    }
    if ([self.cellArray[section] isEqualToString:@"HEOverflowSellCell"]) {
        return UIEdgeInsetsMake(overTop, overLeft, overBottom, overRight);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(0, 0);
    if ([self.cellArray[indexPath.section] isEqualToString:@"HAPBannerCell"]) {
        size = CGSizeMake(screenW, bannerHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HApplianceKingCell"]) {
        size =  CGSizeMake(brandWidth, brandheight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEOverflowSellCell"]){
        size = CGSizeMake(screenW , overSellHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEHeightSellCommentCell"]) {
        size = CGSizeMake(heightSellWidth,heightSellHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HECouponCell"]){
        size = CGSizeMake(couponwidth, couponHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEGuessYouLikeCell"]) {
        size = CGSizeMake(guesswidth, guessheght);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HNHotGategotyCell"]) {
        if (indexPath.item < 2) {
            size = CGSizeMake((screenW - classifyinter)/2.0, (screenW - classifyinter)/2.0);
        }else{
            size = CGSizeMake((screenW - classifyinter * 3)/4.0, (screenW - 3 *classifyinter)/4.0);
        }
    }
    return size;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([self.cellArray[indexPath.section] isEqualToString:@"HApplianceKingCell"]) {
        HSuperHeader *header = [self collectionview:collectionView indexPath:indexPath];
        return header;
    }
    
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEOverflowSellCell"]) {
        HSuperHeader *header = [self collectionview:collectionView indexPath:indexPath];
        return header;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEHeightSellCommentCell"]) {
        HSuperHeader *header = [self collectionview:collectionView indexPath:indexPath];
        return header;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HECouponCell"]) {
        
        HSuperHeader *header = [self collectionview:collectionView indexPath:indexPath];
        return header;
        
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEGuessYouLikeCell"]) {
        GuessYouLikeHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
        return header;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HNHotGategotyCell"]) {
        HSuperHeader *header = [self collectionview:collectionView indexPath:indexPath];
        return header;
        
    }
    return nil;
    
}
- (HSuperHeader *)collectionview:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath{
    HEaBaseModel *baseModel = self.dataArray[indexPath.section];
    HSuperHeader *header =[collectionview dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HSuperHeader" forIndexPath:indexPath];
    header.leftView.backgroundColor = [UIColor colorWithHexString:@"ff7800"];
    header.channelLabel.textColor = [UIColor colorWithHexString:@"ff7800"];
    header.channelLabel.text = baseModel.channel;
    
    return header;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = CGSizeMake(0, 0);
    if ([self.cellArray[section] isEqualToString:@"HApplianceKingCell"]) {
        size = CGSizeMake(screenW, 36 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HEOverflowSellCell"]) {
        size = CGSizeMake(screenW, 36 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HECouponCell"]) {
        size = CGSizeMake(screenW, 36 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HEHeightSellCommentCell"]) {
        
        size = CGSizeMake(screenW, 36 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HEGuessYouLikeCell"]) {
        
        size = CGSizeMake(screenW, 36 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HNHotGategotyCell"]) {
        
        size = CGSizeMake(screenW, 36 * SCALE);
    }
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HEaBaseModel *baseModel = self.dataArray[indexPath.section];
    CustomCollectionModel *subModel = baseModel.items[indexPath.item];
    if ([self.cellArray[indexPath.section] isEqualToString:@"HAPBannerCell"]) {
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HApplianceKingCell"]) {
        subModel.actionKey = @"HGoodsVC";
        subModel.keyParamete = @{@"paramete":subModel.ID};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEOverflowSellCell"]){
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEHeightSellCommentCell"]) {
        subModel.actionKey = @"HShopVC";
        subModel.keyParamete = @{@"paramete":subModel.ID};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HECouponCell"]){
        subModel.actionKey = @"CouponsDetailVC";
        subModel.keyParamete = @{@"paramete":subModel.coupons_id};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HEGuessYouLikeCell"]) {
        subModel.actionKey = @"HGoodsVC";
        subModel.keyParamete = @{@"paramete":subModel.ID};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HNHotGategotyCell"]) {
        subModel.actionKey = @"HSearchgoodsListVC";
        subModel.keyParamete = @{@"paramete":subModel.hotName};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        
    }
}
#pragma mark -- 跳转到电器活动页面
- (void)HAPBannerCellActionToHEaActiveWithSubModel:(CustomCollectionModel *)sucModel{
    if ([sucModel.actionKey isEqualToString:@"HGoodsVC"]) {
        sucModel.actionKey = @"HGoodsVC";
    }
    if ([sucModel.actionKey isEqualToString:@"HShopVC"]) {
        sucModel.actionKey = @"HShopVC";
    }
    if ([sucModel.actionKey isEqualToString:@"webpage"]) {
        sucModel.actionKey = @"HDirectActiveVC";
        
    }
    if (sucModel.link) {
        if (sucModel.link.length > 0) {
            sucModel.keyParamete = @{@"paramete":sucModel.link};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:sucModel];
        }
    }
    
}
#pragma mark -- 跳转到商品详情页面
- (void)HEOverflowSellCellActionToGoodsDetailWith:(CustomCollectionModel *)subModel{
    subModel.actionKey = @"HGoodsVC";
    subModel.keyParamete = @{@"paramete":subModel.ID};
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.banncerCell removeTiemr];
}




@end
