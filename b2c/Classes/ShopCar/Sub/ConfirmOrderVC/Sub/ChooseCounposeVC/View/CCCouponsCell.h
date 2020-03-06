//
//  CCCouponsModel.h
//  b2c
//
//  Created by wangyuanfei on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
 
#import "BaseCell.h"
@class CCCouponsCell;
@protocol CCCouponsCellDelegate <NSObject>

-(void)chooseCouponseInCell:(CCCouponsCell*)cell;

@end


@class CCCouponsModel;
@interface CCCouponsCell : BaseCell
@property(nonatomic,weak)id  <CCCouponsCellDelegate> CouponsCellDelegate ;
@property(nonatomic,strong)CCCouponsModel * couponsModel ;
@end
