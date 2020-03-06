//
//  HShopVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#define storeImageViewHeight screenW/3.0
#define buttonViewHeight screenW/8.0
#define headerHeight 40
#define channelHeader 121 * SCALE
#define navHeight 51 * SCALE
#define navBottom 10
#define activeHeight 180 * SCALE
#define coupontHeight 69  
#define coupontBottom 10
#define goodsLeft 10
#define goodsRight 10
#define goodsBottom 10
#define goodsTop 10
#define goodsinter 10
#define goodsLine 10
#define goodsWidth (screenW - goodsLeft- goodsRight - goodsinter)/2.0
#define goodsHeight 234 * SCALE

#import "HStoreBaseCell.h"
#import "HAllGoodsVC.h"
#import "HAllClassVC.h"
#import "HStoreStoryVC.h"
#import "HStoreRecommentVC.h"
#import "HGloryAptitudeVC.h"




/**店铺详情页面*/
#import "HShopVC.h"
#import "HStoreDetailModel.h"
#import "HStoreHeader.h"
/**店铺头*/
#import "HStoreHeaderCell.h"
/**五个模块*/
#import "HStoreFiveModuleCell.h"
/**店铺活动*/
#import "HShopActiveCell.h"
/**优惠券*/
#import "HShopCouponCell.h"
/**分类排序*/
#import "XLPlainFlowLayout.h"
/**商品*/
#import "HStoreGoodsCell.h"
#import "HStoreClearHeader.h"
#import "HPromptCell.h"
#import "LoginNavVC.h"
#import "XMPPJID.h"
@interface HShopVC ()<StoreHeaderDelegate,HShopCouponCellDelegate,HShopActiveCellDelegate,HStoreBaseCellDelegate>

/**布局类*/
@property (nonatomic, strong) XLPlainFlowLayout *flowLayout;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *storeCol;
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**临时数组存放cell*/
@property (nonatomic, strong) NSMutableArray *cellArray;
/**组头*/
@property (nonatomic, strong) UIView *headerView;
/**判断是否是第一次执行，防止_headerView重复添加*/
@property (nonatomic, assign) BOOL isFirst;
/**四个按钮中之前被选中的按钮*/
@property (nonatomic, strong) UIButton *selectButton;
/**记录被选中的按钮的下标*/
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) HStoreHeader *header;
@property (nonatomic, strong) HShopActiveCell *activeCell;
/**记录header最初的y值高度*/
@property (nonatomic, assign) CGFloat headerY;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, copy) NSString *sortOrder;
/**分享店铺的名字*/
@property (nonatomic, copy) NSString *sharShopName;
/**分享店铺logo*/
@property (nonatomic, copy) NSString *sharShopLogoURl;
/**店铺灭有缴费或者是过期的时候显示覆盖页面*/
@property (nonatomic, strong) UIView *overView;

@end

@implementation HShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.headerY = 0;
    self.storeCol.backgroundColor = BackgroundGray;
    self.shop_id = self.keyParamete[@"paramete"];
    self.page = 1;
    self.sort = 0;
    self.sortOrder = classifyDesc;
    [self requestData];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.headerY == 0) {
        self.headerY = self.header.frame.origin.y;
    }
}
- (UIView *)overView{
    if (_overView == nil) {
        _overView =[[UIView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
        [self.view addSubview:_overView];
        UILabel *overLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _overView.frame.size.width, _overView.frame.size.height)];
        [_overView addSubview:overLabel];
        [overLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"店铺未交费或已过期"];
    }
    return _overView;
}


#pragma mark -- 请求数据
- (void)requestData{
    [[UserInfo shareUserInfo] gotShopDetailDataWithShopID:self.shop_id success:^(ResponseObject *responseObject) {
        [self.dataArray removeAllObjects];
//      店铺没有交费不显示。
        if (responseObject.status == -207) {
            self.overView.backgroundColor = [UIColor whiteColor];
            self.searchBtn.userInteractionEnabled = NO;
            self.messageButton.userInteractionEnabled = NO;
            return ;
        }
        //分析数据
        [self analyseDataWith:responseObject];
        //请求全部商品的数据
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.page success:^(ResponseObject *responseObject) {
            
            [self analyseAllgoodsData:responseObject];
            
            
        } failure:^(NSError *error) {
            HStoreDetailModel *baseModel =[[HStoreDetailModel alloc] init];
            [self.dataArray addObject:baseModel];
            [self selectCellByKey:@"prompt"];
        }];
    } failure:^(NSError *error) {
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.page success:^(ResponseObject *responseObject) {
            [self analyseAllgoodsData:responseObject];
        } failure:^(NSError *error) {
            [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
        }];
        
    }];
}
- (void)reconnectClick:(UIButton *)sender{
        [[UserInfo shareUserInfo] gotShopDetailDataWithShopID:self.shop_id success:^(ResponseObject *responseObject) {
            [self.dataArray removeAllObjects];
            [self analyseDataWith:responseObject];
            [self removeTheViewWhenConnect];
            [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.page success:^(ResponseObject *responseObject) {
                [self removeTheViewWhenConnect];
                [self analyseAllgoodsData:responseObject];
            } failure:^(NSError *error) {
                HStoreDetailModel *baseModel =[[HStoreDetailModel alloc] init];
                [self.dataArray addObject:baseModel];
                [self selectCellByKey:@"prompt"];
            }];
        
    } failure:^(NSError *error) {
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.page success:^(ResponseObject *responseObject) {
            [self removeTheViewWhenConnect];
            [self analyseAllgoodsData:responseObject];
        } failure:^(NSError *error) {
            
        }];
    }];
}

#pragma mark -- 分析数据
- (void)analyseDataWith:(ResponseObject *)responseObject{
    //数据存在
    if (responseObject.data) {
        LOG(@"%@,%d,%@",[self class], __LINE__,responseObject.data)
        self.storeCol.mj_footer = self.fRefresh;
        NSArray *data = responseObject.data;
        for (NSInteger i = 0; i < data.count; i++) {
            NSDictionary *dic = data[i];
            HStoreDetailModel *baseModel = [HStoreDetailModel mj_objectWithKeyValues:dic];
            if ([baseModel.key isEqualToString:@"focus"]) {
                LOG(@"%@,%d,%@",[self class], __LINE__,baseModel.seller_login_name);
                self.sellerUser = baseModel.seller_login_name;
                self.sharShopName = baseModel.shop.shopname;
                self.sharShopLogoURl = [NSString stringWithFormat:@"%@/%@", IMGDOMAIN,baseModel.shop.img];
                [self selectCellByKey:baseModel.key];
                [self.dataArray addObject:baseModel];
                
            }else{
                BOOL bo = [self selectWantDataAddDataArrayWithKey:baseModel.key];
                if (baseModel.items && bo) {
                    if ([baseModel.key isEqualToString:@"nav"]) {
                        for (HStoreSubModel * subModel in baseModel.items) {
                            subModel.isSelect = NO;
                        }
                    }
                    [self selectCellByKey:baseModel.key];
                    [self.dataArray addObject:baseModel];
                }
            }
            
            
            
        }
    }else{
        
    }
    
    [self.storeCol reloadData];
    
}

/**有选择的挑选数据加入数据源中*/
- (BOOL)selectWantDataAddDataArrayWithKey:(NSString *)key{
    if ([key isEqualToString:@"focus"]) {
        return YES;
    }else if ([key isEqualToString:@"nav"]) {
        return YES;
    }else if ([key isEqualToString:@"active"]) {
        return YES;
    }else if ([key isEqualToString:@"coupons"]) {
        return YES;
    }else if ([key isEqualToString:@"goods"]) {
        return YES;
    }
    return NO;
}
#pragma mark -- 请求全部商品的数据
- (void)requestAllgoodsData{
    [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.page success:^(ResponseObject *responseObject) {
        [self analyseAllgoodsData:responseObject];
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- 分析全部商品的数据
- (void)analyseAllgoodsData:(ResponseObject *)responseObject{
    NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);

    self.storeCol.mj_footer = self.fRefresh;
    if (responseObject.status > 0) {
        //数据存在
        if (responseObject.data) {
            if ([responseObject.data isKindOfClass:[NSArray class]]) {
                NSArray *array = responseObject.data;
                for (NSInteger i = 0; i < array.count; i++) {
                    NSDictionary *dic = array[i];
                    
                    HStoreDetailModel *baseModel =[HStoreDetailModel mj_objectWithKeyValues:dic];
                    if ([self selectWantDataAddDataArrayWithKey:baseModel.key]) {
                        if (self.page == 1) {
                            //第一次加载的时候
                            if (baseModel.items) {
                                if (baseModel.items.count == 0) {
                                    [self.dataArray addObject:baseModel];
                                    [self selectCellByKey:@"prompt"];
                                    [self.storeCol.mj_footer endRefreshingWithNoMoreData];
                                }else{
                                    [self selectCellByKey:@"goods"];
                                    [self.dataArray addObject:baseModel];
                                    [self.storeCol.mj_footer endRefreshing];
                                }
                                
                            }else{
                                [self.storeCol.mj_footer endRefreshingWithNoMoreData];
                            }
                            
                        }else{
                            //下载加载更多的时候
                            HStoreDetailModel *allGoods = [self.dataArray lastObject];
                            if (baseModel.items) {
                                if (baseModel.items.count == 0) {
                                    [self.storeCol.mj_footer endRefreshingWithNoMoreData];
                                }else{
                                    [allGoods.items addObjectsFromArray:baseModel.items];
                                    [self.storeCol.mj_footer endRefreshing];
                                }
                                
                            }else{
                                [self.storeCol.mj_footer endRefreshingWithNoMoreData];
                            }
                        }

                    }
                    
                    
                    
                }
            }
        }else{
            if (self.page == 1) {
                HStoreDetailModel *baseModel =[[HStoreDetailModel alloc] init];
                [self.dataArray addObject:baseModel];
                [self selectCellByKey:@"prompt"];
            }
            [self.storeCol.mj_footer endRefreshingWithNoMoreData];
        }

    }else{
        if (self.page == 1) {
            HStoreDetailModel *baseModel =[[HStoreDetailModel alloc] init];
            [self.dataArray addObject:baseModel];
            [self selectCellByKey:@"prompt"];
        }
        [self.storeCol.mj_footer endRefreshingWithNoMoreData];
    }
        [self.storeCol reloadData];
    
}

- (void)selectCellByKey:(NSString *)key{
    if ([key isEqualToString:@"focus"]) {
        [self.cellArray addObject:@"HStoreHeaderCell"];
    }
    if ([key isEqualToString:@"nav"]) {
        [self.cellArray addObject:@"HStoreFiveModuleCell"];
    }
    if ([key isEqualToString:@"active"]) {
        [self.cellArray addObject:@"HShopActiveCell"];
    }
    if ([key isEqualToString:@"coupons"]) {
        [self.cellArray addObject:@"HShopCouponCell"];
    }
    if ([key isEqualToString:@"goods"]) {
        [self.cellArray addObject:@"HStoreGoodsCell"];
    }
    if ([key isEqualToString:@"prompt"]) {
        [self.cellArray addObject:@"HPromptCell"];
    }

    
}
#pragma  mark --  创建一个view，用来放，推荐，销量，价格，评价，四个按钮
- (void)configmentHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, headerHeight)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
    //排除在滚动中多次创建添加_headerView
    _isFirst = YES;
}
#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    HAllClassVC *classify = [[HAllClassVC alloc] init];
    classify.keyParamete = @{@"paramete":self.shop_id};
    [classify.searchField becomeFirstResponder];
    [self.navigationController pushViewController:classify animated:NO];
    
    
}
/**懒加载*/
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[XLPlainFlowLayout alloc] init];
        _flowLayout.naviHeight = 0;
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _flowLayout;
}
- (UICollectionView *)storeCol{
    if (_storeCol == nil) {
        _storeCol = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY , screenW, screenH - self.startY ) collectionViewLayout:self.flowLayout];
        _storeCol.delegate = self;
        _storeCol.dataSource = self;
        _storeCol.showsVerticalScrollIndicator = NO;
        [_storeCol registerClass:[HStoreHeaderCell class] forCellWithReuseIdentifier:@"HStoreHeaderCell"];
        [_storeCol registerClass:[HStoreFiveModuleCell class] forCellWithReuseIdentifier:@"HStoreFiveModuleCell"];
        [_storeCol registerClass:[HShopActiveCell class] forCellWithReuseIdentifier:@"HShopActiveCell"];
        [_storeCol registerClass:[HShopCouponCell class] forCellWithReuseIdentifier:@"HShopCouponCell"];
        [_storeCol registerClass:[HStoreGoodsCell class] forCellWithReuseIdentifier:@"HStoreGoodsCell"];
        [_storeCol registerClass:[HStoreHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HStoreHeader"];
        [_storeCol registerClass:[HStoreClearHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HStoreClearHeader"];
        [_storeCol registerClass:[HPromptCell class] forCellWithReuseIdentifier:@"HPromptCell"];
        [self.view addSubview:_storeCol];
    }
    return _storeCol;
}

#pragma mark -- 获得更过数据
- (void)loadMoreData{
    self.page++;
    [self requsetMoreData];
}
#pragma mark -- 请求更多的数据
- (void)requsetMoreData{
    [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.page success:^(ResponseObject *responseObject) {
        [self analyseAllgoodsData:responseObject];
        [self.storeCol reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- storeHeader的代理方法,点击请求数据
- (void)requestDataWithsort:(id)sort sortOrder:(NSString *)sortOrder{
    self.sort = [sort integerValue];
    self.sortOrder = sortOrder;
    self.page = 1;
    self.storeCol.mj_footer.state = MJRefreshStateIdle;
    [[UserInfo shareUserInfo]gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.page success:^(ResponseObject *responseObject) {
        NSDictionary *dic = [responseObject.data lastObject];
        HStoreDetailModel *baseModel =[HStoreDetailModel mj_objectWithKeyValues:dic];
        HStoreDetailModel *model = [self.dataArray lastObject];
        
        [model.items removeAllObjects];
        [model.items addObjectsFromArray:baseModel.items];
        [self.storeCol reloadData];
        //点击之后滑动到组头
        for (NSInteger i = 0; i < self.dataArray.count;i++) {
            HStoreDetailModel *baseModel = self.dataArray[i];
            if ([baseModel.key isEqualToString:@"nav"]) {
                if (baseModel.items && (baseModel.items.count > 0)) {
                    LOG(@"%@,%d,%f",[self class], __LINE__,self.headerY)
                    self.storeCol.contentOffset = CGPointMake(0, self.headerY);
                    
                }
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
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


#pragma mark -- collectionview 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.cellArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.cellArray[section] isEqualToString:@"HStoreFiveModuleCell"]) {
        HStoreDetailModel *baseModel = self.dataArray[section];
        return baseModel.items.count;
    }
    if ([self.cellArray[section] isEqualToString:@"HStoreGoodsCell"]) {
        HStoreDetailModel *baseModel = self.dataArray[section];
        return baseModel.items.count;
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HStoreBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellArray[indexPath.section] forIndexPath:indexPath];
    cell.shop_id = self.shop_id;
    
    if ([self.cellArray[indexPath.section] isEqualToString:@"HStoreFiveModuleCell"]) {
        HStoreDetailModel *baseModel = self.dataArray[indexPath.section];
        cell.subModel = baseModel.items[indexPath.row];
        
    } else if([self.cellArray[indexPath.section] isEqualToString:@"HStoreGoodsCell"]) {
        HStoreDetailModel *baseModel = self.dataArray[indexPath.section];
        cell.subModel = baseModel.items[indexPath.row];
        
    }else{
        cell.baseModel = self.dataArray[indexPath.section];
    }
    
    //添加优惠券的代理
    if ([self.cellArray[indexPath.section] isEqualToString:@"HShopCouponCell"]) {
        HShopCouponCell *couponsCell = (HShopCouponCell *)cell;
        couponsCell.delegate = self;
    }
    //添加店铺活动的代理
    if ([self.cellArray[indexPath.section] isEqualToString:@"HShopActiveCell"]) {
        HShopActiveCell *active = (HShopActiveCell *)cell;
        if (self.activeCell != cell) {
            [self.activeCell removeTiemr];
            self.activeCell = nil;
            self.activeCell = active;
        }
        active.delegate = self;
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HStoreHeaderCell"]) {
        HStoreHeaderCell *headerCell = (HStoreHeaderCell *)cell;
        
        headerCell.delegate = self;
    }
    return cell;
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *clear = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if([self.cellArray[indexPath.section] isEqualToString:@"HStoreGoodsCell"]) {
            HStoreHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HStoreHeader" forIndexPath:indexPath];
            header.delegate = self;
            self.header = header;
            
            return header;
            
        }
       
         HStoreClearHeader *cl = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HStoreClearHeader" forIndexPath:indexPath];
        clear =cl;
        
    }
   
    return clear;
    
}






//*header的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 0);
    if ([self.cellArray[section] isEqualToString:@"HStoreGoodsCell"]) {
        return size = CGSizeMake(screenW, 51 * SCALE);
    }
    return size;
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.cellArray[indexPath.section] isEqualToString:@"HStoreHeaderCell"]) {
        return CGSizeMake(screenW, channelHeader);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HStoreFiveModuleCell"]) {
        HStoreDetailModel *baseModel = self.dataArray[indexPath.section];
        
        return CGSizeMake(screenW*1.0/(baseModel.items.count *1.0), navHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HShopActiveCell"]) {
        return CGSizeMake(screenW, activeHeight);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HShopCouponCell"]) {
        
        return CGSizeMake(screenW, coupontHeight);
        
        
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HStoreGoodsCell"]) {
        return CGSizeMake(goodsWidth, goodsHeight);
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HPromptCell"]) {
        return CGSizeMake(screenW , 80);
    }

    
    return CGSizeMake(0, 0);

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([self.cellArray[section] isEqualToString:@"HStoreFiveModuleCell"]) {
        return UIEdgeInsetsMake(0, 0, navBottom, 0);
    }
    if ([self.cellArray[section] isEqualToString:@"HShopCouponCell"]) {
        return UIEdgeInsetsMake(0, 0, coupontBottom, 0);
    }
    if ([self.cellArray[section] isEqualToString:@"HStoreGoodsCell"]) {
        self.flowLayout.sectionInset = UIEdgeInsetsMake(goodsTop, goodsLeft, goodsBottom, goodsRight);
        return UIEdgeInsetsMake(goodsTop, goodsLeft, goodsBottom, goodsRight);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.cellArray[section] isEqualToString:@"HStoreFiveModuleCell"]) {
        return 0;
    }
    if ([self.cellArray[section] isEqualToString:@"HStoreGoodsCell"]) {
        return goodsinter;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.cellArray[section] isEqualToString:@"HStoreFiveModuleCell"]) {
        return 0;
    }
    if ([self.cellArray[section] isEqualToString:@"HStoreGoodsCell"]) {
        return goodsLine;
    }
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   //商品的跳转
    if([self.cellArray[indexPath.section] isEqualToString:@"HStoreGoodsCell"]) {
        HStoreDetailModel *baseModel = self.dataArray[indexPath.section];
        HStoreSubModel *subModel = baseModel.items[indexPath.item];
        subModel.keyParamete = @{@"paramete":subModel.goodsID};
        
        [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
    }
    if ([self.cellArray[indexPath.section] isEqualToString:@"HStoreFiveModuleCell"]) {
        HStoreFiveModuleCell *cell = (HStoreFiveModuleCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.nvaLabel.textColor = THEMECOLOR;
        
        HStoreDetailModel *baseModel = self.dataArray[indexPath.section];
        
        HStoreSubModel *subModel = baseModel.items[indexPath.item];
        subModel.isSelect = YES;
        if ([subModel.actionKey isEqualToString:@"HAllGoodsVC"]) {
            
            subModel.keyParamete = @{@"paramete":self.shop_id,@"VCName":@"HShopVC",@"sellerUser":self.sellerUser};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        }
        if ([subModel.actionKey isEqualToString:@"HAllClassVC"]) {
            
            subModel.keyParamete = @{@"paramete":self.shop_id,@"sellerUser":self.sellerUser};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        }
        if ([subModel.actionKey isEqualToString:@"HStoreStoryVC"]) {
            subModel.keyParamete = @{@"paramete":self.shop_id ,@"sellerUser":self.sellerUser};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        }
        if ([subModel.actionKey isEqualToString:@"HStoreRecommentVC"]) {
            subModel.keyParamete = @{@"paramete":subModel.url,@"sellerUser":self.sellerUser};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        }
        if ([subModel.actionKey isEqualToString:@"HGloryAptitudeVC"]) {
            subModel.keyParamete = @{@"paramete":self.shop_id,@"sellerUser":self.sellerUser};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
        }
        
        
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%@",[self class], __LINE__,indexPath)
    if ([self.cellArray[indexPath.section] isEqualToString:@"HStoreFiveModuleCell"]) {
        HStoreDetailModel *baseModel = self.dataArray[indexPath.section];
        HStoreSubModel *subModel = baseModel.items[indexPath.item];
        subModel.isSelect = NO;
        HStoreFiveModuleCell *cell = (HStoreFiveModuleCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.nvaLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    
    
    
}

#pragma mark -- 聊天

- (void)chat{
    [self message:self.messageButton];
}



#pragma mark -- 优惠券跳转到优惠券详情页面
- (void)HShopCouponCellActionToCouponsDeatilVCWith:(HStoreSubModel *)couponsModel{
   
    couponsModel.actionKey = @"CouponsDetailVC";
    couponsModel.keyParamete = @{@"paramete":couponsModel.coupons_id};
    LOG(@"%@,%d,%@",[self class], __LINE__,couponsModel.keyParamete)
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:couponsModel];
}
#pragma mark -- 跳转到店铺活动页面
- (void)HShopActiveCellActionToShopActiveWith:(HStoreSubModel *)activeModel{
    if ([activeModel.actionKey isEqualToString:@"HGoodsVC"]) {
        activeModel.actionKey = @"HGoodsVC";
    }
    if ([activeModel.actionKey isEqualToString:@"HShopVC"]) {
        activeModel.actionKey = @"HShopVC";
    }
    if ([activeModel.actionKey isEqualToString:@"webpage"]) {
        activeModel.actionKey = @"HDirectActiveVC";
        
    }
    if (activeModel.link) {
        if (activeModel.link.length > 0) {
            activeModel.keyParamete = @{@"paramete":activeModel.link};
            
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:activeModel];
        }
    }
}

#pragma mark -- 分享
- (void)HStoreBaseCellShar{
    
    [UMSocialData defaultData].extConfig.title = self.sharShopName;
    NSString *url = [NSString stringWithFormat:@"%@/Shop/index/shop_id/%@.html?actionkey=shop&ID=%@", WAPDOMAIN,self.shop_id, self.shop_id];
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [UMSocialData defaultData].extConfig.wechatSessionData.url=url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url=url;
    [UMSocialData defaultData].extConfig.qzoneData.url=url;
    [UMSocialData defaultData].extConfig.sinaData.shareText =[NSString stringWithFormat:@" 我在直接捞发现了一个很棒的店铺，快来看看吧 %@@直接捞 %@",self.sharShopName,url];
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"我在直接捞发现了一个很棒的店铺：%@",self.sharShopName];
    UIImageView *sharImage = [[UIImageView alloc] init];
    
    
    [sharImage sd_setImageWithURL:[NSURL URLWithString:self.sharShopName] placeholderImage:placeImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIImage *img =[image imageByScalingToSize:CGSizeMake(100, 100)];
        [UMSocialData defaultData].extConfig.sinaData.shareImage = img;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = img;
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"574e769467e58efcc2000937"
                                          shareText:[NSString stringWithFormat:@"我在直接捞发现了一个很棒的店铺，快来看看吧！"]
                                         shareImage:img
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                           delegate:self];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prep areForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.activeCell removeTiemr];
}




@end
