//
//  PopupCouponsView.m
//  b2c
//
//  Created by wangyuanfei on 6/15/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PopupCouponsView.h"
#import "ShopCoupon.h"
#import "SVCShop.h"
//#import "HCCouponCell.h"
#import "PopupCouponsCell.h"

@interface PopupCouponsView ()<UITableViewDelegate,UITableViewDataSource,PopupCouponsCellDelegate>
@property(nonatomic,weak)UIView * containerView ;
@property(nonatomic,weak)UILabel * titleLabel ;
@property(nonatomic,weak)UIButton * closeBtn ;
@property(nonatomic,weak)UITableView * tableView ;

@end

@implementation PopupCouponsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView * containerView = [[UIView alloc]init];
        containerView.backgroundColor = [UIColor whiteColor];
        self.containerView = containerView;
        CGFloat containerViewH = 280 ;
        CGFloat containerViewW = screenW;
        CGFloat containerViewX = 0 ;
        CGFloat containerViewY = screenH ;
        self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
        [self addSubview:containerView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.containerView.bounds.size.width, 44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"领取优惠券";
        self.titleLabel = titleLabel;
        [self.containerView addSubview:titleLabel];
        
        UIButton * closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.containerView.bounds.size.width-10 - 44, 0, 44, 44)];
        self.closeBtn = closeBtn ;
        [self.closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
//        [self.closeBtn setImage:[UIImage imageNamed:@"shutdown"] forState:UIControlStateNormal];

        [closeBtn addTarget:self action:@selector(dismissPopupCouponsView:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:closeBtn];
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.containerView.bounds.size.width, self.containerView.bounds.size.height - 44)];
        self.tableView = tableView;
        tableView.showsVerticalScrollIndicator=NO ;
        tableView.separatorStyle=0;
        tableView.rowHeight = 90*SCALE;
        [containerView addSubview:tableView];
        tableView.dataSource = self;
        tableView.delegate = self;
        
    }
    return self;
}

-(void)dismissPopupCouponsView:(UIButton*)sender
{
    if ([self.PopupCouponsDelegate respondsToSelector:@selector(disMissCouponseView:)]) {
        [self.PopupCouponsDelegate disMissCouponseView:self];
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行移除View");//设置代理
}


-(void)showContaintView{
    CGFloat containerViewH = 280 ;
    CGFloat containerViewW = self.bounds.size.width;
    CGFloat containerViewX = 0 ;
    CGFloat containerViewY = self.bounds.size.height -containerViewH ;
    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);

        

    //    self.containerView.mj_y=self.bounds.size.height - self.containerView.bounds.size.height;
}

-(void)dismissContaintView{
    //    self.containerView.mj_y=self.bounds.size.height;
    CGFloat containerViewH = 280 ;
    CGFloat containerViewW = self.bounds.size.width;
    CGFloat containerViewX = 0 ;
    CGFloat containerViewY = self.bounds.size.height ;

    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
}
-(void)dealloc{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"销毁");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopModel.coupons.count ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCoupon * coupon = self.shopModel.coupons[indexPath.row];
    
    PopupCouponsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[PopupCouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.PopupCouponsCellDelegate=self;
    cell.couponModel = coupon;
    return  cell;
}

-(void)gotCouponsAction:(PopupCouponsCell *)view{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理执行成功 , 执行领取优惠券操作");
    //cell的代理方法
    NSIndexPath * indexPath = [self.tableView indexPathForCell:view];
    HCCouponModel * model  = self.shopModel.coupons[indexPath.row];
    [[UserInfo shareUserInfo] gotCouponsWithCouponsID:model.ID success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
        model.take = YES;
        view.couponModel=model;
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"领取失败")
    }];
}

//-(void)showContaintViewAnimate:(BOOL)animate timeInterval:(NSUInteger)timeInterval{
//    CGFloat containerViewH = 280 ;
//    CGFloat containerViewW = self.bounds.size.width;
//    CGFloat containerViewX = 0 ;
//    CGFloat containerViewY = self.bounds.size.height -containerViewH ;
//    self.containerView.frame = CGRectMake(containerViewX, self.bounds.size.height, containerViewW, containerViewH);
//    [self.closeBtn setImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
//    if (animate) {
//        [UIView animateWithDuration:timeInterval animations:^{
//            self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
//        }];
//
//    }else{
//         self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
//    }
////    self.containerView.mj_y=self.bounds.size.height - self.containerView.bounds.size.height;
//}
//-(void)dismissContaintViewAnimate:(BOOL)animate timeInterval:(NSUInteger)timeInterval{
////    self.containerView.mj_y=self.bounds.size.height;
//    CGFloat containerViewH = 280 ;
//    CGFloat containerViewW = self.bounds.size.width;
//    CGFloat containerViewX = 0 ;
//    CGFloat containerViewY = self.bounds.size.height ;
//
//
//
//    if (animate) {
//        [UIView animateWithDuration:timeInterval animations:^{
//             self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
//        }];
//
//    }else{
//         self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
//    }
//}
@end
