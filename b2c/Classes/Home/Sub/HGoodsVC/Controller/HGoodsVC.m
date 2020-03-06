//
//  HGoodsVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGoodsVC.h"
#import "HGoodsTopCell.h"
#import "HGoodsBottomCell.h"
#import "HGTopGoodInfoCell.h"
#import "XMPPJID.h"
#import "HGoodsBaseCell.h"
#import "b2c-Swift.h"
#import "HSelectSpecView.h"
#import "ShopCarVC.h"
#import "HGSubMenuView.h"
#import "LoginNavVC.h"

#import "HSepcSubModel.h"
#import "HSepcSubTypeDetailModel.h"
#import "EditAddressVC.h"
#import "HGTopSubGoodsCell.h"
#import "HGTopSpecificationCell.h"
#import "GoodsTopCollection.h"
@interface HGoodsVC ()<TitleViewDelegate,HGoodsTopDelegae,HGoodsBottomCellDelegate,HSelectSpecViewDelegate,HGMoreViewDelegate,EditAddressVCDelegate>
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**是否收藏商品*/
@property (nonatomic, assign) BOOL isCollectionGoods;

@property (nonatomic, weak) HGoodsTopCell *topCell;

/**商品id*/
@property (nonatomic, copy) NSString *goods_id;
/**选规格的模型*/
@property (nonatomic, weak) HSelectSpecView *specView;



/**table*/
@property (nonatomic, strong) UITableView *subTableView;
/**卖家用户名*/
@property (nonatomic, copy) NSString *sellerUser;

/**分享图片的URL地址*/
@property (nonatomic, copy) NSString *sharImageUrl;
/**分享店铺的名字*/
@property (nonatomic, copy) NSString *sharShopName;
/**分享商品的名字*/
@property (nonatomic, copy) NSString *sharGoodsName;
/**分享店铺的logo*/
@property (nonatomic, copy) NSString *sharShopLogoURl;
/**商品的状态的状态码*/
@property (nonatomic, assign) NSInteger goodStatus;
/**商品预售时间*/
@property (nonatomic, copy) NSString *shelvesTime;
/**选规格cell所在的indexPath*/
@property (nonatomic, strong) NSIndexPath *specInfoIndexPath;
//加入购物车之前购物车的数量
@property (nonatomic, assign) NSInteger shopCarCount;
/**b保存已经被选中的规格*/
@property (nonatomic, copy) NSString *haveSelectSpec;
@property (nonatomic, strong) NSMutableArray *resetSelectIndexPath;
@property (nonatomic, strong) HSpecSubGoodsDeatilModel *resetGoodsModel;
@property (nonatomic, weak) ZkqSelectSpec *selectSpecView;
@property (nonatomic, copy) NSString *isSea;
@end

@implementation HGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.goods_id = self.keyParamete[@"paramete"];
    NSLog(@"%@, %d ,%@",[self class],__LINE__,self.goods_id);

    //数据没有加载出来的时候titleview是不能使用的。                                      
    self.titleView.userInteractionEnabled = NO;
    //初始化的时候是不收藏
    self.isCollectionGoods = NO;

    self.naviTitle = nil;
    [self addCol];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodsInfo:) name:@"HGTopSubGoodsCell" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarChange:) name:SHOPCARDATACHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationBack) name:@"goodsHaveRemove" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:GOODSSNETVALUE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBottomCell:) name:@"showBottomCell" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTopCell:) name:@"showTopCell" object:nil];
    [self judgeGoodsIsCollection:^{
        
    } failure:^{
        
    }];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.specView = nil;
}



#pragma mark -- 讲商品页面的值传到控制器
- (void)goodsInfo:(NSNotification *)goodsInfo{
    NSDictionary *info = goodsInfo.userInfo;
    self.isSea = info[@"isSea"];
    [self judgeGoodsStatusDecideIsBuy];
    self.sellerUser = info[@"sellerUser"];
    self.sharImageUrl = info[@"sharImageUrl"];
    self.sharShopName = info[@"sharShopName"];
    self.sharGoodsName = info[@"sharGoodsName"];
    self.sharShopLogoURl = info[@"sharShopLogoURl"];
    self.goodStatus = [info[@"goodStatus"] integerValue];
    self.shelvesTime = info[@"shelvesTime"];
    self.sepecificationModel = info[@"sepecificationModel"];
    self.titleView.userInteractionEnabled = YES;
    NSString *shopCarNumber = info[@"shopCarNumber"];
    for (NSString *key in info.allKeys) {
        if ([key isEqualToString:@"indexPath"]) {
            self.specInfoIndexPath = info[@"indexPath"];
        }
    }
    [self configmentBottomView];
    [self.shopCarBtn editShopCarNumber:shopCarNumber];
    
}
- (void)configmentBottomView{
    if ([self.isSea isEqualToString:@"yes"]) {
        self.titleView.defaultColor = [UIColor colorWithHexString:@"c456b0"];
        self.shopCarBtn.numBackColor = [UIColor colorWithHexString:@"c456b0"];
        self.colsultBtn.frame = CGRectMake(0, screenH - bottomBtnHeight, 72.5 * SCALE, bottomBtnHeight);
        self.collectionBtn.frame = CGRectMake(72.5 * SCALE, screenH - bottomBtnHeight, 72.5 * SCALE, bottomBtnHeight);
        self.addSHopCar.frame = CGRectMake(145 * SCALE, screenH - bottomBtnHeight, (screenW - 145 * SCALE)/2.0, bottomBtnHeight);
        self.addSHopCar.backgroundColor = [UIColor colorWithHexString:@"ffbc44"];
        self.quickBuy.frame = CGRectMake(self.addSHopCar.frame.size.width + 145 * SCALE, screenH - bottomBtnHeight, (screenW - 145 * SCALE)/2.0, bottomBtnHeight);
        self.quickBuy.backgroundColor = [UIColor colorWithHexString:@"c456b0"];
    }else {
        self.titleView.defaultColor = THEMECOLOR;
        self.shopCarBtn.numBackColor = THEMECOLOR;
        self.addSHopCar.frame = CGRectMake(0, screenH - bottomBtnHeight, (screenW)/2.0, bottomBtnHeight);
        self.addSHopCar.backgroundColor = [UIColor colorWithHexString:@"f8bb18"];
        self.quickBuy.frame = CGRectMake(CGRectGetMaxX(self.addSHopCar.frame), screenH - bottomBtnHeight, (screenW)/2.0, bottomBtnHeight);
        self.quickBuy.backgroundColor = [UIColor colorWithHexString:@"ff621c"];
    }
    
}
/**判断商品是否收藏*/
- (void)judgeGoodsIsCollection:(void(^)())success failure:(void(^)())failure {
    if ([UserInfo shareUserInfo].isLogin) {
        [[UserInfo shareUserInfo] judgeGoodsIsCollectionWithGoodsID:self.goods_id success:^(ResponseObject *response) {
            if (response.status < 0) {
                //商品已经被收藏
                [self.collectionBtn setSelected:YES];
            }else {
                [self.collectionBtn setSelected:NO];
            }
            success();
        } failure:^(NSError *error) {
            failure();
            [self.collectionBtn setSelected:NO];
        }];
    } else {
        [self.collectionBtn setSelected:NO];
    }
    
}

#pragma mark 执行各个页面传过来的各种操作
- (void)action:(NSNotification *)notification {
    if (!(self.isViewLoaded && self.view.window)) {
        return;
    }
    BaseModel *model = notification.userInfo[@"model"];
    NSString *action = notification.userInfo[@"action"];
    if ([action isEqualToString:@"goodsShar"]) {
        [self HGoodsTopCellShar];
    }
    if ([action isEqualToString:@"shopShar"]) {
        HGTopSubGoodsShopModel *shopModel = (HGTopSubGoodsShopModel*)model;
        [self HGoodsTopCellSHopSharWithShop:shopModel];
    }
    if ([action isEqualToString:@"goosChat"]) {
        HGTopSubGoodsShopModel *shopModel = (HGTopSubGoodsShopModel*)model;
        [self HGoodsTopCellConsultWithSeller:shopModel];
    }
    if ([action isEqualToString:@"allgoods"]) {
        HGTopSubGoodsShopSubModel *allgoodsModel = (HGTopSubGoodsShopSubModel*)model;
        [self HGoodsTopCellActionToShopAllGoodsVCWith: allgoodsModel];
    }
    if ([action isEqualToString:@"shangxin"]) {
        HGTopSubGoodsShopModel *shopModel = (HGTopSubGoodsShopModel*)model;
        [self HGoodsTopCellactionToshangxin: shopModel];
    }
    if ([action isEqualToString:@"toShop"]) {
        HGTopSubGoodsShopModel *shopModel = (HGTopSubGoodsShopModel*)model;
        [self ClickActionToShopDetailWith:shopModel];
    }
    if ([action isEqualToString:@"selectSpec"]) {
        HGTopSepecificationModel *specModel = (HGTopSepecificationModel *)model;
        [self HGoodsTopCellSelectGoodsSpecificationWith:specModel];
    }
    
}



#pragma mark -- 从购物车返回
- (void)shopCarChange:(NSNotification *)notification{
    [[UserInfo shareUserInfo] gotShopCarNumberSuccess:^(ResponseObject *responseObject) {
        [self.shopCarBtn editShopCarNumber:[NSString stringWithFormat:@"%@", responseObject.data]];
    } failure:^(NSError *error) {
        
    }];
}



/**设置选规格cell的数据*/
- (void)editsepecificationModel{
    //判断是否全部选中
    [self appendingAllSelectSelectStrWith:@""];
    
}
/**拼接全部选中的规格*/
- (void)appendingAllSelectSelectStrWith:(NSString *)spec {
    for (NSInteger i = 0; i < self.resetSelectIndexPath.count; i++) {
        NSString *specRank = @"";
        switch (i) {
            case 0:
            {
                specRank = self.resetGoodsModel.spec1;
            }
                break;
            case 1:
            {
                specRank = self.resetGoodsModel.spec2;
            }
                break;
            case 2:
            {
                specRank = self.resetGoodsModel.spec3;
            }
                break;
            case 3:
            {
                specRank = self.resetGoodsModel.spec4;
            }
                break;
            case 4:
            {
                specRank = self.resetGoodsModel.spec5;
            }
                break;
            default:
                break;
        }
        spec = [spec stringByAppendingFormat:@"%@  ",specRank];
            
        
    }
    self.sepecificationModel.info = @"请选择";
    self.sepecificationModel.myspec = spec;
    NSLog(@"%@, %d ,%@",[self class],__LINE__,self.resetGoodsModel.reserced);

    self.sepecificationModel.num = [self.resetGoodsModel.reserced stringByAppendingString:@"件"];
    

}
- (BOOL)judgeNSObjectIsNullOrNil:(id)object{
    BOOL isOrNo = NO;
    if (object == nil) {
        isOrNo = YES;
    }
    if ([object isEqual:[NSNull null]]) {
        isOrNo = YES;
    }
    return isOrNo;
}
- (void)presentSemiViewwithGoodsID:(NSString *)goods_id viewtype:(typeofView)type btnType:(UIButton *)btn isScreen:(BOOL)isScreen target:(UIView *)targetView {
    /** 确认收货相关  结束 */
    CGRect rect = CGRectMake(0, 0, screenW, screenH);
    HSelectSpecView *specView = [[HSelectSpecView alloc] initWithFrame:rect typeofView:type goods_id:goods_id];
    specView.resetSelectIndexPath = self.resetSelectIndexPath;
    specView.delegate = self;
    specView.fatherVC = self;
    self.specView = specView;
    __weak typeof(specView) weapSpecView = specView;
    weapSpecView.block = ^(){
        [weapSpecView presentSemiView:weapSpecView backView:nil target:targetView ScreenShot:isScreen];
    };
}
//页面将要弹出
- (void)viewWillDisPlay{
    
}
//页面已经弹出
- (void)viewDidDisPlay{
    
}

//页面消失
- (void)viewEndDisPlay{
    [self editsepecificationModel];
    if ([self.sepecificationModel.ishavespec isEqualToString:@"1"]) {
        HGoodsTopCell *goodsTopCell = (HGoodsTopCell *)[self.col cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        UICollectionView *goodsTopCellCol = goodsTopCell.col;
        HGTopSubGoodsCell *topSubGoodsCell = (HGTopSubGoodsCell*)[goodsTopCellCol cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        UITableView *table = topSubGoodsCell.table;
        if (self.specInfoIndexPath.length > 0) {
            HGTopSpecificationCell *topSpecificationCell = [table cellForRowAtIndexPath:self.specInfoIndexPath];
            topSpecificationCell.specificationModel = self.sepecificationModel;
            
        }
        self.specView = nil;
    }
    
    [self openBtn];
}
//发送选中了的规格的indexPath数组
- (void)sentSelectIndexPathArr:(NSMutableArray *)resetSelectIndexPathArr{
    self.resetSelectIndexPath = resetSelectIndexPathArr;
}
//发送已经选中的goodsModel
- (void)selectGoodsDetailModel:(HSpecSubGoodsDeatilModel *)specSubGoodsDetailModel{
    self.resetGoodsModel = specSubGoodsDetailModel;
}
//页面消失后开始加入购物车动画加入购物车已经成功
- (void)viewHiddenAndBeginAnimation{
    
}
//加入购物车失败
- (void)addshopCarfail{
    [self openBtn];
}

/**关闭加入购物车和立即购买按钮*/
- (void)closeBtn{
    self.addSHopCar.enabled = NO;
    self.quickBuy.enabled = NO;
}
/**打开加入购物车和立即关闭按钮*/
- (void)openBtn{
    self.addSHopCar.enabled = YES;
    self.quickBuy.enabled = YES;
}
#pragma mark -- 加入购物车
- (void)addGoodsToShopCar{
    
    BOOL islogin =[UserInfo shareUserInfo].isLogin;
    if ([self judgeGoodsStatusDecideIsBuy]) {
        if (islogin) {
            
            if ([self.sepecificationModel.ishavespec isEqualToString:@"1"]) {
                [self closeBtn];
                [self presentSemiViewwithGoodsID:self.goods_id viewtype:haveTwobtn btnType:self.addSHopCar isScreen:YES target:self.view];
            } else {
                [self addshopCar:^(ResponseObject *response) {
                    if (response.status  < 0) {
                        AlertInVC(response.msg)
                        
                    }else{
                        AlertInVC(@"添加购物车成功")
                    }
                    [self openBtn];
                } failure:^{
                    [self openBtn];
                } btnType:self.addSHopCar];
               
            }
        }else{
            LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
//            [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
            [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

        }
    }
   
    
}
/**选取规格之后添加购物车*/
//商品没有规格的时候添加购物车
- (void)addshopCar:(void(^)(ResponseObject *response))success failure:(void(^)())failure btnType:(UIButton *)btn{
    //首先获取规格
    if (!self.goods_id) {
        return;
    }
    
    [[UserInfo shareUserInfo] gotGoodsSpecWithgoods_id:self.goods_id succes:^(ResponseObject *responseObject) {
        if (responseObject.data) {
            HSepcModel *sepcModel = [HSepcModel mj_objectWithKeyValues:responseObject.data];
            BOOL bol = sepcModel.goodsDeatil && ([sepcModel.goodsDeatil isKindOfClass:[NSArray class]] || [sepcModel.goodsDeatil isKindOfClass:[NSMutableArray class]]);
            if (bol) {
                HSpecSubGoodsDeatilModel *goodsModeal = [sepcModel.goodsDeatil lastObject];
                //加入购物车
                if ([goodsModeal.reserced integerValue] <= 0) {
                    AlertInVC(@"卖家库存不足");
                }
                if (btn == self.addSHopCar) {
                    [[UserInfo shareUserInfo] addShopingCarWithGoods_id:self.goods_id goodsNum:1 sub_id:[goodsModeal.sub_id integerValue] now:@"0" Success:^(ResponseObject *response) {
                        success(response);
                        
                    } failure:^(NSError *error) {
                        failure();
                    }];
                }
                if (btn == self.quickBuy) {
                    
                    [[UserInfo shareUserInfo] addShopingCarWithGoods_id:self.goods_id goodsNum:1 sub_id:[goodsModeal.sub_id integerValue] now:@"1" Success:^(ResponseObject *response) {
                        success(response);
                        if (response.status < 0) {
                            AlertInVC(response.msg)
                        }else{
                            
                            if (!self.goodsDetailModel.sub_id) {
                                self.goodsDetailModel.sub_id = @"0";
                            }
                            [self gotAddressSuccess:^{
                                [self openBtn];
                                //添加购物车成功之后
                                SVCGoods *vcGoods = [[SVCGoods alloc] init];
                                
                                vcGoods.ID = response.data[@"cart_id"];
                                
                                vcGoods.number = [self.goodsDetailModel.reserced integerValue];
                                vcGoods.price = [self.goodsDetailModel.price integerValue];
                                vcGoods.shop_id = [self.sepcModel.shop_id integerValue];
                                ConfirmOrderVC *confirmOrder = [[ConfirmOrderVC alloc] init];
                                NSMutableArray *arr = [NSMutableArray array];
                                [arr addObject:vcGoods];
                                confirmOrder.goodsIDs = arr;
                                [self.navigationController pushViewController:confirmOrder animated:YES];
                                
                            } failure:^{
                                
                                AlertInVC(@"未知错误");
                            }];
                            
                        }
                        
                    } failure:^(NSError *error) {
                        failure();
                    }];
                }
                
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark --  在购买的时候判断商品的状态。
- (BOOL)judgeGoodsStatusDecideIsBuy{
    if (self.goodStatus > 0) {
        switch (self.goodStatus) {
            case 206:
            {
                self.shelvesLabel.frame = CGRectMake(0, screenH - bottomBtnHeight, screenW, bottomBtnHeight);
                self.shelvesLabel.text = [NSString stringWithFormat:@"预售时间：%@",self.shelvesTime];
                return YES;
            }
                break;
                
            default:
                break;
        }
        return YES;
    }else{
        switch (self.goodStatus) {
            case -205:
            {
                AlertInVC(@"商品已下架")
                //商品下架，关闭加入购物车，和立即购买按钮
            }
                break;
            case -206:
            {
                self.shelvesLabel.frame = CGRectMake(0, screenH - bottomBtnHeight, screenW, bottomBtnHeight);
                self.shelvesLabel.text = [NSString stringWithFormat:@"预售时间：%@",self.shelvesTime];
                return YES;
                
            }
                break;
                
            default:
                break;
        }
        
        return NO;
        
    }
}



#pragma 立即购买
- (void)buy{
    BOOL islogin =[UserInfo shareUserInfo].isLogin;
        if ([self judgeGoodsStatusDecideIsBuy]) {
        if (islogin) {
            if ([self.sepecificationModel.ishavespec isEqualToString:@"1"]) {
                [self closeBtn];
                [self presentSemiViewwithGoodsID:self.goods_id viewtype:haveTwobtn btnType:self.addSHopCar isScreen:YES target:self.view];
            } else {
                [self addshopCar:^(ResponseObject *response) {
                    if (response.status  < 0) {
                        AlertInVC(response.msg)
                        
                    }else{
                        
//                        AlertInVC(@"添加购物车成功")
                    }
                    [self openBtn];
                } failure:^{
                    [self openBtn];
                } btnType:self.quickBuy];
                
            }
            
            
        }else{
            LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
//            [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
            [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

        }
    }
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
                [self openBtn];
                [self noticeAddAddress];
            }
            
        }else{
            //弹出添加地址
            [self openBtn];
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


#pragma mark -- 跳转到购物车页面
- (void)toShopCar{
    
    BaseModel *baseModel = [[BaseModel alloc] init];
    baseModel.judge = YES;
    baseModel.actionKey = @"ShopCarVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
    
    
    LOG(@"%@,%d,%@",[self class], __LINE__,@"购物车")
}

#pragma mark -- 跳转到指定的页面
- (void)itemselectClickWithIndexPath:(NSIndexPath * _Nonnull)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
            //            [[KeyVC shareKeyVC] skipToTabbarItemWithIndex:0];
            [[GDKeyVC share] selectChildViewControllerIndexWithIndex:0];
        }
            break;
        case 1:
        {
            BaseModel *baseModel = [[BaseModel alloc] init];
            baseModel.actionKey = @"HSearchVC";
            
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
            
            
        }
            break;
        case 2:
        {
            if ([UserInfo shareUserInfo].isLogin) {
                BaseModel *baseModel = [[BaseModel alloc] init];
                baseModel.actionKey = @"FriendListVC";
                //                XMPPJID *xm = [XMPPJID jidWithUser:self.sellerUser domain:chatDomain resource:@"ios"];
                //                baseModel.keyParamete = @{@"paramete":xm};
                [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
            }else{
                LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
                
                //                [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
                [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
                
            }
        }
            break;
        case 3:
        {
            if ([self judgeGoodsStatusDecideIsBuy]) {
                BOOL isLogin = [[UserInfo shareUserInfo] isLogin];
                if (isLogin) {
                    if (self.goods_id) {
                        [[UserInfo shareUserInfo] judgeGoodsIsCollectionWithGoodsID:self.goods_id success:^(ResponseObject *response) {
                            //商品被收藏状态是<0.
                            if (response.status < 0) {
                                AlertInVC(@"商品已收藏，请勿重复收藏")
                            }else{
                                [self addGoodsSuccess:^{
                                    
                                } failure:^{
                                    
                                }];
                            }
                        } failure:^(NSError *error) {
                            AlertInVC(@"收藏失败，请重新操作")
                        }];
                    }
                    
                    
                }else{
                    LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
                    //                    [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
                    [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
                    
                }
            }
            
        }
            break;
        default:
            break;
    }

}

- (void)HGMoreViewActionToTatargWithIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%@",[self class], __LINE__,indexPath)
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
//            [[KeyVC shareKeyVC] skipToTabbarItemWithIndex:0];
            [[GDKeyVC share] selectChildViewControllerIndexWithIndex:0];
        }
            break;
        case 1:
        {
            BaseModel *baseModel = [[BaseModel alloc] init];
            baseModel.actionKey = @"HSearchVC";
            
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
            
            
        }
            break;
        case 2:
        {
            if ([UserInfo shareUserInfo].isLogin) {
                BaseModel *baseModel = [[BaseModel alloc] init];
                baseModel.actionKey = @"FriendListVC";
//                XMPPJID *xm = [XMPPJID jidWithUser:self.sellerUser domain:chatDomain resource:@"ios"];
//                baseModel.keyParamete = @{@"paramete":xm};
                [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
            }else{
                LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
                
//                [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
                [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

            }
        }
            break;
        case 3:
        {
            if ([self judgeGoodsStatusDecideIsBuy]) {
                BOOL isLogin = [[UserInfo shareUserInfo] isLogin];
                if (isLogin) {
                    if (self.goods_id) {
                        [[UserInfo shareUserInfo] judgeGoodsIsCollectionWithGoodsID:self.goods_id success:^(ResponseObject *response) {
                            //商品被收藏状态是<0.
                            if (response.status < 0) {
                                AlertInVC(@"商品已收藏，请勿重复收藏")
                            }else{
                                [self addGoodsSuccess:^{
                                    
                                } failure:^{
                                    
                                }];
                            }
                        } failure:^(NSError *error) {
                            AlertInVC(@"收藏失败，请重新操作")
                        }];
                    }
                    
                    
                }else{
                    LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
//                    [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
                    [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

                }
            }
            
        }
            break;
        default:
            break;
    }
}
/**添加商品收藏*/
- (void)addGoodsSuccess:(void(^)())success failure:(void(^)())failure{
    if (self.goods_id) {
        [[UserInfo shareUserInfo] addGoodsFavoriteWithGoods_id:self.goods_id Success:^(ResponseObject *response) {
            success();
            if (response.status > 0) {
                [self.collectionBtn setSelected:YES];
                AlertInVC(response.msg);
                
            }else{
                [self.collectionBtn setSelected:NO];
                AlertInVC(response.msg)
            }
            
        } failure:^(NSError *error) {
            failure();
            [self.collectionBtn setSelected:NO];
            AlertInVC(@"收藏失败请重试")
        }];
    }
    
}
/**取消商品收藏*/
- (void)deleteGoodsCollectionSuccess:(void(^)())success failure:(void(^)())failure{
    if (self.goods_id) {
        [[UserInfo shareUserInfo] deleteGoodsFavoriteWithGoodsID:[@[self.goods_id] mj_JSONString] success:^(ResponseStatus response) {
            success();
            if (response > 0) {
                AlertInVC(@"取消收藏");
                [self.collectionBtn setSelected:NO];
                self.isCollectionGoods = NO;
            }else {
                [self.collectionBtn setSelected:YES];
            }
        } failure:^(NSError *error) {
            failure();
            [self.collectionBtn setSelected:NO];
            self.isCollectionGoods = YES;
        }];
    }
    
}
#pragma mark -- titleView的代理R方法
- (void)titleViewScrollToTarget:(id)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[index integerValue] inSection:0];
    [_topCell scrollviewToTargetIndexPath:indexPath];
}
#pragma mark -- 滑动的时候改变按钮
- (void)endScrollSelectIndex:(id)index{
    NSInteger dex = [index integerValue];
    [self.titleView configmentSelectButtonWithItem:dex];
}


#pragma mark -- 显示下面的view
- (void)showBottomCell:(NSNotification *)notification{
    [UIView animateWithDuration:0.3 animations:^{
        self.scroll.contentOffset = CGPointMake(0, 44);
    }];
    [self.navigationBackArr removeAllObjects];
    [self.navigationBackArr addObject:[NSIndexPath indexPathForItem:0 inSection:1]];
    [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    self.subTableView = (UITableView *)notification.object;
    
}
#pragma mark -- 显示上面的view
- (void)showTopCell:(NSNotification *)notification{
    [UIView animateWithDuration:0.3 animations:^{
        self.scroll.contentOffset = CGPointMake(0, 0);
    }];
    [self.navigationBackArr removeAllObjects];
    [self.navigationBackArr addObject:[NSIndexPath indexPathForItem:0 inSection:0]];
    [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
}
#pragma mark -- 添加col
- (void)addCol{
    self.col.backgroundColor = BackgroundGray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HGoodsTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HGoodsTopCell" forIndexPath:indexPath];
        _topCell = cell;
        cell.delegate = self;
        cell.goods_id = self.goods_id;
        cell.backArr = self.navigationBackArr;
//        cell.data = self.dataArr;
        return cell;
        
    }else{
        HGoodsBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HGoodsBottomCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.goods_id = self.goods_id;
        return cell;
//        cell.data = self.goodsDetailArr;
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(screenW, screenH - self.startY -bottomBtnHeight);
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //将要离开这个页面的时候清空数据库
    [[FMDBManager sharFMDBMabager] deleteAllData];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
#pragma mark -- 点击商品跳转到商品详情页面
- (void)clickGoodsActionToTheGoodsDetailVCWith:(HGoodsBottomSubModel *)goodModel{
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:goodModel];
}
#pragma mark -- 跳转到店铺详情页面
- (void)ClickActionToShopDetailWith:(HGTopSubGoodsShopModel *)shopModel{
   LOG(@"%@,%d,%@",[self class], __LINE__,shopModel.actionKey)
    shopModel.actionKey = @"HShopVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:shopModel];
}
#pragma mark -- 跳转到店铺全部商品页面
-(void)HGoodsTopCellActionToShopAllGoodsVCWith:(HGTopSubGoodsShopSubModel *)allGoodsModel{
    
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:allGoodsModel];
}

#pragma 弹出选择规格按钮
- (void)HGoodsTopCellSelectGoodsSpecificationWith:(HGTopSepecificationModel *)object{
    
    self.specInfoIndexPath = object.keyParamete[@"paramete"];
    if ([self judgeGoodsStatusDecideIsBuy]) {
        if (self.specView) {
            
        }else{
            [self presentSemiViewwithGoodsID:self.goods_id viewtype:haveTwobtn btnType:nil isScreen:YES target:self.view];
        }
    }
    
    
}
#pragma mark -- 上新
-(void)HGoodsTopCellactionToshangxin:(HGTopSubGoodsShopModel *)shopModel{
    shopModel.keyParamete = @{@"shangxin":shopModel.shop_id,@"paramete":shopModel.shop_id,@"VCName":@"HGoodsVC"};
    shopModel.actionKey = @"HAllGoodsVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:shopModel];
}
#pragma mark -- 跳转到和卖家聊天页面
- (void)HGoodsTopCellConsultWithSeller:(HGTopSubGoodsShopModel *)shopModel{
    if ([UserInfo shareUserInfo].isLogin) {
         XMPPJID *xm = [XMPPJID jidWithUser:self.sellerUser domain:chatDomain resource:nil];
        BaseModel *baseModel = [[BaseModel alloc] init];
        if (self.sellerUser && xm){
            baseModel.actionKey = ChatVCName;
            baseModel.keyParamete = @{@"paramete":xm};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
        }
        
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
    
//        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

    }
}
- (void)consult {
    [super consult];
    if ([UserInfo shareUserInfo].isLogin) {
        XMPPJID *xm = [XMPPJID jidWithUser:self.sellerUser domain:chatDomain resource:nil];
        BaseModel *baseModel = [[BaseModel alloc] init];
        if (self.sellerUser && xm){
            baseModel.actionKey = ChatVCName;
            baseModel.keyParamete = @{@"paramete":xm};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
        }
        
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
        
        //        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
        
    }
}
- (void)collection:(UIButton *)btn {
    [super collection:btn];
    if ([self judgeGoodsStatusDecideIsBuy]) {
        BOOL isLogin = [[UserInfo shareUserInfo] isLogin];
        if (isLogin) {
            if (self.goods_id) {
                
                [[UserInfo shareUserInfo] judgeGoodsIsCollectionWithGoodsID:self.goods_id success:^(ResponseObject *response) {
                    //商品被收藏状态是<0.
                    if (response.status < 0) {
                        [self deleteGoodsCollectionSuccess:^{
                            
                        } failure:^{
                            
                        }];
                    }else{
                        [self addGoodsSuccess:^{
                            
                        } failure:^{
                            
                        }];
                    }
                } failure:^(NSError *error) {
                    AlertInVC(@"收藏失败，请重新操作")
                }];
            }
            
            
        }else{
            [self.collectionBtn setSelected:NO];
            LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
            //                    [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
            [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
            
        }
    }
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super  viewDidAppear:animated];

}

/** 友盟的回调方法 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)HGoodsTopCellShar{
    if ([self judgeGoodsStatusDecideIsBuy]) {
        [UMSocialData defaultData].extConfig.title = self.sharGoodsName;
        NSString *url = [NSString stringWithFormat:@"%@/Shop/goods_detail/goods_id/%@.html?actionkey=goods&ID=%@", WAPDOMAIN,self.goods_id,self.goods_id];
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.url=url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url=url;
        [UMSocialData defaultData].extConfig.qzoneData.url=url;
        [UMSocialData defaultData].extConfig.sinaData.shareText =[NSString stringWithFormat:@" 我在直接捞发现了一个很棒的商品，快来看看吧。%@ @直接捞 %@",self.sharGoodsName,url];
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"%@",self.sharGoodsName];
        UIImageView *sharImage = [[UIImageView alloc]init];
        
        [sharImage sd_setImageWithURL:[NSURL URLWithString:self.sharImageUrl] placeholderImage:placeImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIImage *img = [image imageByScalingToSize:CGSizeMake(100, 100)];
            [UMSocialData defaultData].extConfig.sinaData.shareImage = img;
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage =img;
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"574e769467e58efcc2000937"
                                              shareText:[NSString stringWithFormat:@"我在直接捞发现了一个很棒的商品，快来看看吧"]
                                             shareImage:img
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                               delegate:self];
        }];
        
        
    }
    

}

- (void)HGoodsTopCellSHopSharWithShop:(HGTopSubGoodsShopModel *)shopModel{
    if ([self judgeGoodsStatusDecideIsBuy]) {
        NSString *url = [NSString stringWithFormat:@"%@/Shop/index/shop_id/%@.html?actionkey=shop&ID=%@", WAPDOMAIN,shopModel.shop_id,shopModel.shop_id];
        [UMSocialData defaultData].extConfig.title = self.sharShopName;
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.url= url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url= url;
        [UMSocialData defaultData].extConfig.sinaData.shareText =[NSString stringWithFormat:@" 我在直接捞发现了一个很棒的店铺，快来看看吧 %@@直接捞 %@",self.sharShopName,url];
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = [NSString stringWithFormat:@"我在直接捞发现了一个很棒的店铺：%@",self.sharShopName];
        UIImageView *sharImage = [[UIImageView alloc]init];
        
        [sharImage sd_setImageWithURL:[NSURL URLWithString:self.sharShopLogoURl] placeholderImage:placeImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIImage *img = [image imageByScalingToSize:CGSizeMake(100, 100)];
            [UMSocialData defaultData].extConfig.sinaData.shareImage = img;
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = img;
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"574e769467e58efcc2000937"
                                              shareText:[NSString stringWithFormat:@"我在直接捞发现了一个很棒的店铺，快来看看吧"]
                                             shareImage:img
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                               delegate:self];
        }];
    
    }
    
    
    
}




#pragma mark -- 重写返回方法实现智能返回
-(void)navigationBack
{
    NSIndexPath *indexPath = [self.navigationBackArr firstObject];
    if (indexPath.item == 0 ) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //当前页面不是商品页的时候点击返回按钮的时候首先滚动到“商品”
        HGoodsTopCell *cell = (HGoodsTopCell *)[self.col cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        [cell scrollviewToFirstItem];
    }
    
    
}



//商品详情页面弹出提示框“bottom页面”
- (void)presentAlertWith:(id)object{
    NSDictionary * paramete = (NSDictionary*)object ;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:paramete[@"title"] message:paramete[@"content"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * actioin = [UIAlertAction actionWithTitle:paramete[@"buttonT"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actioin];
    [self presentViewController:alert animated:YES completion:nil ];
}

/**商品详情页弹出confirm提示框*/
- (void)presentConfirmWith:(id)object{
    UIAlertController *alert = (UIAlertController *)object;
    [self presentViewController:alert animated:YES completion:nil ];

}


- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout = flow;
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY - bottomBtnHeight) collectionViewLayout:self.flowLayout];
        [self.view addSubview:_col];
        
        [_col registerClass:[HGoodsTopCell class] forCellWithReuseIdentifier:@"HGoodsTopCell"];
        [_col registerClass:[HGoodsBottomCell class] forCellWithReuseIdentifier:@"HGoodsBottomCell"];
        [_col setShowsVerticalScrollIndicator:NO];
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _col.delegate = self;
        _col.dataSource = self;
        _col.scrollEnabled = NO;
        _col.bounces = NO;
        
        
    }
    return _col;
}
- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
