//
//  CreateOrderVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CreateOrderVC.h"
#import "COrderNumberCell.h"
#import "COrderNumberModel.h"
#import "COrderUserInfo.h"
#import "COrderUserinfoCell.h"
#import "COrderGooditemCell.h"
#import "COrderGoodSubModel.h"
#import "COrderGooditemModel.h"
#import "COrderPayCell.h"
#import "COrderPayModel.h"
#import "COrderNormalCell.h"
#import "COrderNormalModel.h"
#import "COrderCreateCell.h"
#import "COrderGoodsPriceCell.h"
#import "COrderReduceCell.h"
#import "COrderTureModelCell.h"
#import "ShopCarEmptyVC.h"
#import "CCancleOrderVC.h"
@interface CreateOrderVC ()
@property (nonatomic, strong) UITableView *orderTabel;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**cellData*/
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, strong) UIView *bottomView;
/**原始数据*/
@property (nonatomic, strong) NSMutableArray *primitiveArr;
/**实付款*/
@property (nonatomic, strong) UILabel *truePay;
/**实付金额*/
@property (nonatomic, strong) UILabel *truePayNum;
/**下单时间*/
@property (nonatomic, strong) UILabel *creatOrder;
/**剩余时间*/
@property (nonatomic, strong) UILabel *residueLabel;
@property (nonatomic, strong) NSTimer *timer;
/**天*/
@property (nonatomic, assign) NSInteger d;
/**小时*/
@property (nonatomic, assign) NSInteger h;
/**分钟*/
@property (nonatomic, assign) NSInteger m;
/**秒*/
@property (nonatomic, assign) NSInteger s;

/**可变字典*/
@property (nonatomic, strong) NSMutableDictionary *mutableDic;



@end

@implementation CreateOrderVC
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (NSMutableArray *)cellArr{
    if (_cellArr == nil) {
        _cellArr = [[NSMutableArray alloc] init];
    }
    return _cellArr;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        _bottomView.backgroundColor = BackgroundGray;
    }
    return _bottomView;
}
- (UILabel *)truePay{
    if (_truePay == nil) {
        _truePay = [[UILabel alloc] init];
        
        [_truePay configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"实付款:"];
        [_truePay sizeToFit];
    }
    return _truePay;
}
- (UILabel *)truePayNum{
    if (_truePayNum == nil) {
        _truePayNum = [[UILabel alloc] init];
        [_truePayNum configmentfont:[UIFont systemFontOfSize:15 * zkqScale] textColor:THEMECOLOR backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_truePayNum sizeToFit];
    }
    return _truePayNum;
}
- (UILabel *)creatOrder{
    if (_creatOrder == nil) {
        _creatOrder = [[UILabel alloc] init];
        [_creatOrder configmentfont:[UIFont systemFontOfSize:12 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_creatOrder sizeToFit];
    }
    return _creatOrder;
}
- (UILabel *)residueLabel{
    if (_residueLabel == nil) {
        _residueLabel = [[UILabel alloc] init];
        [_residueLabel configmentfont:[UIFont systemFontOfSize:14 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        
        [_residueLabel sizeToFit];
    }
    return _residueLabel;
}
- (UITableView *)orderTabel{
    if (_orderTabel == nil) {
        _orderTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY - 125) style:UITableViewStylePlain];
        [self.view addSubview:_orderTabel];
        _orderTabel.delegate = self;
        _orderTabel.dataSource = self;
        _orderTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTabel.estimatedRowHeight = 100;
        _orderTabel.rowHeight = UITableViewAutomaticDimension;
        _orderTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_orderTabel registerClass:[COrderNumberCell class] forCellReuseIdentifier:@"COrderNumberCell"];
        [_orderTabel registerClass:[COrderUserinfoCell class] forCellReuseIdentifier:@"COrderUserinfoCell"];
        [_orderTabel registerClass:[COrderGooditemCell class] forCellReuseIdentifier:@"COrderGooditemCell"];
        [_orderTabel registerClass:[COrderPayCell class] forCellReuseIdentifier:@"COrderPayCell"];
        [_orderTabel registerClass:[COrderNormalCell class] forCellReuseIdentifier:@"COrderNormalCell"];
        [_orderTabel registerClass:[COrderCreateCell class] forCellReuseIdentifier:@"COrderCreateCell"];
        [_orderTabel registerClass:[COrderGoodsPriceCell class] forCellReuseIdentifier:@"COrderGoodsPriceCell"];
        [_orderTabel registerClass:[COrderReduceCell class] forCellReuseIdentifier:@"COrderReduceCell"];
        [_orderTabel registerClass:[COrderTureModelCell class] forCellReuseIdentifier:@"COrderTureModelCell"];
    }
    return _orderTabel;
}
- (NSMutableArray *)primitiveArr{
    if (_primitiveArr == nil) {
        _primitiveArr = [[NSMutableArray alloc] init];
    
    }
    return _primitiveArr;
}
- (NSMutableDictionary *)mutableDic{
    if (_mutableDic == nil) {
        _mutableDic = [[NSMutableDictionary alloc] init];
    }
    return _mutableDic;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paysuccessCallBack) name:PAYSUCCESS object:nil];

    self.naviTitle = @"订单详情";
    [self.orderTabel setBackgroundColor:[UIColor whiteColor]];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderTabel.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self configmentBottomView];
    
    
   [self gotOrderDetailSuccess:^{
       [self.orderTabel reloadData];
       [self configmentTurePay];
//       self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(start) userInfo:nil repeats:YES];
       
       
   } failure:^{
       
   }];

}


#pragma mark -- 倒计时
- (void)start{
    
}

#pragma mark -- 赋值
- (void)configmentTurePay{
    for (COrderNormalModel *norModel in self.primitiveArr) {
        if ([norModel.key isEqualToString:@"true_price"]) {
            self.truePayNum.text = [NSString stringWithFormat:@"￥%@",dealPrice(norModel.subtitle)];
        }
        if ([norModel.key isEqualToString:@"order_create_time"]) {
            NSString *startTime = norModel.subtitle;
            //创建日期格式化对象
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
            //创建起始日期对象
            NSDate *startDate = [dateformatter dateFromString:startTime];
            //系统时区，
//            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSDate *toDate = [startDate dateByAddingTimeInterval:7 * 3600 * 24];
//            //获取现在的日期对象
            NSDate *nowDate = [NSDate date];
            //剩余的时间
            NSTimeInterval time = [toDate timeIntervalSinceDate:nowDate];
            NSInteger day = (NSInteger)time/(3600 * 24);
            self.d = day;
            NSInteger hours = (NSInteger)time%(3600 * 24)/3600;
            self.h = hours;
            NSInteger minutes = (NSInteger)time%(3600 * 24)%3600/60;
            self.m = minutes;
            NSInteger seconds = (NSInteger)time%(3600 * 24)%3600%60;
            self.s = seconds;
            //判断是否显示天数以及小时
            NSString *leaveTime = @"";
            if (day == 0) {
                if (hours == 0) {
                    leaveTime = [NSString stringWithFormat:@"%i分",minutes];
                    
                }else{
                    leaveTime = [NSString stringWithFormat:@"%i小时%i分",hours,minutes];
                }
            }else{
               leaveTime = [NSString stringWithFormat:@"%i天%i小时%i分",day,hours,minutes];
            }
            
            NSMutableAttributedString *leave = [[NSMutableAttributedString alloc] initWithString:leaveTime];
            for (NSInteger i = 0; i < leave.length; i++) {
                unichar c  = [leaveTime characterAtIndex:i];
                if (c > '0' && c <= '9') {
                    [leave addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14 *zkqScale] ,NSFontAttributeName, nil]range:NSMakeRange(i, 1)];
                }else{
                    [leave addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12 *zkqScale],NSFontAttributeName, nil] range:NSMakeRange(i, 1)];
                }
            }
            self.residueLabel.attributedText = leave;
            
            
            self.creatOrder.text = [norModel.title stringByAppendingFormat:@":%@",norModel.subtitle];
        }
    }
}

#pragma mark -- 设置bottomView
- (void)configmentBottomView{
    UIView *topView = [[UIView alloc] init];
    [self.bottomView addSubview:topView];
    //上面的视图
    topView.backgroundColor = [UIColor whiteColor];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(0);
        make.left.right.equalTo(self.bottomView);
        make.height.equalTo(@(65));
    }];
    [topView addSubview:self.truePayNum];
    [self.truePayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(16);
        make.right.equalTo(topView.mas_right).offset(-10);
    }];
    [topView addSubview:self.truePay];
    [self.truePay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.truePayNum);
        make.right.equalTo(self.truePayNum.mas_left).offset(-10);
    }];
    [topView addSubview:self.creatOrder];
    [self.creatOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.truePayNum.mas_bottom).offset(7);
        make.right.equalTo(topView.mas_right).offset(-10);
    }];
    
    UILabel *primitTime = [[UILabel alloc] init];
    [self.bottomView addSubview:primitTime];
    [primitTime configmentfont:[UIFont systemFontOfSize:12 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"支付剩余时间:"];
    [primitTime sizeToFit];
    
    [primitTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(15);
        make.left.equalTo(self.bottomView.mas_left).offset(10);
    }];
    [self.bottomView addSubview:self.residueLabel];
    [self.residueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(primitTime.mas_bottom).offset(3);
        make.left.equalTo(self.bottomView.mas_left).offset(10);
    }];
    
    
    
    
    //取消按钮
    UIButton *cancleBtn = [[UIButton alloc] init];
    [self.bottomView addSubview:cancleBtn];
    cancleBtn.layer.borderColor = [[UIColor colorWithHexString:@"999999"] CGColor];
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.layer.cornerRadius = 2;
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15 *zkqScale];
    [cancleBtn addTarget:self action:@selector(canclePay:) forControlEvents:UIControlEventTouchUpInside];
    //去支付按钮
    UIButton *payBtn = [[UIButton alloc] init];
    [self.bottomView addSubview:payBtn];
    
    
    payBtn.layer.cornerRadius = 2;
    payBtn.layer.masksToBounds = YES;
    payBtn.backgroundColor = THEMECOLOR;
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:15 *zkqScale];
    [payBtn addTarget:self action:@selector(toPay:) forControlEvents:UIControlEventTouchUpInside];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(12);
        make.right.equalTo(self.bottomView.mas_right).offset(-10);
        make.height.equalTo(@(36));
         make.width.equalTo(@(81));
    }];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payBtn);
        make.right.equalTo(payBtn.mas_left).offset(-10);
        make.height.equalTo(@(36));
        make.width.equalTo(@(81));
    }];
    
    
    
    //布局显示值
}
#pragma mark -- 取消支付
- (void)canclePay:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定取消该订单吗" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.orderTabel removeFromSuperview];
        [self.bottomView removeFromSuperview];
        
        [[UserInfo shareUserInfo] cancleorderID:self.mutableDic[@"orderID"] success:^(ResponseObject *responseObject) {
            CCancleOrderVC *seeVC =[[CCancleOrderVC alloc] init];
            [self.navigationController pushViewController:seeVC animated:NO];
            LOG(@"%@,%d,%@",[self class], __LINE__,@"删除订单成功")
        } failure:^(NSError *error) {
            LOG(@"%@,%d,%@",[self class], __LINE__,error)
        }];
        
        
        
    }];
    
    UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       LOG(@"%@,%d,%@",[self class], __LINE__,@"我再想想")
    }];
    [alert addAction:cancleAction];
    [alert addAction:tureAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark -- 点击取消按钮


#pragma mark -- 去支付
- (void)toPay:(UIButton *)btn{
    BaseModel *baseModel = [[BaseModel alloc] init];
    baseModel.actionKey = @"ChoosePaymentVC";
    baseModel.keyParamete = @{@"paramete":self.mutableDic};
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

-(void)gotOrderDetailSuccess:(void(^)())success failure:(void(^)())failure{
     NSString * orderNum = self.keyParamete[@"paramete"];
    [[UserInfo shareUserInfo] gotOrderDetailWithOrderID:orderNum success:^(ResponseObject *responseObject) {
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        [self analyDataWith:responseObject];
        success();
    } failure:^(NSError *error) {
       LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        failure();
    }];

}
#pragma mark -- 分析数据
- (void)analyDataWith:(ResponseObject *)responseObject{
    LOG(@"%@,%d,%@",[self class], __LINE__,responseObject.data)
    if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
        LOG(@"%@,%d,%@",[self class], __LINE__,@"返回数据结构不对")
        return;
    }
    //约定的数据结构

    if ([responseObject.data isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dataDic in responseObject.data) {
            NSString *key = dataDic[@"key"];
            [self selectTargetCellWith:key];
            //订单号
            if ([key isEqualToString:@"order"]) {
                COrderNumberModel *orderModel =[COrderNumberModel mj_objectWithKeyValues:dataDic];
                //在可变字典中添加指
                [self.mutableDic setObject:orderModel.ordernumber forKey:@"orderID"];
                [self.dataArray addObject:orderModel];
                
            }
            //个人信息
            if ([key isEqualToString:@"userInfo"]) {
                COrderUserInfo *infoModel =[COrderUserInfo mj_objectWithKeyValues:dataDic];
                [self.dataArray addObject:infoModel];
            }
            //购买产品
            if ([key isEqualToString:@"gooditem"]) {
                COrderGooditemModel *goodsModel = [COrderGooditemModel mj_objectWithKeyValues:dataDic];
                if (goodsModel.items) {
                    [self.mutableDic setObject:goodsModel.items forKey:@"goodses"];
                    [self.dataArray addObject:goodsModel];
                }else{
                    [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
                    return;
                }
                
            }
//            //支付配送
            if ([key isEqualToString:@"pay"]) {
                COrderPayModel *payModel = [COrderPayModel mj_objectWithKeyValues:dataDic];
                [self.dataArray addObject:payModel];
            }
//            //normal
            if ([key isEqualToString:@"invoice"]) {
                COrderNormalModel *normolModel =[COrderNormalModel mj_objectWithKeyValues:dataDic];
                [self.dataArray addObject:normolModel];
            }
//
            if ([key isEqualToString:@"money"]) {
                COrderNormalModel *normolModel =[COrderNormalModel mj_objectWithKeyValues:dataDic];
                [self.dataArray addObject:normolModel];
            }
            if ([key isEqualToString:@"freight"]) {
                COrderNormalModel *normolModel =[COrderNormalModel mj_objectWithKeyValues:dataDic];
                [self.dataArray addObject:normolModel];
            }
            if ([key isEqualToString:@"reduce_price"]) {
                COrderNormalModel *normolModel =[COrderNormalModel mj_objectWithKeyValues:dataDic];
                [self.dataArray addObject:normolModel];
            }
            if ([key isEqualToString:@"taxes"]) {
                //isdisplay "1"是欧洲馆，0不是欧洲馆
                COrderNormalModel *norModel = [COrderNormalModel mj_objectWithKeyValues:dataDic];
                for (id model in self.dataArray) {
                    if ([model isKindOfClass:[COrderUserInfo class]]) {
                        COrderUserInfo *userInfo = (COrderUserInfo *)model;
                        userInfo.is_display = norModel.is_display;
                        break;
                    }
                    
                }
                if ([norModel.is_display isEqualToString:@"1"]) {
                    [self.dataArray addObject:norModel];
                }
            }
            if ([key isEqualToString:@"true_price"]) {
                COrderNormalModel *normolModel =[COrderNormalModel mj_objectWithKeyValues:dataDic];
                [self.mutableDic setObject:normolModel.subtitle forKey:@"price"];
                [self.primitiveArr addObject:normolModel];
            }
            if ([key isEqualToString:@"order_create_time"]) {
                COrderNormalModel *normolModel =[COrderNormalModel mj_objectWithKeyValues:dataDic];
                
                [self.primitiveArr addObject:normolModel];
            }
            
            
            
            
        }
        
    }
}
-(void)reconnectClick:(UIButton *)sender{
    [self gotOrderDetailSuccess:^{
        [self.orderTabel reloadData];
        [self configmentTurePay];
        //       self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(start) userInfo:nil repeats:YES];
        
        
    } failure:^{
        
    }];
}



- (void)selectTargetCellWith:(NSString *)key{
    if ([key isEqualToString:@"order"]) {
        [self.cellArr addObject:@"COrderNumberCell"];
        
    }
    if ([key isEqualToString:@"taxes"]) {
        [self.cellArr addObject:@"COrderNormalCell"];
    }
    //个人信息
    if ([key isEqualToString:@"userInfo"]) {
        [self.cellArr addObject:@"COrderUserinfoCell"];
    }
    //购买产品
    if ([key isEqualToString:@"gooditem"]) {
        [self.cellArr addObject:@"COrderGooditemCell"];
    }
    //支付配送
    if ([key isEqualToString:@"pay"]) {
        [self.cellArr addObject:@"COrderPayCell"];
    }
    //normal
    if ([key isEqualToString:@"invoice"]) {
        [self.cellArr addObject:@"COrderNormalCell"];
    }
    
    if ([key isEqualToString:@"money"]) {
        [self.cellArr addObject:@"COrderGoodsPriceCell"];
    }
    if ([key isEqualToString:@"freight"]) {
        [self.cellArr addObject:@"COrderGoodsPriceCell"];
    }
    if ([key isEqualToString:@"reduce_price"]) {
        [self.cellArr addObject:@"COrderReduceCell"];
    }
//    if ([key isEqualToString:@"true_price"]) {
//        [self.cellArr addObject:@"COrderTureModelCell"];
//    }
//    if ([key isEqualToString:@"order_create_time"]) {
//        [self.cellArr addObject:@"COrderCreateCell"];
//    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //购买商品
    if ([self.dataArray[section] isKindOfClass:[COrderGooditemModel class]]) {
        COrderGooditemModel *goodModel = self.dataArray[section];
        return goodModel.items.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellArr[indexPath.section] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderNumberModel class]]) {
        COrderNumberCell *numberCell = (COrderNumberCell *)cell;
        numberCell.numberModel = self.dataArray[indexPath.section];
        return numberCell;
    }
    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderUserInfo class]]) {
        COrderUserinfoCell *infoCell = (COrderUserinfoCell *)cell;
        infoCell.userInfoModel = self.dataArray[indexPath.section];
        return infoCell;
    }
    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderGooditemModel class]]) {
        COrderGooditemModel *goodModel = self.dataArray[indexPath.section];
        COrderGooditemCell *goodsCell = (COrderGooditemCell *)cell;
        if (indexPath.row == goodModel.items.count - 1) {
            goodsCell.isEndCell = YES;
        }else{
            goodsCell.isEndCell = NO;
        }
        goodsCell.goodsModel = goodModel.items[indexPath.row];
        return goodsCell;
    }
    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderPayModel class]]) {
        COrderPayCell *payCell = (COrderPayCell *)cell;
        payCell.payModel = self.dataArray[indexPath.section];
        return payCell;
    }
    
    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderNormalModel class]] && [self.cellArr[indexPath.section] isEqualToString:@"COrderNormalCell"]) {
        
        COrderNormalCell *norCell = (COrderNormalCell *)cell;
        norCell.norMaleModel = self.dataArray[indexPath.section];
        return norCell;
    }
    
    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderNormalModel class]] && [self.cellArr[indexPath.section] isEqualToString:@"COrderGoodsPriceCell"]) {
        
        COrderGoodsPriceCell *priceCell = (COrderGoodsPriceCell *)cell;
        priceCell.norMalModel = self.dataArray[indexPath.section];
        return priceCell;
    }
    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderNormalModel class]] && [self.cellArr[indexPath.section] isEqualToString:@"COrderReduceCell"]) {
        
        COrderReduceCell *reduecCell = (COrderReduceCell *)cell;
        reduecCell.norMalModel = self.dataArray[indexPath.section];
        return reduecCell;
    }
//    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderNormalModel class]] && [self.cellArr[indexPath.section] isEqualToString:@"COrderTureModelCell"]) {
//        
//        COrderTureModelCell *trueCell = (COrderTureModelCell *)cell;
//        trueCell.norMalModel = self.dataArray[indexPath.section];
//        return trueCell;
//    }
//    if ([self.dataArray[indexPath.section] isKindOfClass:[COrderNormalModel class]] && [self.cellArr[indexPath.section] isEqualToString:@"COrderCreateCell"]) {
//        
//        COrderCreateCell *creatCell = (COrderCreateCell *)cell;
//        creatCell.norMalModel = self.dataArray[indexPath.section];
//        return creatCell;
//    }
    return cell;

    
}
-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)paysuccessCallBack
{
    [self removeFromParentViewController];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end