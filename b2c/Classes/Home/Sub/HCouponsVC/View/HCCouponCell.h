//
//  HCCouponCell.h
//  b2c
//
//  Created by wangyuanfei on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"

typedef enum : NSUInteger {
    TicketDetail=0,
    GotTicket,
    ShareTicket
} TicketClickAction;
@class HCCouponCell;
@class HCCouponcellCompose;
@protocol HCCouponCellDelegate <NSObject>

-(void  )clickActionInCell:(HCCouponCell*)cell withActionType:(TicketClickAction)actionType ;
//-(void  )clickActionInCellCompose:(HCCouponcellCompose*)cellCompose withActionType:(TicketClickAction)actionType ;

@end

@class HCCouponModel;
@interface HCCouponCell : BaseCell
@property(nonatomic,strong)HCCouponModel * couponModel ;
@property(nonatomic,weak)HCCouponcellCompose * getClick ;

@property(nonatomic,weak) id <HCCouponCellDelegate> CouponCellDelegate ;
@end
