//
//  ChooseCounposeVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ChooseCounposeVC.h"
#import "CCCouponsModel.h"
#import "CCCouponsCell.h"
#import "CouponseOfShopModel.h"

@interface ChooseCounposeVC ()<CCCouponsCellDelegate>
@property(nonatomic,strong)NSMutableArray * dataS ;
@property(nonatomic,weak)UIButton * confirmButton ;
@end

@implementation ChooseCounposeVC



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.goodsID =  self.keyParamete[@"paramete"];
    self.automaticallyAdjustsScrollViewInsets = NO ;
    [self gotCouponsListWithJsonArr:self.goodsID Success:^(ResponseObject *responseObject) {
        NSUInteger totalCouponseCount = 0 ;
        for (CouponseOfShopModel * shopModel in self.dataS) {
            totalCouponseCount+= shopModel.coupons.count;

        }
        if (totalCouponseCount==0) {
            AlertInVC(@"暂无优惠券可用")
            return ;
            
        }
        [self setuptableview];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        //TODO加载一个网络错误
        AlertInVC(@"网络连接错误")
    }];

}

-(void)setuptableview;
{
    self.automaticallyAdjustsScrollViewInsets = NO ;

    CGFloat margin = 20 ;
    CGFloat confirmBtnW = self.view.bounds.size.width - margin*2 ;
    CGFloat confirmBtnH = 44 ;
    CGFloat confirmBtnX = margin ;
    CGFloat confirmBtnY = self.view.bounds.size.height-margin -confirmBtnH ;
    
    
    
    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY  -margin -confirmBtnH);
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.rowHeight = 84*SCALE;
    UIView * tableHeader =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
    UIView * tableFooter =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
    
    tableView.tableHeaderView=tableHeader;
    tableView.tableFooterView = tableFooter;
    tableView.separatorStyle=0;
    self.tableView = tableView ;
    
    tableView.showsVerticalScrollIndicator = NO;

    UIButton * confirmButton =  [[UIButton alloc]initWithFrame:CGRectMake(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH)];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.backgroundColor = THEMECOLOR;
    self.confirmButton = confirmButton;
    [self.view addSubview:confirmButton];
    

    
}
-(void)confirmButtonClick:(UIButton*)sender
{
    if ([self.ChooseCounposeDelegate respondsToSelector:@selector(chooseCouponseWithConposeArr:)]) {
        
        NSMutableArray * arrM = [NSMutableArray array];
        for (CouponseOfShopModel*shopModel in self.dataS) {
            for (CCCouponsModel * couponseModel in shopModel.coupons) {
                if (couponseModel.isSelect) {
                    
                    [arrM addObject:couponseModel];
                }
            }
        }
//        NSString * jsonArr = [arrM mj_JSONString];
        
        [self.ChooseCounposeDelegate chooseCouponseWithConposeArr:arrM.copy];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)gotCouponsListWithJsonArr:(NSString*)jsonArr Success:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    
    [[UserInfo shareUserInfo] gotOrderCouponseListWithGoodsID:jsonArr success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
                if ([responseObject.data[@"items"] isKindOfClass:[NSArray class]]) {
                    NSMutableArray * shopArr = [NSMutableArray array];
                    for (id sub in responseObject.data[@"items"]) {
                        if ([sub isKindOfClass:[NSDictionary class]]) {
                            CouponseOfShopModel * shopModel = [[CouponseOfShopModel alloc]initWithDict:sub];
                            NSMutableArray * couponseArr = [NSMutableArray array];
                            if (shopModel.coupons&&shopModel.coupons.count>0) {
                                for (id subsub in shopModel.coupons) {
                                    if ([subsub isKindOfClass:[NSDictionary class]]) {
                                        CCCouponsModel * couponseModel = [[CCCouponsModel alloc]initWithDict:subsub];
                                        [couponseArr addObject:couponseModel];
                                    }
                                }
                                shopModel.coupons = couponseArr;
                            }
                            [shopArr addObject:shopModel];
                        }
                    }
                    self.dataS = shopArr;
                }
            
        }
        
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.dataS);
        success(responseObject);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
    } failure:^(NSError *error) {
        failure(error);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}


#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataS.count ;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataS[section] coupons] count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponseOfShopModel * shopModel = self.dataS[indexPath.section];
    CCCouponsModel * couponseModel = shopModel.coupons[indexPath.row];
    for (CCCouponsModel  *  subModel in self.selectCouponses) {
        if ([couponseModel.cid isEqualToString:subModel.cid]) {
            couponseModel.isSelect=YES;
        }
    }
    couponseModel.img = shopModel.img;
    couponseModel.shopName = shopModel.name;
    CCCouponsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell= [[CCCouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    CCCouponsModel * couponseModel = self.dataS[indexPath.row];
    cell.couponsModel = couponseModel;
    
    cell.CouponsCellDelegate = self;
    return cell;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.selectCouponses=nil;
}
-(void)chooseCouponseInCell:(CCCouponsCell *)cell{
#pragma mark TODO 分组设计  , 一组只能选中一个
    NSIndexPath * currentIndexPath = [self.tableView indexPathForCell:cell];
    
//    CCCouponsModel * model = self.dataS[currentIndexPath.row];

    LOG(@"_%@_%d_%@",[self class] , __LINE__,currentIndexPath);
    CouponseOfShopModel * shopModel = self.dataS[currentIndexPath.section];
    for (int i = 0 ; i < shopModel.coupons.count ; i ++) {
        CCCouponsModel*couponseModel = shopModel.coupons[i];
        if (i==currentIndexPath.row) {
            couponseModel.isSelect = !couponseModel.isSelect;
            
        }else{
            couponseModel.isSelect = NO ;
        }
        cell.couponsModel = couponseModel;
    }
    [self.tableView reloadData];

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        
        return 64*SCALE;
    }
    return 0.00000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 0.000000001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        UIView * header =[[UIView alloc]init];
        CGFloat headerH = 64*SCALE;
        CGFloat headerW  = self.view.bounds.size.width ;
        header.frame = CGRectMake(0, 0, headerW, headerH);
        
        CGFloat topContainerH = headerH -10 ;
        CGFloat topContainerW = headerW;
        UIView * topContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0,topContainerW, topContainerH)];
        topContainer.backgroundColor = [UIColor whiteColor];
        [header addSubview:topContainer];
        
        CGFloat btnW = 88 ;
        CGFloat btnH = 36 ;
        CGFloat margin = 10 ;
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(margin,(topContainerH - btnH)/2, btnW ,btnH)];
        btn.userInteractionEnabled = NO ;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_bg_ke"] forState:UIControlStateNormal];
        [btn setTitle:@"可用" forState:UIControlStateNormal];
        [topContainer addSubview:btn];

        return header;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView * footer =  [[UIView alloc]init];
    footer.backgroundColor  = BackgroundGray;
    return footer;
}


-(NSMutableArray * )dataS{
    if(_dataS==nil){
        _dataS = [[NSMutableArray alloc]init];
        NSMutableArray * couponseArr = [NSMutableArray array];

        _dataS = couponseArr;
        
        
    }
    return _dataS;
}

@end
