//
//  HGTopSubGoodsCell.m
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGTopSubGoodsCell.h"
#import "HGTopGoodInfoCell.h"
#import "HGTopPromotionCell.h"
#import "HGTopSpecificationCell.h"
#import "HGTopSubGoodsEvaluateCell.h"
#import "HGTopSubGoodsShopCell.h"
#import "HGTopSubGoodsTableFooter.h"

/**tableview背景view的高度*/
#define backViewHeight screenW
#import "b2c-Swift.h"
#import "HGTopFocusMapView.h"
#import "HGoodsSubGFocusModel.h"
#import "HGoodsSubGinfoModel.h"
#import "HGoodsSubGPromotModel.h"
#import "HGTopSepecificationModel.h"
#import "HGTopSubGoodsEvaluateModel.h"
#import "HGTopSubGoodsShopModel.h"
#import "HomeRefreshHeader.h"
#import "HGTTaxationCell.h"
#import "HGTaxationModel.h"
@interface HGTopSubGoodsCell()<UITableViewDataSource, UITableViewDelegate,HGTopSubGoodsShopCellDelegate,HGTopGoodInfoCellDelegate, GDBannerViewDelegate,CheckImageDelegate>

@property (nonatomic, weak) HGTopFocusMapView *backView;
@property (nonatomic, strong) NSMutableArray *dataArray;
/**背景图片的数据源数组*/
@property (nonatomic, strong) NSMutableArray *backViewDataArr;
/**存放cell的数组*/
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, copy ) NSString *goodsID;
/**下拉刷新*/
@property (nonatomic, strong) HomeRefreshHeader *freshHeader;
/**记录商品的状态*/
@property (nonatomic, assign) NSInteger  goods_status;
@property (nonatomic, weak) GDBannerView *bannerView;

@end
@implementation HGTopSubGoodsCell

- (HomeRefreshHeader *)freshHeader{
    if (_freshHeader == nil) {
        _freshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    }
    return _freshHeader;
}

- (NSMutableArray *)cellArray{
    if (_cellArray == nil) {
        _cellArray = [[NSMutableArray alloc] init];
    }
    return _cellArray;
}
- (NSMutableArray *)backViewDataArr{
    if (_backViewDataArr == nil) {
        _backViewDataArr = [[NSMutableArray alloc] init];
    }
    return _backViewDataArr;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -- 分析数据
- (void)analyzeData{

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /***/
        self.isFirst = YES;
        self.table.backgroundColor = [UIColor clearColor];
        [self.table registerClass:[HGTopGoodInfoCell class] forCellReuseIdentifier:@"HGTopGoodInfoCell"];
        [self.table registerClass:[HGTopPromotionCell class] forCellReuseIdentifier:@"HGTopPromotionCell"];
        [self.table registerClass:[HGTopSpecificationCell class] forCellReuseIdentifier:@"HGTopSpecificationCell"];
        [self.table registerClass:[HGTopSubGoodsEvaluateCell class] forCellReuseIdentifier:@"HGTopSubGoodsEvaluateCell"];
        [self.table registerClass:[HGTopSubGoodsShopCell class] forCellReuseIdentifier:@"HGTopSubGoodsShopCell"];
        [self.table registerClass:[HGTTaxationCell class] forCellReuseIdentifier:@"HGTTaxationCell"];
    }
    return self;
}
- (UITableView *)table{
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        [self.contentView addSubview:_table];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.showsVerticalScrollIndicator = NO;
        _table.showsHorizontalScrollIndicator = NO;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, backViewHeight)];
        backgroundView.backgroundColor = BackgroundGray;
        _table.backgroundView = backgroundView;
        
        GDBannerView *bannerView = [[GDBannerView alloc] initWithFrame:CGRectMake(0, 0, screenW, backViewHeight) subFrame:CGRectMake(screenW - 50, screenW - 30, 40, 25)];
        bannerView.delegate = self;
        
//        HGTopFocusMapView *backView = [[HGTopFocusMapView alloc] initWithFrame:CGRectMake(0, 0, screenW, backViewHeight) withdataArr:self.backViewDataArr];
//        backView.myBlock = ^(NSInteger index){
//        };
//        self.backView = backView;
        self.bannerView = bannerView;
//        backView.backgroundColor = [UIColor whiteColor];
        [backgroundView addSubview:bannerView];
//        [backgroundView addSubview:backView];
        _table.estimatedRowHeight = 100;
        _table.rowHeight = UITableViewAutomaticDimension;
        HGTopSubGoodsTableFooter *tableFooter = [[HGTopSubGoodsTableFooter alloc] initWithFrame:CGRectMake(0, 0, screenW, 40)];
        
        _table.tableFooterView = tableFooter;
        _table.showsVerticalScrollIndicator = NO;
        _table.contentInset = UIEdgeInsetsMake(backViewHeight, 0, 0, 0);
        
        
    }
    return _table;
}
/**传值代理*/
- (void)sentValue:(NSIndexPath *)index dataArr:(NSArray<BannerModel *> *)data rect:(CGRect)viewRect{
    CheckImageView *checkImage = [[CheckImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:checkImage];
    checkImage.delegate = self;
    [checkImage model:data index:index rect:viewRect];
    [checkImage.col scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)sentColIndexWithCurrentIndex:(NSIndexPath *)currentIndex{
    [self.bannerView.collectionview scrollToItemAtIndexPath:currentIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //刷新的时候给backgroundview填充数据源
    self.bannerView.dataArr = self.backViewDataArr;
//    self.backView.dataArr = self.backViewDataArr;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = nil;
    if ([self.cellArray[indexPath.row] isEqualToString:@"HGTopGoodInfoCell"]) {
        HGTopGoodInfoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HGTopGoodInfoCell" forIndexPath:indexPath];
        cell.infoModel = self.dataArray[indexPath.row];
        cell.delegate = self;
        myCell = cell;
    }
    if ([self.cellArray[indexPath.row] isEqualToString:@"HGTopPromotionCell"]) {
        HGTopPromotionCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HGTopPromotionCell" forIndexPath:indexPath];
        cell.promotModel = self.dataArray[indexPath.row];
        myCell = cell;
    }
    if ([self.cellArray[indexPath.row] isEqualToString:@"HGTopSpecificationCell"]) {
        HGTopSpecificationCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HGTopSpecificationCell" forIndexPath:indexPath];
        cell.specificationModel = self.dataArray[indexPath.row];
        myCell = cell;
    }
    if ([self.cellArray[indexPath.row] isEqualToString:@"HGTopSubGoodsEvaluateCell"]) {
        HGTopSubGoodsEvaluateCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HGTopSubGoodsEvaluateCell" forIndexPath:indexPath];
        cell.commentModel = self.dataArray[indexPath.row];
        myCell = cell;
    }
    if ([self.cellArray[indexPath.row] isEqualToString:@"HGTopSubGoodsShopCell"]) {
        HGTopSubGoodsShopCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HGTopSubGoodsShopCell" forIndexPath:indexPath];
        cell.shopModel = self.dataArray[indexPath.row];
        cell.delegate = self;
        myCell = cell;
    }
    if ([self.cellArray[indexPath.row] isEqualToString:@"HGTTaxationCell"]) {
        HGTTaxationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HGTTaxationCell" forIndexPath:indexPath];
        cell.taxationModel = self.dataArray[indexPath.row];
        return  cell;
    }
    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return myCell;
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.table.contentOffset.y > (self.table.contentSize.height - self.table.frame.size.height  + 50)) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showBottomCell" object:self.table userInfo:nil];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    LOG(@"////////////////////////////////////////////////%d,%@", __LINE__,NSStringFromCGSize(self.table.contentSize))
    
    if (self.table.contentOffset.y < -backViewHeight) {
        //计算table的移动距离
        CGFloat move = self.table.contentOffset.y + backViewHeight;
        //背景图片需要移动的距离
        CGFloat y = -move;
        self.bannerView.frame = CGRectMake(0, y, screenW, backViewHeight);
        
    }else{
        
        //计算table的移动距离
        CGFloat move = self.table.contentOffset.y + backViewHeight;
        //背景图片需要移动的距离
        CGFloat y = -move/2.0;
        self.bannerView.frame = CGRectMake(0, y, screenW, backViewHeight);
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

//下拉刷新
- (void)downRefresh{
     LOG(@"%d,%@",__LINE__,@"下拉刷新")
}
#pragma mark -- 将数据对应的view放进数组中
- (void)addCellTOCellArrayWithKey:(NSString *)key{
    if ([key isEqualToString:@"info"]) {
        [self.cellArray addObject:@"HGTopGoodInfoCell"];
    }
    if ([key isEqualToString:@"sales"]) {
        [self.cellArray addObject:@"HGTopPromotionCell"];
    }
    if ([key isEqualToString:@"checked"]) {
        [self.cellArray addObject:@"HGTopSpecificationCell"];
    }
    if ([key isEqualToString:@"comment"]) {
        [self.cellArray addObject:@"HGTopSubGoodsEvaluateCell"];
    }
    if ([key isEqualToString: @"shop"]) {
        [self.cellArray addObject:@"HGTopSubGoodsShopCell"];
    }
    if ([key isEqualToString:@"taxation"]) {
        [self.cellArray addObject:@"HGTTaxationCell"];
    }
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击模型
    if ([self.dataArray[indexPath.row] isKindOfClass:[HGTopSubGoodsEvaluateModel class]]) {
        HGTopSubGoodsEvaluateModel *evaluterModel = self.dataArray[indexPath.row];
        if (evaluterModel.num) {
            LOG(@"%@,%d,%@",[self class], __LINE__,@"查看全部评价")
            if ([self.delegate respondsToSelector:@selector(checkAllEvluate)]) {
                [self.delegate performSelector:@selector(checkAllEvluate)];
            }
        }else{
            
        }
        
    }
    //弹出规格
    if ([self.dataArray[indexPath.row] isKindOfClass:[HGTopSepecificationModel class]]) {
        HGTopSepecificationModel *model = self.dataArray[indexPath.row];
        model.keyParamete = @{@"paramete": indexPath};
        NSDictionary *dict = @{@"model": model, @"action": @"selectSpec"};
        [[NSNotificationCenter defaultCenter] postNotificationName:GOODSSNETVALUE object:nil userInfo:dict];
    }
    
}
#pragma mark -- 跳转到店铺详情页面
- (void)actionToShopDetailVCWith:(HGTopSubGoodsShopModel *)shopModel{
    if ([self.delegate respondsToSelector:@selector(topSubGoodsactionToShopDetailWith:)]) {
        [self.delegate performSelector:@selector(topSubGoodsactionToShopDetailWith:) withObject:shopModel];
    }
}

#pragma mark -- 显示店铺的收藏信息
- (void)HGTopSubGoodsShopCellCollectionShop:(NSString *)promptInformation{
    if ([self judgeGoodsStatusDecideIsBuy]) {
        AlertInSubview(promptInformation)

    }else{
        
    }
}
#pragma mark --  在购买的时候判断商品的状态。
- (BOOL)judgeGoodsStatusDecideIsBuy{
    if (self.goods_status > 0) {
        switch (self.goods_status) {
            case 206:
            {
                return YES;
            }
                break;
                
            default:
                break;
        }
        return YES;
    }else{
        switch (self.goods_status) {
            case -205:
            {
                AlertInSubview(@"商品已下架")
                //商品下架，关闭加入购物车，和立即购买按钮
            }
                break;
            case -206:
            {
                return YES;
                
            }
                break;
                
            default:
                break;
        }
        
        return NO;
        
    }
}

- (void)setGoods_id:(NSString *)goods_id{
    self.goodsID = goods_id;
    
    if (self.isFirst) {
        [self requestInfoData];
    }
    
    
}
- (void)requestInfoData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
    [[UserInfo shareUserInfo] gotGoodsDetailDataWithGoodsID:self.goodsID success:^(ResponseObject *responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //处理商品信息页面的数据
        [self analyseGoodsInfoWithData:responseObject];
        for (HGoodsBaseModel *model in self.dataArray) {
            [self addCellTOCellArrayWithKey:model.key];
            
        }
        [self.table reloadData];
        self.isFirst = NO;
    } failure:^(NSError *error) {
    }];
    
}





#pragma mark -- 处理商品信息的数据
- (void)analyseGoodsInfoWithData:(ResponseObject *)responseObject{
    if (responseObject.status > 0) {
        NSMutableDictionary *notificationDic = [[NSMutableDictionary alloc] init];
        NSArray *dataArr = responseObject.data;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dataArr) {
            if ([dic[@"key"]isEqualToString:@"button"]||[dic[@"key"]isEqualToString:@"nav"]) {
                NSDictionary *navDic = dic;
                for (NSDictionary *shopCarDic in navDic[@"items"]) {
                    if ([shopCarDic[@"name"]isEqualToString:@"购物车"]) {
                        NSString *number = shopCarDic[@"number"];
                        if ([UserInfo shareUserInfo].isLogin) {
                            [notificationDic setObject:number forKey:@"shopCarNumber"];
                        }else{
                            [notificationDic setObject:@"0" forKey:@"shopCarNumber"];
                        }
                        
                    }
                }
                
            }else{
                [array addObject:dic];
            }
        }
        
        
        
        for (NSDictionary *dic in array) {
            NSString *key = dic[@"key"];
            //将背景滚动图片单独拿出来
            
            if ([key isEqualToString:@"focus"]) {
                //如果焦点图存在
                
                if (!([dic[@"items"] isEqual:[NSNull null]]||(dic[@"items"] == nil))) {
                    NSArray *array = dic[@"items"];
                    //焦点图是空的时候那么
                    if (array.count == 0) {
                        
                    }else{
                        NSInteger i = 0;
                        for (NSDictionary *dic in array) {
                            HGoodsSubGFocusModel *focusModel= [HGoodsSubGFocusModel mj_objectWithKeyValues:dic];
                            if (i == 0) {
                                [notificationDic setObject:[NSString stringWithFormat:@"%@/%@", IMGDOMAIN,focusModel.img] forKey:@"sharImageUrl"];
                            }
                            i++;
                            BannerModel *bannerModel = [[BannerModel alloc] initWithDict:nil];
                            bannerModel.img = focusModel.img;
                            [self.backViewDataArr addObject:bannerModel];
                        }
                    }
                    
                    //不存在
                }else{
                    
                }
                
            }
            if ([key isEqualToString:@"info"]) {
                HGoodsSubGinfoModel *infoModel = [HGoodsSubGinfoModel mj_objectWithKeyValues:dic];
                [notificationDic setObject:infoModel.short_name forKey:@"sharGoodsName"];
                if (infoModel.sea) {
                    [notificationDic setObject:infoModel.sea forKey:@"isSea"];
                }
                
                //保存商品的状态
                self.goods_status = infoModel.goods_status;
                [notificationDic setObject:[NSString stringWithFormat:@"%ld",infoModel.goods_status] forKey:@"goodStatus"];
                [notificationDic setObject:infoModel.shelves_at forKey:@"shelvesTime"];
                //
                [self.dataArray addObject:infoModel];
                
                
            }
            if ([key isEqualToString: @"taxation"]) {
                HGTaxationModel *model = [[HGTaxationModel alloc]initWithDict:dic];
                if ([model.sea isEqualToString:@"yes"]) {
                    [self.dataArray addObject:model];
                }
                
            }
            
            
            
            if ([key isEqualToString:@"sales"]) {
                HGoodsSubGPromotModel *promotModel = [HGoodsSubGPromotModel mj_objectWithKeyValues:dic];
                if (promotModel.items && [promotModel.items isKindOfClass:[NSArray class]]&& (promotModel.items.count != 0)) {
                    [self.dataArray addObject:promotModel];
                }
            }
            
            if ([key isEqualToString:@"checked"]) {
                HGTopSepecificationModel *specificalModel = [HGTopSepecificationModel mj_objectWithKeyValues:dic];
                [notificationDic setObject:specificalModel forKey:@"sepecificationModel"];
                //            self. = specificalModel;
                LOG(@"%@,%d,%@",[self class], __LINE__,specificalModel.ishavespec)
                if ([specificalModel.ishavespec isEqualToString:@"1"]) {
                    [self.dataArray addObject:specificalModel];
                }else{
                    
                }
            }
            if ([key isEqualToString:@"comment"]) {
                HGTopSubGoodsEvaluateModel *commentModel =[HGTopSubGoodsEvaluateModel mj_objectWithKeyValues:dic];
                if (!commentModel.num) {
                    //如果评价个数为空
                }
                [self.dataArray addObject:commentModel];
                
            }
            if ([key isEqualToString:@"shop"]) {
                HGTopSubGoodsShopModel *shopModel = [HGTopSubGoodsShopModel mj_objectWithKeyValues:dic];
                [notificationDic setObject:[NSString stringWithFormat:@"%@/%@", IMGDOMAIN,shopModel.img] forKey:@"sharShopLogoURl"];
                
                NSLog(@"%@, %d ,%@,%@",[self class],__LINE__,shopModel.seller_login_name,shopModel.shop_name);

                if (shopModel.seller_login_name) {
                    [notificationDic setObject:shopModel.seller_login_name forKey:@"sellerUser"];
                }
                if (shopModel.shop_name) {
                    [notificationDic setObject:shopModel.shop_name forKey:@"sharShopName"];
                }
                if ([shopModel.sea isEqualToString:@"no"]) {
                    [self.dataArray addObject:shopModel];
                }
                
                
            }
            
        }
        //判断是否有数据
        //添加通知向控制器传值
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            if ([self.dataArray[i] isKindOfClass:[HGTopSepecificationModel class]]) {
                [notificationDic setObject:[NSIndexPath indexPathForRow:i inSection:0] forKey:@"indexPath"];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HGTopSubGoodsCell" object:self userInfo:notificationDic];
    }else{
        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hub.mode=MBProgressHUDModeText;
        hub.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        hub.labelText=[NSString stringWithFormat:@"%@",@"商品失效\n"];
        hub.minSize = CGSizeMake(150, 40);
        hub.labelColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [hub hide:YES afterDelay:2];
        hub.completionBlock = ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goodsHaveRemove" object:nil userInfo:nil];
        };
        
        //
    }
    //筛选之后的数组
}

-(void)dealloc{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"销毁")
}

@end
