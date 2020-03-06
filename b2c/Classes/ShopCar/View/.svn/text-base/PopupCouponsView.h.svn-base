//
//  PopupCouponsView.h
//  b2c
//
//  Created by wangyuanfei on 6/15/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
    购物车弹出的优惠券视图
 */

#import "ActionBaseView.h"
@class PopupCouponsView;
@protocol PopupCouponsViewDelegate <NSObject>

-(void)disMissCouponseView:(PopupCouponsView*)view;

@end

@class SVCShop;

@interface PopupCouponsView : ActionBaseView
@property(nonatomic,strong)SVCShop * shopModel ;
@property(nonatomic,weak)id  <PopupCouponsViewDelegate> PopupCouponsDelegate ;
//-(void)showContaintViewAnimate:(BOOL)animate timeInterval:(NSUInteger)timeInterval;
//-(void)dismissContaintViewAnimate:(BOOL)animate timeInterval:(NSUInteger)timeInterval;
-(void)showContaintView;
-(void)dismissContaintView;
@end
