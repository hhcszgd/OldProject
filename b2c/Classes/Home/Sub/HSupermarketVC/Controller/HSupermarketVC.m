//
//  HSupermarketVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


/**hotbrand的布局属性*/
#define requestleft 0
#define requestright 0
#define requestline 0
#define requestInter 1
#define requestTop 2
#define requestBottom 10
#define requestWidth (screenW - requestleft - requestright - 2 * requestInter)/3.0f
#define requestHeight 170 *SCALE
/**推荐好店*/
#define heightSellLeft 0
#define heightSeellRight 0
#define heightSellInter 1
#define heightSellLine 0
#define heightSellTop 1
#define heightSellBottom 10
#define heightSellWidth (screenW - heightSeellRight - heightSellLeft - 2 * heightSellInter)/3.0f
#define heightSellHeight 160 *SCALE
/**优惠券布局*/
#define couponLeft 0
#define couponright 0
#define couponInter 1
#define couponLine 1
#define couponTop 2
#define couponBottom 0
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
#pragma mark -- 天天低价
#define everyDayHeight 190 * SCALE
#pragma 轮播图
#define bannerHeight 150 * SCALE

#define lowTop 0
#define lowLeft 0
#define lowBottom 10
#define lowRight 0
#import "HSearchVC.h"
#import "HSupermarketVC.h"
#import "CustomFRefresh.h"
#import "HSuperMarketBaseCell.h"
#import "HSuperHeader.h"
#import "HSuperBaseModel.h"
#import "HSuperBannerCell.h"
#import "HSuperDailyRequestCell.h"
#import "HSuperDayLowPriceCell.h"
#import "HSuperGoodShopCommentCell.h"
#import "HSuperCouponCell.h"
#import "HSperMarketGuessYouLikeCell.h"
#import "CSearchBtn.h"
#import "MainTabBarButton.h"
#import "HSuperWebVC.h"
#import "ShopCar.h"

@interface HSupermarketVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HSuperBannerCellDelegate,HSuperDayLowPriceCellDelegate, UIScrollViewDelegate, superWebDelegate>
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**临时数组存放cell*/
@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, weak) HSuperBannerCell *bannerCell;
@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, weak) MainTabBarButton *homebt;
@property (nonatomic, weak) MainTabBarButton *classbt;
@property (nonatomic, weak) BaseWebVC *web;

@end

@implementation HSupermarketVC




- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        [self.view addSubview:_topView];
        
    }
    return _topView;
}
#pragma mark -- 设置分类按钮和搜索框
- (void)configmentTopView{
    
    //添加父视图
    self.topView.backgroundColor = [UIColor whiteColor];
    //布局
    self.topView.frame = CGRectMake(0, self.startY, screenW, 45 * zkqScale);
    CSearchBtn *serachView = [[CSearchBtn alloc] initWithFrame:CGRectMake(49, 7, screenW -49 - 10, 33)];
    [self.topView addSubview:serachView];
    [serachView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.height.equalTo(@(33 * zkqScale));
        make.left.equalTo(self.topView.mas_left).offset(49);
        make.right.equalTo(self.topView.mas_right).offset(-10);
    }];
    serachView.titleStr = @"搜索超市商品";
    serachView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    serachView.textLabel.textColor = [UIColor colorWithHexString:@"010101"];
    [serachView addTarget:self action:@selector(actionToSearchInSuperMarket:) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *classifyBtn = [[UIButton alloc] init];
    [self.topView addSubview:classifyBtn];
    [classifyBtn addTarget:self action:@selector(classify:) forControlEvents:UIControlEventTouchUpInside];
    [classifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(0);
       make.top.equalTo(self.topView.mas_top).offset(0);
       make.bottom.equalTo(self.topView.mas_bottom).offset(0);
        make.right.equalTo(serachView.mas_left).offset(0);
    }];
    [classifyBtn setImage:[UIImage imageNamed:@"icon_bg_shop"] forState:UIControlStateNormal];
    classifyBtn.backgroundColor = [UIColor whiteColor];
    
}
#pragma mark --跳转到搜索页面
- (void)actionToSearchInSuperMarket:(CSearchBtn *)search{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"跳转到搜索页面")
//    BaseModel *baseModel = [[BaseModel alloc] init];
//    baseModel.actionKey = @"HSearchVC";
    HSearchVC *searchVC = [[HSearchVC alloc] init];
    searchVC.channel_id = @"102";
    [self.navigationController pushViewController:searchVC animated:YES];
//    baseModel.keyParamete = @{@"channel_id":@"102"};
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
    
}
#pragma mark -- 分类
- (void)classify:(UIButton *)classifyBtn{
    BaseModel *baseModel = [[BaseModel alloc] init];
    
    baseModel.actionKey = @"HSuperMarketClassifyVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
}

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
    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"102" PageNum:self.pageNumber success:^(ResponseObject *responseObject) {
        [self dealGuessYoulikeDataUnusualWith:responseObject];
        self.pageNumber++;
    } failure:^(NSError *error) {
        [self.col.mj_footer endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置搜索框和分类按钮
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarRightActionViews:@[self.shopCarBtn]];
//    [self configmentTopView];
    [self configmentbottomUI];
    
}

- (void)configmentbottomUI{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, screenH - 50, screenW, 50)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    MainTabBarButton *homeBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(0, 0, screenW/2.0, 50)];
    [homeBtn addTarget:self action:@selector(clickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [homeBtn setImage:[UIImage imageNamed:@"icon_home page"] forState:UIControlStateNormal];
    [homeBtn setImage:[UIImage imageNamed:@"icon_selected_homepage"] forState:UIControlStateSelected];
    [homeBtn setTitle:@"首页"forState:UIControlStateNormal];
    //        [btn.titleLabel setTextColor:[UIColor grayColor]];
    [homeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [homeBtn setTitleColor:THEMECOLOR forState:UIControlStateSelected];
    
    [homeBtn setSelected:YES];
    
    
    MainTabBarButton *classBtn = [[MainTabBarButton alloc] initWithFrame:CGRectMake(screenW/2.0, 0, screenW/2.0, 50)];
    [classBtn addTarget:self action:@selector(clickClassBtn:) forControlEvents:UIControlEventTouchUpInside];
    [classBtn setImage:[UIImage imageNamed:@"icon_classification"] forState:UIControlStateNormal];
    [classBtn setImage:[UIImage imageNamed:@"icon_selected_classification"] forState:UIControlStateSelected];
    [classBtn setTitle:@"分类"forState:UIControlStateNormal];
    //        [btn.titleLabel setTextColor:[UIColor grayColor]];
    [classBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [classBtn setTitleColor:THEMECOLOR forState:UIControlStateSelected];
    
    [bottomView addSubview:homeBtn];
    [bottomView addSubview:classBtn];
    self.homebt = homeBtn;
    self.classbt = classBtn;
    UIScrollView *privateScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 50)];
    [self.view addSubview:privateScroll];
    self.scroll = privateScroll;
    self.scroll.contentSize = CGSizeMake(screenW * 2.0, 0.0);
    [self.scroll setPagingEnabled:YES];
    [self.scroll setScrollEnabled:YES];
    self.scroll.delegate = self;
    self.scroll.bounces = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    HSuperWebVC *webVC = [[HSuperWebVC alloc] init];
    
    if (self.keyParamete[@"paramete"]) {
        webVC.keyParamete = @{@"paramete": self.keyParamete[@"paramete"]};
    }
    
    [self.scroll addSubview:webVC.view];
    webVC.keyParamete = self.keyParamete;
    webVC.view.frame = CGRectMake(0, 0, screenW, self.scroll.bounds.size.height);
    [self addChildViewController:webVC];
    webVC.delegate = self;
    self.web = webVC;
    HSuperMarketClassifyVC * classVC = [[HSuperMarketClassifyVC alloc] init];
    
    [self.scroll addSubview:classVC.view];
    classVC.view.frame = CGRectMake(screenW, 0, screenW, self.scroll.bounds.size.height);
    [self addChildViewController:classVC];
    
    
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [self.shopCarBtn convertRect:self.shopCarBtn.frame toView:window];
    self.web.shopCarIconFrame = rect;
    if ([UserInfo shareUserInfo].isLogin) {
        //更新按钮购物车数量
        [[UserInfo shareUserInfo] gotShopCarNumberSuccess:^(ResponseObject *responseObject) {
            [self.shopCarBtn editShopCarNumber:responseObject.data];
        } failure:^(NSError *error) {
        }];
    }
    
}

- (void)changeShopCarNumber{
    //更新按钮购物车数量
    [[UserInfo shareUserInfo] gotShopCarNumberSuccess:^(ResponseObject *responseObject) {
        [self.shopCarBtn editShopCarNumber:responseObject.data];
    } failure:^(NSError *error) {
        AlertInVC(@"")
    }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    if (x <=0) {
        [self.homebt setSelected:YES];
        
        [self.classbt setSelected:NO];
    }
    if (x >= screenW) {
        [self.homebt setSelected:NO];
        [self.classbt setSelected:YES];
    }
}





- (void)clickHomeBtn:(MainTabBarButton *)btn{
    [btn setSelected:YES];

    [self.classbt setSelected:NO];
    [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)clickClassBtn:(MainTabBarButton *)btn{

    [btn setSelected:YES];
    [self.homebt setSelected:NO];
    [self.scroll setContentOffset:CGPointMake(screenW, 0) animated:YES];
}




//重写方法
- (void)configmentNavigation{
    
}





- (void)downRefresh{
//    self.pageNumber = 1;
//    [[UserInfo shareUserInfo] gotSuperMarketsuccess:^(ResponseObject *response) {
//        [self.dataArray removeAllObjects];
//        [self.cellArray removeAllObjects];
//        [self dealDataUnusualWith:response];
//         self.col.mj_footer.state = MJRefreshStateIdle;
//        
//    } failure:^(NSError *error) {
//        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
//        
//        
//    }];
}


- (void)reconnectClick:(UIButton *)sender{
    self.pageNumber =1;
    [[UserInfo shareUserInfo] gotSuperMarketsuccess:^(ResponseObject *response) {
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
    if (response.data) {
        self.col.mj_footer = self.refreshFooter;
        //返回值是数组的形式
        if ([response.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in response.data) {
                HSuperBaseModel *baseModel = [HSuperBaseModel mj_objectWithKeyValues:dic];
                if ([self selectWantDataAddDataArrayWithKey:baseModel.key]) {
                    if (baseModel.items && (baseModel.items.count >0)) {
                        [self selectCellByKey:baseModel.key];
                        [self.dataArray addObject:baseModel];
                    }
                }
                
            }
            HSuperBaseModel *guessLike = [[HSuperBaseModel alloc] init];
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
            HSuperBaseModel *guessLike = [HSuperBaseModel mj_objectWithKeyValues:responseObject.data];
            if (!guessLike.items) {
                
            }else{
                HSuperBaseModel *baseModel = [self.dataArray lastObject];
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
    }else if ([key isEqualToString:@"everyday"]) {
        return YES;
    }else if ([key isEqualToString:@"lower"]) {
        return YES;
    } if ([key isEqualToString:@"goodshop"]) {
        return YES;
    }
    if ([key isEqualToString:@"coupons"]) {
        return YES;
    } if ([key isEqualToString:@"guesslike"]) {
        return YES;
    }
    return NO;
}

#pragma --mark根据key值确定需要的cell
- (void)selectCellByKey:(NSString *)key{
    //
    if ([key isEqualToString:@"banner"]) {
        [self.cellArray addObject:@"HSuperBannerCell"];
    }
    if ([key isEqualToString:@"everyday"]) {
        [self.cellArray addObject:@"HSuperDailyRequestCell"];
    }
    if ([key isEqualToString:@"lower"]) {
        [self.cellArray addObject:@"HSuperDayLowPriceCell"];
    }
    if ([key isEqualToString:@"goodshop"]) {
        [self.cellArray addObject:@"HSuperGoodShopCommentCell"];
    }
    if ([key isEqualToString:@"coupons"]) {
        [self.cellArray addObject:@"HSuperCouponCell"];
    }
    if ([key isEqualToString:@"guesslike"]) {
        [self.cellArray addObject:@"HSperMarketGuessYouLikeCell"];
    }
    
    
    
}


#pragma mark --  底层主视图
- (void)configmentUI{
//    self.col.frame =CGRectMake(0, self.startY + 45 * zkqScale, screenW, screenH - self.startY - 45 * zkqScale);
//    self.col.delegate = self;
//    self.col.dataSource = self;
//    [self.col registerClass:[HSuperBannerCell class] forCellWithReuseIdentifier:@"HSuperBannerCell"];
//    [self.col registerClass:[HSuperDailyRequestCell class] forCellWithReuseIdentifier:@"HSuperDailyRequestCell"];
//    [self.col registerClass:[HSuperDayLowPriceCell class] forCellWithReuseIdentifier:@"HSuperDayLowPriceCell"];
//    [self.col registerClass:[HSuperGoodShopCommentCell class] forCellWithReuseIdentifier:@"HSuperGoodShopCommentCell"];
//    [self.col registerClass:[HSuperCouponCell class] forCellWithReuseIdentifier:@"HSuperCouponCell"];
//    [self.col registerClass:[HSperMarketGuessYouLikeCell class] forCellWithReuseIdentifier:@"HSperMarketGuessYouLikeCell"];
//    [self.col registerClass:[HSuperHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HSuperHeader"];
//    [self.col registerClass:[GuessYouLikeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
    if ([self.cellArray[section] isEqualToString:@"HSuperDailyRequestCell"]){
        HSuperBaseModel *model = self.dataArray[section];
        return model.items.count;
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperGoodShopCommentCell"]){
        HSuperBaseModel *model = self.dataArray[section];
        return model.items.count;
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperCouponCell"]){
        HSuperBaseModel *model = self.dataArray[section];
        return model.items.count;
        
    }
    if ([self.cellArray[section] isEqualToString:@"HSperMarketGuessYouLikeCell"]){
        HSuperBaseModel *model = self.dataArray[section];
        return model.items.count;
    }
   
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    HSuperMarketBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellArray[indexPath.section] forIndexPath:indexPath];
    
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDailyRequestCell"]) {
        HSuperBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.customModel = baseModel.items[indexPath.row];
        
    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperGoodShopCommentCell"]){
        HSuperBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.customModel = baseModel.items[indexPath.row];
        
    } else if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperCouponCell"]) {
        HSuperBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.customModel = baseModel.items[indexPath.row];
        
    }else if ([self.cellArray[indexPath.section] isEqualToString:@"HSperMarketGuessYouLikeCell"]) {
        HSuperBaseModel *baseModel = self.dataArray[indexPath.section];
        cell.customModel = baseModel.items[indexPath.row];
        
    } else{
        cell.baseModel = self.dataArray[indexPath.section];
    }
    
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperBannerCell"]) {
        HSuperBannerCell *bannerCell = (HSuperBannerCell *)cell;
        if (self.bannerCell != bannerCell) {
            [self.bannerCell removeTiemr];
            self.bannerCell = nil;
            self.bannerCell = bannerCell;
            
        }
        bannerCell.delegate = self;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDayLowPriceCell"]) {
        HSuperDayLowPriceCell *lowPriceCell = (HSuperDayLowPriceCell *)cell;
        lowPriceCell.delegate = self;
    }
    
    
    
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    
    if ([self.cellArray[section] isEqualToString:@"HSuperDailyRequestCell"]){
        
        return requestInter;
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperGoodShopCommentCell"]){
        return heightSellInter;
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperCouponCell"]){
        return couponInter;
    }
    if ([self.cellArray[section] isEqualToString:@"HSperMarketGuessYouLikeCell"]){
        return guessinter;
    }
    return 0;
}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
   
    if ([self.cellArray[section] isEqualToString:@"HSuperDailyRequestCell"]){
        return requestline;
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperGoodShopCommentCell"]){
        return heightSellLine;
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperCouponCell"]){
        return couponLine;
    }
    if ([self.cellArray[section] isEqualToString:@"HSperMarketGuessYouLikeCell"]){
        return guessline;
    }
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if ([self.cellArray[section] isEqualToString:@"HSuperDailyRequestCell"]){
        return UIEdgeInsetsMake(requestTop, requestleft, requestBottom, requestright);
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperGoodShopCommentCell"]){
        return UIEdgeInsetsMake(heightSellTop, heightSellLeft, heightSellBottom, heightSeellRight);
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperCouponCell"]){
        return UIEdgeInsetsMake(couponTop, couponLeft, couponBottom, couponright);
    }
    if ([self.cellArray[section] isEqualToString:@"HSperMarketGuessYouLikeCell"]){
        return UIEdgeInsetsMake(guessTop, guessLeft, guessBottem, guessright);
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperDayLowPriceCell"]) {
        return UIEdgeInsetsMake(lowTop, lowLeft, lowBottom, lowRight);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperBannerCell"]) {
        return CGSizeMake(screenW, bannerHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDailyRequestCell"]) {
        return CGSizeMake(requestWidth, requestHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDayLowPriceCell"]){
        return CGSizeMake(screenW , everyDayHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperGoodShopCommentCell"]) {
        return CGSizeMake(heightSellWidth,heightSellHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperCouponCell"]){
        return CGSizeMake(couponwidth, couponHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSperMarketGuessYouLikeCell"]) {
        return CGSizeMake(guesswidth, guessheght);
    }
    
    return CGSizeMake(0, 0);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDailyRequestCell"]) {
        HSuperHeader *header =[self collectionview:collectionView indexPath:indexPath];
        return header;
    }
    
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDayLowPriceCell"]) {
        HSuperHeader *header =[self collectionview:collectionView indexPath:indexPath];
        return header;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperGoodShopCommentCell"]) {
        HSuperHeader *header =[self collectionview:collectionView indexPath:indexPath];
        return header;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperCouponCell"]) {
        HSuperHeader *header =[self collectionview:collectionView indexPath:indexPath];
        return header;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSperMarketGuessYouLikeCell"]) {
        GuessYouLikeHeader *h = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
        return h;
    }
    return nil;
}
-(HSuperHeader *)collectionview:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath{
    HSuperHeader *header =[collectionview dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HSuperHeader" forIndexPath:indexPath];
    HSuperBaseModel *baseModel = self.dataArray[indexPath.section];
    header.baseModel = baseModel;
    return header;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    CGSize size = CGSizeMake(0, 0);
    if ([self.cellArray[section] isEqualToString:@"HSuperDailyRequestCell"]) {
        size = CGSizeMake(screenW, 34 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperDayLowPriceCell"]) {
        size = CGSizeMake(screenW, 34 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperGoodShopCommentCell"]) {
        size = CGSizeMake(screenW, 34 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HSuperCouponCell"]) {
        
        size = CGSizeMake(screenW, 34 * SCALE);
    }
    if ([self.cellArray[section] isEqualToString:@"HSperMarketGuessYouLikeCell"]) {
        
        size = CGSizeMake(screenW, 34 * SCALE);
    }
    
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HSuperBaseModel *baseModel = self.dataArray[indexPath.section];
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperBannerCell"]) {
        
        
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDailyRequestCell"]) {
        CustomCollectionModel *subModel = baseModel.items[indexPath.item];
       
        subModel.keyParamete = @{@"paramete":subModel.ID};
        LOG(@"%@,%d,%@",[self class], __LINE__,subModel.ID)
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperDayLowPriceCell"]){
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperGoodShopCommentCell"]) {
        CustomCollectionModel *subModel = baseModel.items[indexPath.item];
        subModel.actionKey = @"HShopVC";
        subModel.keyParamete = @{@"paramete":subModel.ID};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        
        
        
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSuperCouponCell"]){
        CustomCollectionModel *subModel = baseModel.items[indexPath.item];
        subModel.actionKey = @"CouponsDetailVC";
        subModel.keyParamete = @{@"paramete":subModel.coupons_id};
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HSperMarketGuessYouLikeCell"]) {
        CustomCollectionModel *subModel = baseModel.items[indexPath.item];
        subModel.actionKey = @"HGoodsVC";
        subModel.keyParamete = @{@"paramete":subModel.ID};
        LOG(@"%@,%d,%@",[self class], __LINE__,subModel.ID)
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        
        
    }
}
#pragma 跳转到超市活动
- (void)HSuperBannerCellActionToSuperMarketActiveWithSubModel:(CustomCollectionModel *)subModel{
    if ([subModel.actionKey isEqualToString:@"HGoodsVC"]) {
        subModel.actionKey = @"HGoodsVC";
    }
    if ([subModel.actionKey isEqualToString:@"HShopVC"]) {
        subModel.actionKey = @"HShopVC";
    }
    if ([subModel.actionKey isEqualToString:@"webpage"]) {
        subModel.actionKey = @"HDirectActiveVC";
        
    }
    if (subModel.link) {
        if (subModel.link.length > 0) {
            subModel.keyParamete = @{@"paramete":subModel.link};
            
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        }
    }

}
#pragma 跳转到商品详情
- (void)HSuperDayLowPriceCellActionToGoodsDetailWithSubModel:(CustomCollectionModel *)subModel{
    subModel.keyParamete = @{@"paramete":subModel.ID};
    subModel.actionKey = @"HGoodsVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
}




-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.bannerCell removeTiemr];
    self.bannerCell = nil;

}


@end
