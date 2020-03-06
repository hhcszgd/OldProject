//
//  ShopCarFullVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShopCarFullVC.h"
#import "SVCShop.h"
#import "SCShopHeaderView.h"
#import "SCShopFooterView.h"
#import "SCGoodsCell.h"
#import "SCBottomMenuBar.h"
#import "SCBottomMenuBarModel.h"
#import "ConfirmOrderVC.h"
#import "ShopCoupon.h"
#import "PopupCouponsView.h"
#import "EditAddressVC.h"
typedef enum : NSUInteger {
    ChooseGoodsSettleMoney=0,
    ChooseGoodsDelete,
    ChooseGoodsRemove
}  ChooseGoodsAcctionType;

@interface ShopCarFullVC ()<UITableViewDelegate , UITableViewDataSource,SCShopHeaderViewDelegate,SCBottomMenuBarModelDelegate,SCGoodsCellDelegate,EditAddressVCDelegate,PopupCouponsViewDelegate>
@property(nonatomic,strong)SCBottomMenuBarModel * bottomMenuBarModel ;
@property(nonatomic,weak)SCBottomMenuBar * bottomMenuBar ;
@property(nonatomic,strong) NSMutableArray * goodsIDs  ;
@property(nonatomic,assign)BOOL  isFirstApear ;//是否是初次加载 ,如果是就默认全选商品
/** 已经选中的商品的id集合 */
@property(nonatomic,strong)NSMutableArray<NSString*> * goodsIDsBeSelect ;
@property(nonatomic,assign)BOOL  theFirstAfterRefresh ;
@end

@implementation ShopCarFullVC
CGFloat  bottomMenuBarH = 50 ;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paysuccessCallBack) name:CREATEORDERSUCCESS object:nil];
    [self setuptableview];
    [self setupBottomMenuBar];
}

-(void)setuptableview;
{
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-bottomMenuBarH);
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.rowHeight = 95*SCALE;
    tableView.separatorStyle=0;
    self.tableView = tableView ;
    
    tableView.showsVerticalScrollIndicator = NO;
    
    
    HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
    self.tableView.mj_footer = refreshFooter;
    HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_header=refreshHeader;
    
}
-(void)layoutTableview
{
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-bottomMenuBarH);
    self.tableView.frame = frame;
}
-(void)setupBottomMenuBar
{
        SCBottomMenuBar * bottomMenuBar =     [[SCBottomMenuBar alloc]init];
        [self.view addSubview:bottomMenuBar];
    bottomMenuBar.delegate = self;
        self.bottomMenuBar = bottomMenuBar;
    bottomMenuBar.bottomMenuBarModel = self.bottomMenuBarModel;
    [self layoutBottomMenuBar];
}
-(void)layoutBottomMenuBar
{
    CGFloat  barW = screenW;
    CGFloat  barH = bottomMenuBarH ;
    CGFloat  barX = 0 ;
    CGFloat  barY = self.view.bounds.size.height-50;
//    if (self.tabBarController.tabBar.isHidden) {
//        barY = self.view.bounds.size.height-barH;
//    }else{
//        barY = self.view.bounds.size.height-barH-self.tabBarController.tabBar.bounds.size.height;
//    }
    self.bottomMenuBar.frame = CGRectMake(barX, barY, barW, barH);

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.shopCarData.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SVCShop * shop = self.shopCarData[section];
    return shop.list.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell= [[SCGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.goodsModel = [self.shopCarData[indexPath.section] list][indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.SCGoodsCellDelegate=self;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38*SCALE;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SVCShop * shop = self.shopCarData[section];
    if (shop.isManJian) {
        if (section==self.shopCarData.count-1) {
            return 38*SCALE;
        }else{
        return 38*SCALE+10;
        }
    }
    return 10 ;

}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SCShopHeaderView * header =[[SCShopHeaderView alloc]initWithTableView:tableView forSection:section];
//    header.backgroundColor = [UIColor yellowColor];
    header.shopModel=self.shopCarData[section];
    header.SCShopHeaderHelegate = self;
    return header;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    SVCShop * shop = self.shopCarData[section];
    if (shop.isManJian) {//模拟
        SCShopFooterView * footer =  [[SCShopFooterView alloc]init];
        [footer addTarget:self action:@selector(footerClick:) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    }

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SVCGoods * model = [self.shopCarData[indexPath.section] list][indexPath.row];
    model.keyParamete = @{@"paramete":@(model.goods_id)};
    model.actionKey =@"HGoodsVC";
    [[SkipManager shareSkipManager]skipByVC:self withActionModel:model];
//    [[SkipManager shareSkipManager] skipForHomeByVC:self withActionModel:model];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,    model.actionKey)

}



#pragma 尾部代理
-(void)footerClick:(SCShopFooterView*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"满减")
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
///////////////////////////////////////////////////////////////////
#pragma 头部代理方法
//领券
-(void)ticketButtonClickInSCShopHeaderView:(ShopCarBaseComposeView*)shopHeader section:(NSInteger)section{
//        AlertInVC(@"领券")
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"需求改了 , 要从下往上弹框 , 并选择优惠券TODO");
    SVCShop *  shopModel = self.shopCarData[section];
    PopupCouponsView * popupCouponsView = [[PopupCouponsView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    popupCouponsView.PopupCouponsDelegate = self;
    CGFloat timeInterval = 0.2 ;
    popupCouponsView.shopModel = shopModel;
    popupCouponsView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.001];
//    [popupCouponsView showContaintViewAnimate:YES timeInterval:timeInterval];
    [UIView animateWithDuration:timeInterval animations:^{
        popupCouponsView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.33];
        [popupCouponsView showContaintView];
    }];
    
    [popupCouponsView addTarget:self action:@selector(dismissPopuCouponsView:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:popupCouponsView];
    [self.view.window addSubview:popupCouponsView];
    NSArray * arr = shopModel.coupons;
    for (ShopCoupon * couponsModel in arr) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,couponsModel.discount_price);
    }

}
/** 代理 */
-(void)disMissCouponseView:(PopupCouponsView*)view{
    [self dismissPopuCouponsView:view];
}

-(void)dismissPopuCouponsView:(PopupCouponsView*)sender
{
    CGFloat timeInterval = 0.2 ;
//    [sender dismissContaintViewAnimate:YES timeInterval:timeInterval];
    [UIView animateWithDuration:timeInterval animations:^{
         sender.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.001];
//        sender.mj_y = screenH ;
        [sender dismissContaintView];
    }completion:^(BOOL finished) {
        [sender removeFromSuperview];
        
    }];
}
//选择店铺
-(void)chooseShopInSCShopHeaderView:(SCShopHeaderView *)shopHeader section:(NSInteger)section{
//    sender.selected=!sender.selected; // 遍历当前组的小数组 , 改变全部状态 , 合计价格, 和选中商品数量
//    AlertInVC(@"选中/取消选中店铺")
    SVCShop * currentShop = self.shopCarData[section];
    currentShop.shopSelect = !currentShop.shopSelect;
    for (SVCGoods* goods in currentShop.list) {
        goods.goodsSelect = currentShop.shopSelect;
    }
    BOOL tempMark = YES;
    for (SVCShop * shop in self.shopCarData) {
        if (!shop.shopSelect) {
            tempMark=NO;
        }
    }
    shopHeader.shopModel=currentShop;
    //   [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
    [self.tableView reloadData];
     [self trendsSetSettleMoneyView];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"选择店铺")
}

#pragma  点击店铺名 进入店铺
-(void)shopNameButtonClickInSCShopHeaderView:(ShopCarBaseComposeView*)shopHeader section:(NSInteger)section{
    SVCShop * shop = self.shopCarData[section];
    shop.keyParamete = @{@"paramete":shop.shop_id};
    shop.actionKey = @"HShopVC";
    
//    SVCGoods * model = [self.shopCarData[indexPath.section] list][indexPath.row];
//    model.actionKey =@"goods";
    
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:shop];
//    [[SkipManager shareSkipManager] skipForHomeByVC:self withActionModel:shop];
//    AlertInVC(@"进入店铺")
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"进入店铺")
}

#pragma 结算栏代理方法
-(void)chooseAllButtonClickInMenuBar:(SCBottomMenuBar*)bottomMenuBar chooseAllButton:(UIButton*)sender{
//     sender.selected=!sender.selected; // 遍历二维数组 , 改变全部状态  合计价格, 和选中商品数量
    self.bottomMenuBar.bottomMenuBarModel.isAllShopSecect = !self.bottomMenuBar.bottomMenuBarModel.isAllShopSecect ;
    for (SVCShop* bigModel in self.shopCarData) {
        bigModel.shopSelect=self.bottomMenuBarModel.isAllShopSecect;
        
        for (SVCGoods*smallModel in bigModel.list) {
            smallModel.goodsSelect=self.bottomMenuBarModel.isAllShopSecect;
        }
    }
    [self trendsSetSettleMoneyView];
    [self.tableView reloadData];
//    AlertInVC(@"代理执行成功-全部选中")
}


-(void)settleMoneyClickInMenuBar:(SCBottomMenuBar*)bottomMenuBar chooseAllButton:(UIButton*)sender{
    if (bottomMenuBar.bottomMenuBarModel.totalGoodsCount>0) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"正常结算")

        [self gotAddressSuccess:^{
            [self confirmOrderRemoteLoadaWithAtionType:0 Success:^(ResponseObject *response) {
                if (response.status>0) {
                    BaseModel * orderModel = [[BaseModel alloc]init];
                    orderModel.actionKey = @"ConfirmOrderVC";
#pragma 按最原始的方法跳转 创建VC 再用 navigationController push , 方便传值
                    ConfirmOrderVC * confirmOrderVC = [[ConfirmOrderVC alloc ]init];
                    confirmOrderVC.goodsIDs = self.goodsIDs;
                    confirmOrderVC.response = response;
                    [self.navigationController pushViewController:confirmOrderVC animated:YES];
                }else{
                
                    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hub.mode=MBProgressHUDModeText;
                    [hub hide:YES afterDelay:1.5];
                    if (self.goodsIDs.count==1) {
                        hub.labelText=@"该商品已下架,请您再次购买";
                    }else if(self.goodsIDs.count>1){
                        hub.labelText=@"已有商品下架，请刷新重试";
                    }
                    
                }
            } failure:^(NSError *error) {
                MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hub.mode=MBProgressHUDModeText;
                [hub hide:YES afterDelay:1.5];
                if (self.goodsIDs.count==1) {
                    hub.labelText=@"该商品已下架,请您再次购买";
                }else if(self.goodsIDs.count>1){
                    hub.labelText=@"已有商品下架，请刷新重试";
                }
//                hub.completionBlock = ^{
//                    [self.navigationController popViewControllerAnimated:YES];
//                };

            }];
            
        } failure:^{
            AlertInVC(@"未知错误");
        }];
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.goodsIDs)
//        [[SkipManager shareSkipManager] skipForLocalByVC:self withActionModel:orderModel];
//        AlertInVC(@"正常结算")
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"提示先选商品,再结算")
        AlertInVC(@"先选择商品,再结算")
    }
}

#pragma 确认订单接口提前调用
-(void)confirmOrderRemoteLoadaWithAtionType:(LoadDataActionType)actionType Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError *error))failure{
    
    NSMutableArray  * arrM = [NSMutableArray arrayWithCapacity:self.goodsIDs.count];
    
    for (SVCGoods * goods  in self.goodsIDs) {
        
        [arrM addObject:goods.ID];//fuck 到底是id还是goods_id
        //        [arrM addObject:@(goods.goods_id)];
    }
    NSString * jsonStr = [arrM mj_JSONString];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,jsonStr);
    
    [[UserInfo shareUserInfo ] confirmOrderWithGoodsId:jsonStr addressID:nil success:^(ResponseObject *response) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.data);
        success(response);
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        failure(error);
    }];
    
}


#pragma cell的代理方法
-(void)chooseGoodsButtonClickInGoodsCell:(SCGoodsCell*)cell    {
     // 遍历全部数组,判断是否有没被选中的商品,改变当前店铺组 的状态和全选按钮的状态    合计价格, 和选中商品数量

    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    SVCGoods * model = [self.shopCarData[indexPath.section] list][indexPath.row];
    model.goodsSelect = !model.goodsSelect;
    SVCShop * currentShop =self.shopCarData[indexPath.section];
    BOOL shopselect = YES;
    for (SVCGoods * goods in currentShop.list) {
        if (!goods.goodsSelect) {
            shopselect=NO;
        }
    }
    
    currentShop.shopSelect = shopselect;
    [self.tableView reloadData];
    [self trendsSetSettleMoneyView];
}

-(void)minusButtonClickInGoodsCell:(SCGoodsCell*)cell{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"减少商品数量")
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    SVCGoods * model = [self.shopCarData[indexPath.section] list][indexPath.row];
    NSInteger currentNum = model.number;
        currentNum--;
    if (currentNum<1) {
        currentNum=1;
        AlertInVC(@"再减就没了")
    }
    [self changeCountOfGoodsInShopingCarWithGoods:model goodsNum:currentNum  success:^(ResponseObject *response) {
        if (response.status>0) {
            if ([self.delegate respondsToSelector:@selector(shopCarDataHasChanged:)]) {
                [self.delegate shopCarDataHasChanged:self];
            }
        }
    } failure:^(NSError *error) {
        AlertInVC(@"网络错误")
    }];
    

    [self trendsSetSettleMoneyView];
}
-(void)addButtonClickInGoodsCell:(SCGoodsCell*)cell{
    

    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"添加商品数量")
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    SVCGoods * model = [self.shopCarData[indexPath.section] list][indexPath.row];
//    LOG(@"_%@_%d_商品id:%ld",[self class] , __LINE__,model.goods_id)
    NSInteger currentNum = model.number;
    currentNum++;
    NSInteger maxCount = 0 ;
    if ([cell.goodsModel.sub_id integerValue] ==0) {
        maxCount = [cell.goodsModel.stock integerValue];
    }else{
        maxCount = [cell.goodsModel.sub_stock integerValue];
    }
    
    
    
    if (currentNum>maxCount) {
        currentNum=maxCount;
        NSString * tips = [NSString stringWithFormat:@"限购%ld件",maxCount] ;
        AlertInVC(tips);
    }
    

    [self changeCountOfGoodsInShopingCarWithGoods:model goodsNum:currentNum  success:^(ResponseObject *response) {
        if (response.status>0) {
            if ([self.delegate respondsToSelector:@selector(shopCarDataHasChanged:)]) {
                [self.delegate shopCarDataHasChanged:self];
            }
        }
    } failure:^(NSError *error) {
        AlertInVC(@"网络错误")
    }];

}
/**
 if ([self.delegate respondsToSelector:@selector(shopCarDataHasChanged:)]) {
 [self.delegate shopCarDataHasChanged:self];
 }
 */
/** 更改购物车商品数量方法 */
-(void) changeCountOfGoodsInShopingCarWithGoods:(SVCGoods *)goodsModel goodsNum:(NSUInteger)goodsNum success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError*error))failure{
    if (!(NetWorkingStatus>0)) {
        AlertInVC(@"网络断开");
        return;
    }
    if (goodsNum == goodsModel.number) {
        return;
    }
    
    
//    [[UserInfo shareUserInfo] changeCountOfGoodsInShopingCarWithGoodsId:goodsModel.goods_id goodsNum:goodsNum success:^(ResponseObject *response) {
    [[UserInfo shareUserInfo] changeCountOfGoodsInShopingCarWithGoodsId:[goodsModel.ID integerValue] goodsNum:goodsNum success:^(ResponseObject *response) {
        self.theFirstAfterRefresh = YES;
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}





/////////////////////////////////////////////////////////////////
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /** 应产品要求 , 又取消了默认全选 */
//    if (!self.isFirstApear) {
//        self.isFirstApear = YES;
//        [self chooseAllButtonClickInMenuBar:self.bottomMenuBar chooseAllButton:self.bottomMenuBar.chooseAllButton];
//    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self viewWillLayoutSubviews];
  
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    self.tableView.frame = self.view.bounds;
    [self layoutTableview];
    [self layoutBottomMenuBar];

}
-(void)setShopCarData:(NSMutableArray *)shopCarData{
    
    //赋值之前
    [self.goodsIDsBeSelect removeAllObjects];
    for (SVCShop * shop in self.shopCarData) {
        for (SVCGoods * goods in shop.list) {
            if (goods.goodsSelect) {
                [self.goodsIDsBeSelect addObject:goods.ID];
            }
        }
    }
    
    _shopCarData = shopCarData;
    //赋值之后
    for (int i = 0 ; i < shopCarData.count; i++) {
        SVCShop * shopModel = shopCarData[i];
        for (int k = 0; k<shopModel.list.count; k++) {
            SVCGoods * goodsModel = shopModel.list[k];
//            goodsModel.id
            for (NSString * goodsIDStr  in self.goodsIDsBeSelect) {
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,goodsModel.ID);
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,goodsIDStr);
                if ([goodsIDStr isEqualToString:goodsModel.ID]) {
                    goodsModel.goodsSelect = YES;
                    break;
                
                }
            }
        }
    }
    
    
    
    [self trendsSetSettleMoneyView];
    [self.tableView reloadData];


}

-(SCBottomMenuBarModel * )bottomMenuBarModel{
    if(_bottomMenuBarModel==nil){
        _bottomMenuBarModel = [[SCBottomMenuBarModel alloc]init];
//        _bottomMenuBarModel.isAllShopSecect = YES;
    }
    return _bottomMenuBarModel;
}
#pragma mark --------------------------编辑购物车-------------------------------
#pragma 系统自带的侧滑编辑
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //delete
    UITableViewRowAction * delegateBtn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"真的要删除吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        UIAlertAction * ac2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            SVCShop *  shop = self.shopCarData[indexPath.section];
            SVCGoods * goods = shop.list[indexPath.row];
            [self deleteGoods:goods inSection:indexPath.section success:^(ResponseStatus response) {
                LOG(@"_%@_%d_%d",[self class] , __LINE__,response)
            } failure:^(NSError *error) {
                
            }];
            
        }];
        
        [alertVC addAction:ac1];
        [alertVC addAction:ac2];
        
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        
    }];
    //remove
    UITableViewRowAction * removeTo = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
        __block UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"想放进收藏夹吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        
        UIAlertAction * ac2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            
#pragma mark 执行移入收藏夹操作 (先添加到商品收藏, 再从购物车移除)
            SVCShop *  shop = self.shopCarData[indexPath.section];
            SVCGoods * goods = shop.list[indexPath.row];
            [self removeToFavoriteWithGoods:goods atSection:indexPath.section];
            /** 应产品要求 , 移入收藏夹以后 , 该商品继续留在购物车里 (不知道这一移入收藏夹有什么意义) */
            /** 直接刷新好了 */
            [self.tableView reloadData];
        }];
        
        
        [alertVC addAction:ac1];
        [alertVC addAction:ac2];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
    }];
    
    
    removeTo.backgroundColor=THEMECOLOR;
    NSArray * arr = @[delegateBtn,removeTo];
    [self trendsSetSettleMoneyView];
    return arr;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{// 适配iphone5c , 必须实现
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([[otherGestureRecognizer.view class] isSubclassOfClass:[UITableView class]]) {
        return NO;
    }
    
    if( [[otherGestureRecognizer.view class] isSubclassOfClass:[UITableViewCell class]] ||
       [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewCellScrollView"] ||
       [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewWrapperView"]) {
        
        return YES;
    }
    return YES;
}
#pragma 抽取移入收藏夹操作

-(void)removeToFavoriteWithGoods:(SVCGoods*)goods atSection:(NSInteger)section
{
    //执行完移入收藏夹再执行删除操作TODO
//    [[UserInfo shareUserInfo] addGoodsFavoriteWithGoods_id:goods.goods_id Success:^(ResponseStatus response) {
    [[UserInfo shareUserInfo] addGoodsFavoriteWithGoods_id:goods.gid Success:^(ResponseObject *response) {
//        if (response==POST_GOODS_COLLECT_SUCESS||response==POST_GOODS_COLLECT_REPEAT) {//移入收藏夹成功,再从购物车删除
        if(response.status>0){
//            [self deleteGoods:goods inSection:section success:nil failure:nil];
            AlertInVC(@"商品收藏成功\n请前往商品收藏查看")
        }else{
            AlertInVC(@"请勿重复收藏")
        }
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        AlertInVC(@"未知错误")
    }];
}

#pragma 抽取删除操作(购物车所有的删除操作都会调用这个方法)
-(void)deleteGoods:(SVCGoods*)goods inSection:(NSInteger)section success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    
//    [[UserInfo shareUserInfo] deleteShopingCarWithGoodsID:goods.goods_id success:^(ResponseStatus response) {
    [[UserInfo shareUserInfo] deleteShopingCarWithGoodsID:[goods.ID integerValue] success:^(ResponseStatus response) {
    if (response>0) {//服务器删除
            //删除成功
            //本地删除
            SVCShop * shop =  self.shopCarData[section];
            [shop.list removeObject:goods];
            if ([[shop list] count]==0) [self.shopCarData removeObject:shop];
            
            if (success)  success(response);//如果在调用当前方法 , successblock为nil是再这么调会出现坏内存访问
            if ([self.delegate respondsToSelector:@selector(shopCarDataHasChanged:)]) {
                [self.delegate shopCarDataHasChanged:self];
            }
        }else{
            AlertInVC(@"未知错误")
        }
        [self.tableView reloadData];
        [self trendsSetSettleMoneyView];
    } failure:^(NSError *error) {
        //删除失败
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        failure(error);
    }];
    [self trendsSetSettleMoneyView];
    
}


#pragma 动态设置全全按钮/选中了的商品的总价/数量

-(void)trendsSetSettleMoneyView{
//    NSMutableString * goodsIDs  =[[NSMutableString alloc]init];
    NSMutableArray * goodsIDs = [[NSMutableArray alloc]init];
//    self.goodsIDs = goodsIDs;
    BOOL tempBottomSelectAll = YES;//动态根据当前所有商品的选中状态来设置全选按钮的选中与否
    
    /** 移除存储的已选中的商品id */
//    if (!self.theFirstAfterRefresh) {
//        [self.goodsIDsBeSelect removeAllObjects];
//        self.theFirstAfterRefresh=NO;
//    }
    
    CGFloat tempMoney = 0.0;
    NSInteger tempSelectGoodsesCount = 0 ;
    NSInteger tempTotalGoodses = 0 ;
    for (int i=0; i<self.shopCarData.count; i++) {
        SVCShop*shop = self.shopCarData[i];
        BOOL  tempShopSelect = YES;//动态根据当前店铺中商品的选中状态来设置店铺按钮的选中与否
        for (int j =0; j<shop.list.count; j++) {
            SVCGoods * cel = shop.list[j];
//            LOG(@"_%@_%d_%lu",[self class] , __LINE__,cel.number)
            tempTotalGoodses++;
            if (cel.goodsSelect==NO) {
                tempBottomSelectAll = NO;
                tempShopSelect = NO ;
            }else{
//                [self.goodsIDsBeSelect addObject:cel.ID];
                //在这里获取并计算所有被选中的cell的价格,并把总和负值给结算按钮地方的价格
                tempMoney+= cel.shop_price *cel.number;
//                tempMoney+= cel.price *cel.number;//到底返回哪个????fuck//####
                tempSelectGoodsesCount++;
                [goodsIDs addObject:cel];
//                [goodsIDs appendFormat:@",%ld",cel.goods_id];
            }
        }
        shop.shopSelect = tempShopSelect;
        
    }
    self.bottomMenuBarModel.totalMoney = tempMoney;
    self.bottomMenuBarModel.totalGoodsCount =tempSelectGoodsesCount;
    if (tempTotalGoodses==0) {
        //购物车没有商品, 显示相应的提示
        
    }
    if (goodsIDs.count>0) {
        self.goodsIDs = [[NSMutableArray alloc]initWithArray:goodsIDs.copy];
    }
    //    if (self.data.count==0) {
    //        self.settleMoneyModel.isAllEdit=NO;
    //        self.editAllBtn.selected=NO;
    //    }else{
//        self.bottomMenuBarModel.isAllEdit = self.editAllBtn.selected;
    //    }
    self.bottomMenuBarModel.isAllShopSecect = tempBottomSelectAll;
    self.bottomMenuBar.bottomMenuBarModel= self.bottomMenuBarModel;////////////////////////////
    
}

#pragma 把当前选中的商品  结算,删除 或者移入收藏夹

-(void)deleteOrSettleCurrentChooseGoods:( ChooseGoodsAcctionType)acctionType//三种操作都会删除购物车当前选中的商品们
{
    for (int i = 0;i<self.shopCarData.count;i++ ) {
        SVCShop * shop =self.shopCarData[i];
        //        [self.data removeObjectsAtIndexes:<#(nonnull NSIndexSet *)#>]
        for (int j = 0 ; j<shop.list.count ; j++) {
            SVCGoods * goods = shop.list[j];
            if (goods.goodsSelect) {
                
                
                switch (acctionType) {
                    case ChooseGoodsSettleMoney://结算操作
                    {
                        //执行完结算操作再执行删除操作TODO  接口待完善
//                        CGFloat totalMoney = [self settleMoneyCurrentChooseGoods];
                        [self deleteGoods:goods inSection:i success:nil failure:nil];
                    }
                        break;
                    case ChooseGoodsDelete://删除操作
                    {
                        [self deleteGoods:goods inSection:i success:nil failure:nil];
                    }
                        break;
                    case ChooseGoodsRemove://移入收藏夹操作
                    {
                        [self removeToFavoriteWithGoods:goods atSection:i];
                        //执行完移入收藏夹再执行删除操作TODO
                        //                            [[UserInfo shareUserInfo ] addGoodsFavoriteWithGoods_id:goods.goods_id Success:^(ResponseStatus response) {
                        //                                if (response==POST_GOODS_COLLECT_SUCESS) {//移入收藏夹成功,再从购物车删除
                        //
                        //                                    [self deleteGoods:goods inSection:i success:nil failure:nil];
                        //                                }
                        //                            } failure:^(NSError *error) {
                        //
                        //                            }];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
        }
    }
    
}
#pragma 点击 结算 按钮时 获取全部选中的商品的总价格 的内部方法
-(CGFloat)settleMoneyCurrentChooseGoods
{
    CGFloat tempTotalPrice =  0 ;
    for (SVCShop * shop in self.shopCarData) {
        
        for (SVCGoods * goods in shop.list) {
            tempTotalPrice += goods.price;
        }
    }
    return tempTotalPrice;//返回总价格
    //    self.settleMoneyModel.totalMoneyOrMove= tempTotalPrice;
}
#pragma mark --------------------------结束编辑购物车-------------------------------

/** 当购物车有商品被删除的时候 , 通知购物车 , 数据已更新 , 让其重新加载购物车数据 */
/** 刷新回调方法 */
//refreshData
-(void)refreshData
{
    [super refreshData];

    [self.tableView.mj_header endRefreshing];
    
    if ([self.delegate respondsToSelector:@selector(shopCarDataHasChanged:)]) {
        [self.delegate shopCarDataHasChanged:self];
//        self.theFirstAfterRefresh = YES;
    }
    self.tableView.mj_footer.state=MJRefreshStateIdle;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行刷新列表")
}
/** 加载更多的回调方法 */
-(void)LoadMore
{

    [super LoadMore];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}





/** 判断地址是否为空 */
-(void)gotAddressSuccess:(void(^)())success failure:(void(^)())failure{
    [[UserInfo shareUserInfo] gotAddressSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (responseObject.data && [responseObject.data isKindOfClass:[NSArray class]]) {
            if ([responseObject.data count]>0) {
                //正常弹出确认订单
                success();
            }else{
                //弹出添加地址
                [self noticeAddAddress];
            }
           
        }else{
            //弹出添加地址
            [self noticeAddAddress];
        }
        
        
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
    
    
}

-(void)noticeAddAddress
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"您还没有添加收货地址\n请先添加收货地址" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //弹出添加地址控制器
        EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Adding];
        cv.delegate=self;
        [self.navigationController pushViewController:cv animated:YES];
        
    }];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:sure];
    [alertVC addAction:cancle];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)endEditingAddress{
    [self settleMoneyClickInMenuBar:self.bottomMenuBar chooseAllButton:nil];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"添加完毕");
//    BaseModel * orderModel = [[BaseModel alloc]init];
//    orderModel.actionKey = @"ConfirmOrderVC";
//#pragma 按最原始的方法跳转 创建VC 再用 navigationController push , 方便传值
//    ConfirmOrderVC * confirmOrderVC = [[ConfirmOrderVC alloc ]init];
//    confirmOrderVC.goodsIDs = self.goodsIDs;
//    [self.navigationController pushViewController:confirmOrderVC animated:YES];
}



//-(void)paysuccessCallBack
//{
//    [self.tableView reloadData];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"创建订单成功的回调");
//}

-(NSMutableArray * )goodsIDsBeSelect{
    if(_goodsIDsBeSelect==nil){
        _goodsIDsBeSelect = [[NSMutableArray alloc]init];
    }
    return _goodsIDsBeSelect;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//-(void)
//{
//    [self confirmOrderRemoteLoadaWithAtionType:Init Success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.data);
//        if (response.status>0) {
//            [self removeTheViewWhenConnect];
//            
//            if ([response.data isKindOfClass:[NSArray class]]) {
//                for (int i =0 ; i < [response.data count]; i++ ) {
//                    NSDictionary * sub = response.data[i];
//                    ConfirmOrderNormalCellModel * model = [[ConfirmOrderNormalCellModel alloc]initWithDict:sub];
//                    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.channel);
//                    if (i==1){
//                        self.showgoodsesView.cellModel = model;
//                    }else{
//                        if ([model.channel isEqualToString:@"userInfo"]) {
//                            NSMutableArray * items = [NSMutableArray array];
//                            for (int i = 0 ; i < model.items.count; i++) {
//                                id subsub = model.items[i];
//                                AMCellModel * itmeModel = [[AMCellModel alloc]initWithdictionary:subsub];
//                                [items addObject:itmeModel];
//                                if (i==0) {
//                                    self.addressModel = itmeModel;
//                                }
//                            }
//                            model.items = items;
//                            self.confirmOrderAddressView.cellModel = model;
//                            
//                        }else if ([model.channel isEqualToString:@"pay"]){
//                            LOG_METHOD
//                            self.payType.cellModel = model;
//                        }else if ([model.channel isEqualToString:@"invoice"]){
//                            model.showArrow = YES;
//                            self.invoiceInfo.normalCellModel = model;
//                        }else if ([model.channel isEqualToString:@"coupon"]){
//                            
//                            //                            model.showArrow = YES;
//                            self.chooseCoupon.normalCellModel=model;
//                        }else if ([model.channel isEqualToString:@"Lcoin"]){
//                            self.LB.normalCellModel=model;
//                        }else if ([model.channel isEqualToString:@"money"]){
//                            model.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
//                            self.goodsPrice.normalCellModel = model;
//                        }else if ([model.channel isEqualToString:@"freight"]){
//                            model.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
//                            self.freight.normalCellModel = model;
//                        }else if ([model.channel isEqualToString:@"total"]){
//                            self.confirmOrderBar.orderBarModel = model;
//                            self.originMoney = model.subtitle;//记录最初的总价
//                            
//                        }
//                        
//                    }
//                    
//                    [self.datas addObject:model];
//                }
//                //根据优惠券和LB动态展示
//                ConfirmOrderNormalCellModel* discountResultModel =[[ConfirmOrderNormalCellModel alloc]init];
//                discountResultModel.rightTitleColor = [UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.0 alpha:1];
//                
//                //                    discountResultModel.subtitle = @"这次折扣了1块钱";
//                self.discountResult.normalCellModel = discountResultModel ;
//                //                self.choosedCoupons = @[];
//                //                self.usedLB = 100 ;
//                self.usedLB = 0 ;
//                self.choosedCoupons=nil;
//            }
//        }else{
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"操作失败 , 请重新生成订单")
//        }
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"请求失败")
//        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height - self.startY)];
//    }];
//    
//}
//
//-(void)confirmOrderRemoteLoadaWithAtionType:(LoadDataActionType)actionType Success:(void(^)(ResponseObject *response))success failure:(void(^)(NSError *error))failure{
//    
//    NSMutableArray  * arrM = [NSMutableArray arrayWithCapacity:self.goodsIDs.count];
//    for (SVCGoods * goods  in self.goodsIDs) {
//        LOG(@"%@,%d,%@",[self class], __LINE__,goods.ID)
//        [arrM addObject:goods.ID];
//    }
//    NSString * jsonStr = [arrM mj_JSONString];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,jsonStr);
//    
//    [[UserInfo shareUserInfo ] confirmOrderWithGoodsId:jsonStr success:^(ResponseObject *response) {
//        success(response);
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//        failure(error);
//    }];
//    
//}
@end
